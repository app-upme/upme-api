Rails.application.routes.draw do

  devise_for :coaches

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :coaches, only: [] do
        collection do
          post :sign_in, action: :create, controller: :sessions
          delete :sign_out, action: :destroy, controller: :sessions
        end
      end
      resources :groups

    end
  end

end
