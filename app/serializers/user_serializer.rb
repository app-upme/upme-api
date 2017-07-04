class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar, :age, :gender, :started_training_at, :group_id

  def avatar
    object.avatar.url
  end
end
