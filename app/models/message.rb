class Message < ApplicationRecord
  belongs_to :user

  LIMIT = 5

  # use after_create_commit to ensure the Message was written to the DB
  # when using after_create the Job might not find the Message in the DB
  #
  after_create_commit { MessageBroadcastJob.perform_later self }

  scope :latest,     -> { limit(LIMIT).order(created_at: :desc) }
  scope :older_than, ->(timestamp) { where("created_at < (?)", timestamp).limit(LIMIT).order(created_at: :desc) }
end
