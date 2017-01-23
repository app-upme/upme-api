class Api::V1::ApiController < ApplicationController
  include JWTAuth

  protect_from_forgery with: :null_session
  respond_to :json

  before_action :authenticate_coach_from_token

end
