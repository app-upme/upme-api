class Vo2maxTraining < ApplicationRecord

  TRAINING_DURATION = 12.minutes

  belongs_to :user

  validates :user, :training_date, :distance, presence: true

  before_create :calculate_results

  private

  def calculate_results
    self.result = Uruz::Vo2max.calculate(distance)
    self.ranking = Uruz::Vo2max.classification(distance, user.age, user.gender.to_sym)
    self.average_speed = distance / TRAINING_DURATION
  end

end



