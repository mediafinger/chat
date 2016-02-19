class SubscriptionsController < ApplicationController
  def destroy
    Subscription.where(user: @current_user, room_id: params[:room_id]).first.destroy
    head 204 # TODO send feedback to the user (atm the page has to be reloaded)
  end
end
