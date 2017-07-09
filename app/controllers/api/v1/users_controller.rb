class Api::V1::UsersController < Api::V1::ApiController

  before_action :fetch_user

  def show
    respond_with @user, location: ''
  end

  def destroy
    @user.destroy

    respond_with @user, location: ''
  end

  def average_results
    @result = Vo2MaxAverage.new(trainings: @user.vo2max_trainings, title: @user.name, range: 15.day).call

    respond_with @result, location: ''
  end

  private

  def fetch_user
    @user = current_coach.treined_users.find_by(id: params[:id])
  end

end
