class Room < ApplicationRecord
  has_many :messages
  has_many :subscriptions
  has_many :users, through: :subscriptions

  LIMIT = 5

  validates :name, length: { minimum: 3 }

  scope :latest, -> { order(id: :desc).limit(LIMIT) }
  scope :after, ->(last_id) { order(id: :desc).where("id < ?", last_id).limit(LIMIT) }
end
