class Room < ApplicationRecord
  has_many :messages
  has_many :subscriptions
  has_many :users, through: :subscriptions

  LIMIT = 5

  after_create_commit { RoomBroadcastJob.perform_later self }

  validates :name, length: { minimum: 3 }

  scope :after, ->(last_id) { not_private.order(id: :desc).where("id < ?", last_id).limit(LIMIT) }
  scope :latest, -> { not_private.order(id: :desc).limit(LIMIT) }
  scope :not_private, -> { where(private: false) }
  scope :subscriptions, ->(user_id) { joins(:subscriptions).where(subscriptions: {user_id: user_id}).order(name: :asc) }

  # TODO use existing private chat if it already exists
  def create_private_room_for(user_a, user_b)
    room = Room.create!(private: true, name: "private: #{[user_a.name, user_b.name].sort.join(' & ')}")

    Subscription.find_or_create_by(room: room, user: user_b)
    Subscription.find_or_create_by(room: room, user: user_a)
  end
end
