module JWTAuthenticable
  extend ActiveSupport::Concern

  ALG             = 'HS256'
  EXP             = 1.day
  RSH_EXP         = 2.day
  BASE_SESSION_ID = 0
  PADDING_ID      = 1

  included do
    before_create :generate_new_token

    serialize :tokens, JSON
  end

  def update_authentication_token(current_session_id=nil)
    ActiveRecord::Base.transaction do
      if current_session_id.present?
        self.tokens[ current_session_id ] = generate_new_token(with_id: current_session_id)
      else
        generate_new_token
      end

      self.save!
    end
  end

  private

    def generate_new_token(with_id: nil)
      session_id  = with_id || build_session_id
      expiration  = (Time.now.to_i + EXP.to_i)
      refresh_exp = (Time.now.to_i + RSH_EXP.to_i)

      session = {
        session_id => {
          token:         generate_jwt(with_expiration: expiration),
          refresh_token: generate_jwt(with_expiration: refresh_exp)
        }
      }

      # update token from current session
      if self.tokens.present? && self.tokens.has_key?(session_id.to_s)
        self.tokens[ session_id ] = session[ session_id ]

      # create a new session
      elsif self.tokens.present? && self.tokens.length > 0 && self.tokens.length < 2
        self.tokens.update session

      # create first session
      else
        self.tokens = session
      end
    end

    def generate_jwt(with_expiration: nil)
      payload = {
        exp: with_expiration,
        self.model_name.singular => {
          email: self.email
        }
      }

      JWT.encode(payload, Rails.application.secrets.secret_key_base, ALG)
    end

    def build_session_id
      self.tokens&.keys&.any? { |t| t.to_i >= BASE_SESSION_ID } ? (BASE_SESSION_ID + PADDING_ID) : BASE_SESSION_ID
    end
end
