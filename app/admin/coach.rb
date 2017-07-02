ActiveAdmin.register Coach do
  index do
    column :id
    column :name
    column :avatar
    column :email
    column :created_at
    column :updated_at
    actions
  end
end
