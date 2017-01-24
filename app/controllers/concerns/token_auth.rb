module TokenAuth
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_coach_from_token
  end

  protected

    def authenticate_coach_from_token
      coach_email = request.headers['HTTP_COACH_EMAIL'].presence
      coach = Coach.find_by(email: coach_email) if coach_email

      if coach && Devise.secure_compare(coach.authentication_token, request.headers['HTTP_COACH_TOKEN'])
        sign_in coach, store: false
      end
    end

end
