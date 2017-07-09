class Vo2maxTraining < ApplicationRecord
  extend Enumerize

  TRAINING_DURATION = 12.minutes

  belongs_to :user

  validates :user, :training_date, :distance, presence: true

  enumerize :ranking, in: %w[very_weak weak middle good excellent higher]

  before_create :calculate_results

  private

  def calculate_results
    self.result = Uruz::Vo2max.calculate(distance)
    self.ranking = Uruz::Vo2max.classification(distance, user.age, user.gender.to_sym)
    self.average_speed = distance / TRAINING_DURATION
  end

end



