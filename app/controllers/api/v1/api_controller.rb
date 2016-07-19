class Api::V1::ApiController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session

  respond_to :json

  # before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    # def configure_permitted_parameters
    #   devise_parameter_sanitizer.permit(:sign_up) do |coach_params|
    #     coach_params.permit(:name, :email, :password, :avatar)
    #   end
    # end

    # def devise_parameter_sanitizer
    #   if resource_class == Coach
    #     Coach::ParameterSanitizer.new(Coach, :coach, params)
    #   else
    #     super # Use the default one
    #   end
    # end
end
