Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :coaches
      resources :groups

      resources :coaches, only: :create do
        post :refresh_token, controller: :sessions, on: :collection

        collection do
          post :sign_in, action: :create, controller: :sessions
          delete :sign_out, action: :destroy, controller: :sessions
        end
      end

    end
  end

end
