class Vo2maxTraining < ApplicationRecord

  belongs_to :user

  validates :user, :training_date, :distance, presence: true

end



