class User < ApplicationRecord
  extend Enumerize

  belongs_to :group
  has_many :vo2max_trainings, ->{ order(id: :desc) }

  validates :name, :age, :gender, presence: true

  enumerize :gender, in: [:male, :famale]

  mount_uploader :avatar, AvatarUploader
end
