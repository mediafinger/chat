class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "room_channel", message: render_message(message)
  end

  private

  def render_message(message)
    # Rails 5 makes it easy to render a partial. Yay! :-)
    #
    ApplicationController.renderer.render(partial: "messages/message", locals: {message: message })
  end
end
