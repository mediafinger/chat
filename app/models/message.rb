class Message < ApplicationRecord
  # use after_create_commit to ensure the Message was written to the DB
  # when using after_create the Job might not find the Message in the DB
  #
  after_create_commit { MessageBroadcastJob.perform_later self }

  scope :latest, -> { limit(25).order(created_at: :desc) }
end
