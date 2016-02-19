# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    # return false unless params[:room_id].present?

    stream_from "room_channel_#{params[:room_id]}"
    stream_from "private_channel_of_#{current_user.id}"

    # persist the subscriptions
    # because of the hacky way to display all rooms, the room_id might be 0
    Subscription.find_or_create_by(room_id: params[:room_id], user: current_user)
  end

  def unsubscribed
    # remove persisted the subscription
    Subscription.where(room_id: params[:room_id], user: current_user).destroy
  end

  def create_message(data)
    user = User.find data['current_user_id'].to_i

    if user == current_user
      Message.create!(
        content: data['message'],
        room_id: data['room_id'],
        user:    user,
      )
    end
  end

  def show_older_messages(data)
    MessagesBroadcastJob.perform_later(
      room_id:   data['room_id'],
      timestamp: data['timestamp'],
      user_id:   data['current_user_id'],
    )
  end

  def create_room(data)
    Room.create!(name: data['name'])
  end

  def show_more_rooms(data)
    RoomsBroadcastJob.perform_later(room_id: data['room_id'], user_id: data['current_user_id'])
  end
end
