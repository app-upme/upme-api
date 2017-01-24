class Api::V1::ApiController < ApplicationController
  include TokenAuth

  protect_from_forgery with: :null_session
  respond_to :json

end
