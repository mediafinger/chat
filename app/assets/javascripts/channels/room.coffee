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

  speak: (data) ->
    @perform 'speak', data

  show_older: (data) ->
    @perform 'show_older', data

# react to input submitted in form in views/rooms/show.html.haml
#
$(document).on 'keypress', 'input[class=js-room-new-message]', (event) ->
  if event.target.value && event.keyCode is 13  # return = send
    current_user_id = $('meta[name=current-user]').attr('id')
    App.room.speak { current_user_id: current_user_id, message: event.target.value }
    event.target.value = ''
    event.preventDefault()

$(document).on "click", "a[class=js-room-show-more]", (event) ->
  $(event.target).hide(0)
  current_user_id = $('meta[name=current-user]').attr('id')
  App.room.show_older { current_user_id: current_user_id, timestamp: $(this).data('timestamp') }
  event.preventDefault()
