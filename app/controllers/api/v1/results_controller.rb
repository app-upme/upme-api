class Api::V1::ResultsController < Api::V1::ApiController

  def index
    @result = Vo2MaxAverage.new(trainings: Vo2maxTraining.all, title: 'Geral', range: 15.day).call

    respond_with @result, location: ''
  end

end
