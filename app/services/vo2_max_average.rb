class Vo2MaxAverage
  attr_reader :trainings

  class Range
    HALF  = 14.day
    MONTH = 30.day
    WEAK  = 7.day
  end

  def initialize(trainings:, title:, range:)
    @trainings = trainings
    @range     = range
    @title     = title
  end

  def call
    labels = ((Date.today - @range)..Date.today).map { |date| date.strftime('%d') }
    trainings_group = @trainings.group_by { |x| x.training_date.strftime('%d') }

    trainings_results = trainings_group.each_with_object({}) do |(day, trainings), result|
      average = trainings.sum(&:result) / trainings.size
      result[ day ] = average
    end

    data = labels.each_with_object({}) do |label, data|
      data[label] = trainings_results[label] if trainings_group[label]
    end

    { title: @title, labels: data.keys, data: data.values }
  end

end

