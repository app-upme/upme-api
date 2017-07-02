ActiveAdmin.register Coach do
  permit_params :email, :name, :avatar, :password, :password_confirmation

  index do
    column :id
    column :name
    column :avatar
    column :email
    column :created_at
    column :updated_at
    actions
  end

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
          row :created_at
          row :updated_at
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :avatar
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
