module JWTAuthenticable
  extend ActiveSupport::Concern

  ALG             = 'HS256'
  EXP             = 1.day
  RSH_EXP         = 2.day
  BASE_SESSION_ID = 0
  PADDING_ID      = 1
  MAX_SESSIONS    = 3

  included do
    after_save :set_empty_token_hash
    after_initialize :set_empty_token_hash

    serialize :tokens, JSON
  end

  def generate_new_token(with_session_id: nil)
    return if self.tokens.length >= MAX_SESSIONS && with_session_id.blank?

    session_id  = with_session_id || build_session_id
    expiration  = (Time.now.to_i + EXP.to_i)
    refresh_exp = (Time.now.to_i + RSH_EXP.to_i)

    self.tokens[ session_id ] = {
      token:         generate_jwt(with_expiration: expiration),
      refresh_token: generate_jwt(with_expiration: refresh_exp),
      expiry:        expiration
    }

    self.save
  end

  private

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
      return BASE_SESSION_ID if self.tokens.blank?

      max_id = self.tokens.max_by { |sid, s| sid.to_i }
      max_id.first.to_i + PADDING_ID
    end

    def set_empty_token_hash
      self.tokens ||= {} if has_attribute?(:tokens)
    end
end
