class MessagesBroadcastJob < ApplicationJob
  queue_as :default

  def perform(timestamp:, user_id:, room_id:)
    ActionCable.server.broadcast "private_channel_of_#{user_id}", messages: render_messages(room_id, timestamp)
  end

  private

  def render_messages(room_id, timestamp)
    messages = Message.in_room(room_id).older_than Time.zone.parse(timestamp)

    ApplicationController.renderer.render(partial: "messages/messages", locals: { messages: messages })
  end
end
