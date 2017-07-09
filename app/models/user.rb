class User < ApplicationRecord
  extend Enumerize

  belongs_to :group
  has_many :vo2max_trainings, ->{ order(id: :desc) }

  validates :name, :age, :gender, presence: true

  enumerize :gender, in: { male: 0, famale: 1 }

  mount_uploader :avatar, AvatarUploader
end
