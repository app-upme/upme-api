ActiveAdmin.register User do
  permit_params :name, :email, :gender, :started_training_at, :age, :avatar, :group_id

  show do
    columns do
      column do
        attributes_table do
          row :avatar do |user|
            image_tag user.avatar.url, size: 128
          end
          row :id
          row :name
          row :email
          row :gender
          row :group
          row :start_training_at
          row :created_at
          row :updated_at
        end
      end
    end
  end
end
