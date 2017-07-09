class Api::V1::Groups::UsersController < Api::V1::ApiController

  def create
    @user = current_coach.groups.find_by(id: params[:group_id]).users.create user_params

    respond_with @user, location: ''
  end

  private

    def user_params
      params.permit(:name, :email, :avatar, :age, :gender, :started_training_at)
    end

    def fetch_group
      current_coach.groups.find_by id: params[:group_id]
    end

end
