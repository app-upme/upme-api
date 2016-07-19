class Vo2maxTraining < ApplicationRecord

  belongs_to :user

  validates :user, :training_date, :distance,
            :average_speed, :result, :ranking, presence: true

end



