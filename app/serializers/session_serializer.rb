class SessionSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :token

  def token
    scope[:token]
  end
end
