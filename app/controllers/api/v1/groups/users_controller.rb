class Api::V1::Groups::UsersController < Api::V1::ApiController

  def create
    @user = Group.find_by(id: params[:group_id]).users.create user_params

    respond_with @user, location: ''
  end

  private

    def user_params
      params.permit(:name, :email, :avatar, :age, :gender)
    end

    def fetch_group
      current_coach.groups.find_by id: params[:group_id]
    end

end
