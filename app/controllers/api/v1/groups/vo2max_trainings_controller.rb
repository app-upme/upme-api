class Api::V1::Groups::Vo2maxTrainingController < Api::V1::ApiController

  def index

  end

  def show
    fetch_user
  end

  def create
    @training = fetch_user.vo2max_trainings.create vo2_max_training_params

    respond_with @training, location: ''
  end

  private

    def fetch_group
      current_coach.groups.find_by id: params[:group_id]
    end

    def fetch_user
      fetch_group.users.find_by id: params[:user_id]
    end

    def vo2_max_training_params
      params.permit()
    end

end
