class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar, :age, :gender, :started_training_at

  def avatar
    object.avatar.url
  end
end
