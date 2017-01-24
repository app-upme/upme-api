Rails.application.routes.draw do

  devise_for :coach

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :groups

      resources :coaches, only: :create do
        collection do
          post :sign_in, action: :create, controller: :sessions
          delete :sign_out, action: :destroy, controller: :sessions
        end
      end

    end
  end

end
