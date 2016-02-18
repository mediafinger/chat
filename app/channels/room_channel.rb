# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
    stream_from "private_channel_of_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    user = User.find data['current_user_id'].to_i

    if user == current_user
      Message.create! content: data['message'], user: user
    end
  end

  def show_older(data)
    MessagesBroadcastJob.perform_later timestamp: data['timestamp'], user_id: data['current_user_id']
  end
end
