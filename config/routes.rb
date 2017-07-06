Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :coach

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:show, :destroy] do
        scope module: :users do
          resources :vo2max_trainings, only: [:create, :destroy]
        end
      end

      resources :groups do
        scope module: :groups do
          resources :users, only: :create
        end
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
