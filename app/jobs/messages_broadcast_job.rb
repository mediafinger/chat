class MessagesBroadcastJob < ApplicationJob
  queue_as :default

  def perform(timestamp:, user_id:)
    ActionCable.server.broadcast "room_channel", messages: render_messages(timestamp)
  end

  private

  def render_messages(timestamp)
    messages = Message.older_than Time.zone.parse(timestamp)

    ApplicationController.renderer.render(partial: "messages/messages", locals: { messages: messages })
  end
end
