class Coach < ActiveRecord::Base
  include DeviseModules

  has_many :groups

  validates :name, :email, presence: true

  mount_uploader :avatar, AvatarUploader

end
