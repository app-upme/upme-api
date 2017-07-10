class User < ApplicationRecord
  extend Enumerize

  belongs_to :group
  has_many :vo2max_trainings, -> { order(id: :desc) }, dependent: :destroy

  validates :name, :age, :gender, presence: true

  enumerize :gender, in: %w[male famale]

  mount_uploader :avatar, AvatarUploader

  def average_result
    vo2max_trainings.sum(:result) / vo2max_trainings.count if vo2max_trainings.present?
  end
end
