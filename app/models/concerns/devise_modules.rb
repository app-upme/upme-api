module DeviseModules
  extend ActiveSupport::Concern

  included do
    devise :database_authenticatable, :registerable, :rememberable,
           :validatable, :recoverable, :omniauthable
    include DeviseTokenAuth::Concerns::User
  end

end
