class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :avatar, :age, :gender, :started_training_at,
             :group_id, :last_training_date, :last_ranking, :average_result, :links

  has_many :vo2max_trainings

  def avatar
    object.avatar.url
  end

  def started_training_at
    object.started_training_at.strftime('%d/%m/%Y') if object.started_training_at.present?
  end

  def last_training_date
    if object.vo2max_trainings.present?
      object.vo2max_trainings.last.created_at.strftime('%d/%m/%Y')
    else
      '--/--/----'
    end
  end

  def last_ranking
    if object.vo2max_trainings.present?
      object.vo2max_trainings.last.ranking.text
    else
      '--'
    end
  end

  def average_result
    object.average_result&.round(4) || '--'
  end

  def links
    { vo2max_trainings: Rails.application.routes.url_helpers.api_v1_group_users_path(object.id) }
  end
end
