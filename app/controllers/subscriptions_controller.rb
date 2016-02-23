class SubscriptionsController < ApplicationController
  def destroy
    Subscription.where(user: @current_user, room_id: params[:room_id]).first.destroy
    redirect_to subscriptions_rooms_path
  end
end
