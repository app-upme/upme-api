class Api::V1::Groups::UsersController < Api::V1::ApiController

  before_action :fetch_group

  def create
    @user = @group.users.create user_params

    respond_with @user, location: ''
  end

  def index
    @users = @group.users

    respond_with @users, location: ''
  end

  private

    def user_params
      params.permit(:name, :email, :avatar, :age, :gender, :started_training_at)
    end

    def fetch_group
      @group = current_coach.groups.find_by(id: params[:group_id])
    end

end
