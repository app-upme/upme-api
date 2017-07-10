class Group < ApplicationRecord
  belongs_to :coach
  has_many :users, dependent: :destroy

  validates :name, presence: true

  def trainings
    user_ids = users.pluck(:id)
    Vo2maxTraining.where(user_id: user_ids)
  end
end
