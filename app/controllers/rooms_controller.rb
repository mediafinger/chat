class RoomsController < ApplicationController
  def show
    @messages = Message.latest
  end
end
