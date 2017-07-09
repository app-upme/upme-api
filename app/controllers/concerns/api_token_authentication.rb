include APICommonErrors

module APITokenAuthentication
  extend ActiveSupport::Concern

  def authenticate_from_token!(model)
    model_name = model.name.upcase

    request_email = request.headers["HTTP_#{model_name}_EMAIL"].presence
    request_token = request.headers["HTTP_#{model_name}_TOKEN"]
    user          = request_email && model.find_by(email: request_email)

    return render_unauthorized_error if user.blank? || !user.token_match?( request_token )

    sign_in user, store: false
  end

end
