class CoachSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar_url, :authentication_token

  def avatar_url
    object.avatar.url
  end

end
