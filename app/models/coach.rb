class Coach < ActiveRecord::Base
  include TokenAuthentication

  devise :database_authenticatable, :registerable, :recoverable, :validatable

  has_many :groups

  validates :name, :email, presence: true

  mount_uploader :avatar, AvatarUploader

  def treined_users
    User.where(group_id: groups)
  end

  def user_trainings
    user_ids = User.select(:id).where(group_id: groups)
    Vo2maxTraining.where(user_id: user_ids)
  end
end
