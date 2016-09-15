module JWTAuth
  extend ActiveSupport::Concern

  included do
    after_action :update_auth_header
  end

  protected

    def update_auth_header
      # cannot save object if model has invalid params
      return unless @resource && @resource.valid? && @sid
      return if @resource.tokens[@sid].nil?

      # update the response header
      response.headers.merge!({
        'token'         => @token[:token].to_s,
        'refresh_token' => @token[:refresh_token].to_s,
        'expiry'        => @token[:expiry].to_s,
        'sid'           => @token[:sid].to_s
      })
    end

    def render_unauthorized_error
      render json: { errors: "Authorized users only." }, status: :unauthorized
    end

    def resource_sign_in(resource)
      @sid   = request.headers[:sid] || resource.default_sid
      @token = @resource.generate_new_token

      sign_in(resource, store: false)
    end

    def authenticate_from_token(resource)
      @resource_class = Devise::Mapping.new(resource, {}).to
      return render_unauthorized_error unless @resource_class

      @resource = @resource_class.find_by(email: request.headers[:uid])
      return render_unauthorized_error if @resource.blank?

      @sid   = request.headers[:sid]
      @token = request.headers[:token]

      if @resource.valid_token?(@token, @sid)
        @token = @resource.generate_new_token(with_sid: @sid)
        resource_sign_in(@resource)

      else
        render_unauthorized_error
      end
    end

    class_eval do
      Devise.mappings.each do |mapping|
        resource = mapping.first

        define_method("authenticate_#{resource}_from_token") do
          authenticate_from_token(resource)
        end
      end
    end

end
