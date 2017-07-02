class Group < ApplicationRecord
  belongs_to :coach
  has_many :users

  validates :name, presence: true
end
