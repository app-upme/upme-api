module DeviseModules
  extend ActiveSupport::Concern

  included do
    devise :database_authenticatable, :registerable,
           :rememberable, :validatable, :recoverable
  end

end
