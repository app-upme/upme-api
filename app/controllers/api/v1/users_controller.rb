class Api::V1::UsersController < Api::V1::ApiController

  def show
    @user = User.find_by(id: params[:id])

    respond_with @user, location: ''
  end

end
