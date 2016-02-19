class RoomsBroadcastJob < ApplicationJob
  queue_as :default

  def perform(user_id:, room_id:)
    ActionCable.server.broadcast "private_channel_of_#{user_id}", rooms: render_rooms(room_id)
  end

  private

  def render_rooms(room_id)
    rooms = Room.after(room_id)

    ApplicationController.renderer.render(partial: "rooms/rooms", locals: { rooms: rooms })
  end
end
