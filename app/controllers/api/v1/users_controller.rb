class Api::V1::UsersController < Api::V1::ApiController

  before_action :fetch_user

  def show
    respond_with @user, location: ''
  end

  def destroy
    @user.destroy

    respond_with @user, location: ''
  end

  private

  def fetch_user
    @user = User.find_by(id: params[:id])
  end

end
