class User < ApplicationRecord

  has_many :groups
  has_many :vo2max_trainings

  validates :name, :age, :gender, presence: true

  mount_uploader :avatar, AvatarUploader

end
