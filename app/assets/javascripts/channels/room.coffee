App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    if data['message']
      $('#messages').prepend data['message']
    else if data['messages']
      $('#messages').append data['messages']

  speak: (message) ->
    @perform 'speak', message: message

  show_older: (timestamp) ->
    @perform 'show_older', timestamp: timestamp

# react to input submitted in form in views/rooms/show.html.haml
#
$(document).on 'keypress', 'input[class=js-room-new-message]', (event) ->
  if event.keyCode is 13  # return = send
    App.room.speak(event.target.value)
    event.target.value = ''
    event.preventDefault()

$(document).on "click", "a[class=js-room-show-more]", (event) ->
  $(event.target).hide(0)
  App.room.show_older $(this).data('timestamp')
  event.preventDefault()
