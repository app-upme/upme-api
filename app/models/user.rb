class User < ApplicationRecord

  validates :name, :age, :gender, presence: true

end
