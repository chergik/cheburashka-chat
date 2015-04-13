'use strict'

redis   = require 'redis'

# Connection to the redis.
redisClient = redis.createClient()

# Chat server.
chatserver = (io) ->

  # Clear all messages.
  #redisClient.del 'messages', (err,resp) -> console.log("All messages deleted.")
  #redisClient.del 'users',    (err,resp) -> console.log("All users deleted.")

  # Add message.
  addMessage = (name, data) ->
    redisClient.lpush 'messages'
      , JSON.stringify(name: name, data: data)
      , (err, response) ->
          # When message added to Redis, trim messages range.
          redisClient.ltrim 'messages', 0, 9

  # Add user.
  addUser = (username, cb) ->

    # If given username is already in the set, refuse!
    console.log "check if user \"#{username}\" is member"
    redisClient.sismember 'users', username, (err, isMember) =>
      console.log (if isMember then "already exists" else "valid name")
      if isMember then cb(true, null)
      else redisClient.sadd 'users', username, cb

  # New browser socket.io connection established.
  io.on 'connection', (client) ->

    console.log "Client connected..."

    # Client disconnected (e.g. user closed browser).
    client.on 'disconnect', ->
      console.log "Client disconnected: #{client.name}"
      return if not client.name

      # Emit message so that remote clients remove user from the lists.
      client.broadcast.emit 'left', client.name

      # Tell other users, that this one left.
      client.broadcast.emit 'chat message', {user: 'chatbot', message: "User #{client.name} left"}

      # Remove user from the Redis.
      redisClient.srem 'users', client.name

    # Client sent chat message.
    client.on 'chat message', (msg) ->
      console.log "#{client.name}:#{msg}"
      addMessage client.name, msg
      message = {user: client.name, message: msg}
      client.broadcast.emit 'chat message', message
      client.emit 'chat message', message

    # Client joined (e.g. officially joined the chat by clicking join).
    client.on 'join', (username) ->

      # Store client user name in the corresponding client socket.
      client.name = username

      # Add user to Redis and message other users that newbie joined.
      addUser client.name, (error, value) ->

        if error
          console.log "ERROR"
          client.emit 'notification',
            type:     'warning'
            message:  "Sorry, user name \"#{username}\" is taken. Please choose another one."
          return

        greeting = "User #{client.name} joined."
        console.log greeting

        # Notify other chat members that new user joined.
        client.broadcast.emit 'join',         client.name
        client.broadcast.emit 'chat message', {user: 'chatbot', message: greeting}

        # Store join message in the backlog.
        addMessage 'chatbot', greeting

        # For each member stored in Redis.
        redisClient.smembers 'users', (err, users) ->

          # Notify current new user about all present chat members.
          client.emit('join', user) for user in users.reverse()

          # Give the last N messages to the joined user.
          redisClient.lrange 'messages', 0, -1, (err, messages) ->
            unless err?
              for message in messages.reverse()
                message = JSON.parse message
                client.emit 'chat message', {user: message.name, message: message.data}

              # Welcome new user.
              client.emit 'chat message',
                user: 'chatbot', message: "Welcome to the chat #{client.name}!"

            else
              console.log "ERROR: #{err}"
    , null

module.exports = chatserver

