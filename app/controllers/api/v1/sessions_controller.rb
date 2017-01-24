class Api::V1::SessionsController < Api::V1::ApiController

  skip_before_action :authenticate_coach_from_token, only: :create

  def create
    @coach = Coach.find_by(email: session_params[:email])
    return render_invalid_login unless @coach

    if @coach.valid_password? session_params[:password]
      sign_in @coach, store: false

      respond_with @coach, location: ''
    else
      return render_invalid_login
    end
  end

  def destroy
    render json: { foi: 'AEHOOOOOOOOOOOOOOOOOOOO' }
  end

  private

    def session_params
      params.permit(:password, :email)
    end

    def render_invalid_login
      render json: { errors: 'Invalid email or password' }, status: :unauthorized
    end

end
