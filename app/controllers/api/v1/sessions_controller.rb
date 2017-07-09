class Api::V1::SessionsController < Api::V1::ApiController

  skip_before_action :authenticate_coach_from_token!, only: :create

  before_action :find_coach

  def create
    return render_unauthorized_error if @coach.nil? || !@coach.valid_password?( params[:coach][:password] )

    headers = @coach.refresh_token
    sign_in @coach, store: false
    device_builder if params[:device].present?

    respond_with @coach, location: '', serializer: SessionSerializer, scope: { token: headers[:token] }
  end

  private

  def find_coach
    @coach = Coach.find_for_database_authentication(email: params[:coach][:email])
  end

end
