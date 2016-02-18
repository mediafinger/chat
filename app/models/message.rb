class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  LIMIT = 5
  MAXIMUM_MESSAGE_LENGTH = 65535

  # use after_create_commit to ensure the Message was written to the DB
  # when using after_create the Job might not find the Message in the DB
  #
  after_create_commit { MessageBroadcastJob.perform_later self }

  validates :content, length: { in: 1..MAXIMUM_MESSAGE_LENGTH } # TODO handle exceptions & add frontend validation
  validates :room, presence: true

  scope :in_room,    ->(room_id) { where(room: room_id) }
  scope :latest,     -> { limit(LIMIT).order(created_at: :desc) }
  scope :older_than, ->(timestamp) { where("created_at < (?)", timestamp).limit(LIMIT).order(created_at: :desc) }
end
