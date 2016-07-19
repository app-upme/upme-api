Rails.application.routes.draw do

  mount_devise_token_auth_for 'Coach', at: 'api/v1/coach/auth', skip: [:omniauth_callbacks]

  # as :coach do
  #   # Define routes for coach within this block.
  # end

  namespace :api do
    namespace :v1 do

      resources :coaches
      resources :users
      resources :coaches

    end
  end

end
