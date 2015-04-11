define (require) ->

  io   = require('lib/socket')() # Get io singleton.
  ebus = require('lib/event_bus')() # EventBus singleton.

  class Chat
    constructor: () ->
      @.setupHandlers()

    sendMessage: (msg) ->
      io.emit 'message', msg

    joinUser: (user) ->
      io.emit 'join', user

    # User left when he closed browser page.
    # This event is caught on the server and emmited to the client.

    setupHandlers: () ->
      io.on 'message', (data) -> ebus.trigger 'message', data # {user: "name", message: "some message"}
      io.on 'join',    (user) -> ebus.trigger 'join',    user
      io.on 'left',    (user) -> ebus.trigger 'left',    user

  chat = new Chat

  () -> chat


