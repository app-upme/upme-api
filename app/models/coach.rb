class Coach < ActiveRecord::Base
  include TokenAuthentication

  devise :database_authenticatable, :registerable, :recoverable, :validatable

  has_many :groups

  validates :name, :email, presence: true

  mount_uploader :avatar, AvatarUploader
end
