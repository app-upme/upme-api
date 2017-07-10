class Api::V1::ResultsController < Api::V1::ApiController

  def index
    @result = Vo2MaxAverage.new(trainings: current_coach.user_trainings,
                                title: 'Geral',
                                range: 15.day).call

    respond_with @result, location: ''
  end

end
