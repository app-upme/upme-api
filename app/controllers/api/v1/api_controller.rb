class Api::V1::ApiController < ApplicationController
  include APITokenAuthentication

  protect_from_forgery with: :null_session
  respond_to :json

  before_action :authenticate_coach_from_token!

  private

  def authenticate_coach_from_token!
    authenticate_from_token! Coach
  end

end
