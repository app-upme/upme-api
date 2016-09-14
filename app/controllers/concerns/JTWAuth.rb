module JWTAuth
  extend ActiveSupport::Concern

  included do
    before_action :set_request_start
    after_action :update_auth_header
  end

  protected

    def set_request_start
      # @resource =
    end

    def update_auth_header
      # cannot save object if model has invalid params
      return unless @resource and @resource.valid? and @client_id

      # Generate new client_id with existing authentication
      @client_id = nil unless @used_auth_by_token

      if @used_auth_by_token and not DeviseTokenAuth.change_headers_on_each_request
        # should not append auth header if @resource related token was
        # cleared by sign out in the meantime
        return if @resource.reload.tokens[@client_id].nil?

        auth_header = @resource.build_auth_header(@token, @client_id)

        # update the response header
        response.headers.merge!(auth_header)

      else

        # Lock the user record during any auth_header updates to ensure
        # we don't have write contention from multiple threads
        @resource.with_lock do
          # should not append auth header if @resource related token was
          # cleared by sign out in the meantime
          return if @used_auth_by_token && @resource.tokens[@client_id].nil?

          # determine batch request status after request processing, in case
          # another processes has updated it during that processing
          @is_batch_request = is_batch_request?(@resource, @client_id)

          auth_header = {}

          # extend expiration of batch buffer to account for the duration of
          # this request
          if @is_batch_request
            auth_header = @resource.extend_batch_buffer(@token, @client_id)

          # update Authorization response header with new token
          else
            auth_header = @resource.create_new_auth_token(@client_id)

            # update the response header
            response.headers.merge!(auth_header)
          end

        end # end lock

      end

    end

end
