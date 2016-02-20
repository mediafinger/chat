App.room_id = document.location.pathname.split("/").pop() # retrieve the room_id

# If App.room_id is undefined, the user is not in a room.
# In this case we assume the user is on the rooms#index - and we set the fake room_id 0.
# We use this channel to handle creation of new rooms and displaying the list of all rooms.
# TODO This looks hacky and should be refactored:
# all the functions concerning messages should be separated from the function concerning rooms.
#
App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: App.room_id || 0 },
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
    else if data['room']
      $('#rooms').prepend data['room']
    else if data['rooms']
        $('#rooms').append data['rooms']

  create_message: (data) ->
    @perform 'create_message', data

  show_older_messages: (data) ->
    @perform 'show_older_messages', data

  create_room: (data) ->
    @perform 'create_room', data

  show_more_rooms: (data) ->
    @perform 'show_more_rooms', data

# react to input submitted in form in views/rooms/show.html.haml
#
## Messages:
#
$(document).on 'keydown', 'textarea[class=js-room-new-message]', (event) ->
  # SHIFT + ENTER => line break | ENTER => send
  if !event.shiftKey && event.keyCode is 13 && event.target.value
      current_user_id = $('meta[name=current-user]').attr('id')
      App.room.create_message { room_id: App.room_id, current_user_id: current_user_id, message: event.target.value }
      event.target.value = ''
      event.preventDefault()
      event.stopPropagation()

$(document).on "click", "a[class=js-room-show-more]", (event) ->
  $(event.target).hide(0)
  current_user_id = $('meta[name=current-user]').attr('id')
  App.room.show_older_messages { room_id: App.room_id, current_user_id: current_user_id, timestamp: $(this).data('timestamp') }
  event.preventDefault()

## Rooms:
#
$(document).on 'keypress', 'input[class=js-rooms-new-room]', (event) ->
  if event.target.value && event.keyCode is 13  # return = send
    App.room.create_room { name: event.target.value }
    event.target.value = ''
    event.preventDefault()

$(document).on "click", "a[class=js-rooms-show-more]", (event) ->
  $(event.target).hide(0)
  current_user_id = $('meta[name=current-user]').attr('id')
  App.room.show_more_rooms { current_user_id: current_user_id, room_id: $(this).data('last-id') }
  event.preventDefault()
