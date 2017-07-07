class Vo2maxTrainingSerializer < ActiveModel::Serializer
  attributes :id, :training_date, :distance, :average_speed, :result, :ranking, :user_id

  def training_date
    object.training_date.strftime('%d/%m/%Y')
  end

  def distance
    "#{object.distance} m"
  end

  def average_speed
    "#{object.average_speed.round} km/h"
  end
end
