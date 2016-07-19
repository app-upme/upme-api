Rails.application.routes.draw do

  mount_devise_token_auth_for 'Coach', at: 'api/v1/coaches/auth', defaults: { format: :json },
    controllers: {
      registrations: 'api/v1/coaches/registrations'
    },
    skip: [:omniauth_callbacks]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :coaches, only: []

    end
  end

end
