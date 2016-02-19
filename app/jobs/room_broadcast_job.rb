class RoomBroadcastJob < ApplicationJob
  queue_as :default

  def perform(room)
    ActionCable.server.broadcast "room_channel_0", room: render_room(room)
  end

  private

  def render_room(room)
    # Rails 5 makes it easy to render a partial. Yay! :-)
    #
    ApplicationController.renderer.render(partial: "rooms/room", locals: {room: room })
  end
end
