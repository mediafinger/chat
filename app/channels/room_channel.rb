# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"  # usually the name would contain some id
    stream_from "private_channel_of_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = data['message']['data']
    user_id = data['message']['current_user_id']
    user = User.find(user_id.to_i)

    if user == current_user
      Message.create! content: message, user: User.find(user_id.to_i)
    end
  end

  def show_older(data)
    timestamp = data['timestamp']['timestamp']
    user_id = data['timestamp']['current_user_id']

    MessagesBroadcastJob.perform_later timestamp: timestamp, user_id: user_id
  end
end
