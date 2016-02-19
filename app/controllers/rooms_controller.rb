class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:room_id])
    @messages = Message.in_room(@room.id).latest
  end

  def index
    @rooms = Room.latest
  end
end
