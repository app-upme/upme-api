class Api::V1::SessionsController < Api::V1::ApiController

  skip_before_action :authenticate_coach_from_token, only: :create

  def create
    @resource = Coach.find_by(email: session_params[:email])
    return render_invalid_login unless @resource

    if @resource.valid_password? session_params[:password]
      resource_sign_in(@resource)

      render json: @resource, status: :ok
    else
      return render_invalid_login
    end
  end

  def destroy
    render json: { foi: 'AEHOOOOOOOOOOOOOOOOOOOO' }
  end

  def refresh_token
  end

  private

    def session_params
      params.permit(:password, :email)
    end

    def render_invalid_login
      render json: { errors: 'Invalid email or password' }, status: :unauthorized
    end

end
