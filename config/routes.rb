Rails.application.routes.draw do

  mount_devise_token_auth_for 'coach', at: 'api/v1/coach/auth'

  as :coach do
    # Define routes for coach within this block.
  end

end
