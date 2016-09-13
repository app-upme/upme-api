Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :coaches, only: []
      resources :groups

    end
  end

end
