class Coach < ActiveRecord::Base
  include DeviseModules

  has_many :groups

  validates :name, :email, presence: true

  mount_uploader :avatar, AvatarUploader

  # Serialize devise token auth response
  def token_validation_response
    CoachSerializer.new(self, root: false)
  end

end
