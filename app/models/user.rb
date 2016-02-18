class User < ApplicationRecord
  has_many :messages
  has_many :subscriptions
  has_many :rooms, through: :subscriptions

  validates :name, length: { minimum: 3 }
end
