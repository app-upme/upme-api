Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :coach

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: :show

      resources :groups do
        resources :users, only: :create
      end

      resources :coaches, only: :create do
        collection do
          post :sign_in, action: :create, controller: :sessions
          delete :sign_out, action: :destroy, controller: :sessions
        end
      end

    end
  end

end
