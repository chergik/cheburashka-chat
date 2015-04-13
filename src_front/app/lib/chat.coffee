define (require) ->

  io   = require('socketio') # Get io.
  ebus = require('lib/event_bus')() # EventBus singleton.

  class Chat
    constructor: () ->
      @io = io()
      @.setupIoHandlers()
      @.setupEventBusHandlers()

    sendMessage: (msg) ->
      @io.emit 'chat message', msg

    joinUser: (user) ->
      @io.emit 'join', user

    # User left when he closed browser page.
    # This event is caught on the server and emmited to the client.

    setupIoHandlers: () ->
      @io.on 'chat message', (data) -> ebus.trigger 'message', data # {user: "name", message: "some message"}
      @io.on 'join',         (user) -> ebus.trigger 'join',    user
      @io.on 'left',         (user) -> ebus.trigger 'left',    user

    setupEventBusHandlers: () ->
      ebus.on 'client:message', (msg) =>
        @.sendMessage msg

      ebus.on 'client:join', (user) =>
        @.joinUser user

