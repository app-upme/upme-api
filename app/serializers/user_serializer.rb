class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar, :age, :gender, :started_training_at, :group_id, :links

  has_many :vo2max_trainings

  def avatar
    object.avatar.url
  end

  def started_training_at
    object.started_training_at.strftime('%d/%m/%Y') if object.started_training_at.present?
  end

  def links
    { vo2max_trainings: Rails.application.routes.url_helpers.api_v1_group_users_path(object.id) }
  end
end
