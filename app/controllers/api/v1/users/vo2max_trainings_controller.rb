class Api::V1::Users::Vo2maxTrainingsController < Api::V1::ApiController

  before_action :fetch_user

  def create
    @vo2max_training = @user.vo2max_trainings.create vo2max_training_params

    respond_with @vo2max_training, location: ''
  end

  def destroy
    @vo2max_training = @user.vo2max_trainings.find_by(id: params[:id])
    @vo2max_training.destroy

    respond_with @vo2max_training, location: ''
  end

  private

  def vo2max_training_params
    params.require(:vo2max_training).permit(:distance, :training_date)
  end

  def fetch_user
    @user = User.find_by(id: params[:user_id])
  end

end
