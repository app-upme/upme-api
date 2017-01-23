class Api::V1::CoachesController < Api::V1::ApiController

  skip_before_action :authenticate_coach_from_token, only: :create

  def create
    @coach = Coach.create(coach_params)

    respond_with @coach, location: ''
  end

  private

    def coach_params
      params.permit(:name, :email, :avatar, :password)
    end

end
