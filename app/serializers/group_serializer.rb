class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :users_count, :links

  has_many :users

  def links
    { users: Rails.application.routes.url_helpers.api_v1_group_users_path(object.id) }
  end

  def users_count
    object.users.count
  end
end
