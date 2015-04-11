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
    redisClient.sadd 'users', username, cb
  # New browser socket.io connection established.
  io.on 'connection', (client) ->

    console.log "Client connected..."

    # Client disconnected (e.g. user closed browser).
    client.on 'disconnect', ->
      return if not client.name

      # Emit message so that remote clients remove user from the lists.
      client.broadcast.emit 'left', client.name

      # Tell other users, that this one left.
      client.broadcast.emit 'message', "User #{client.name} left "

      # Remove user from the Redis.
      redisClient.srem 'users', client.name

    # Client sent chat message.
    client.on 'message', (msg) ->
      console.log "#{client.name}:#{msg}"
      addMessage client.name, msg
      message = {user: client.name, message: msg}
      client.broadcast.emit 'message', message
      client.emit 'message', message

    # Client joined (e.g. officially joined the chat by clicking join).
    client.on 'join', (username) ->

      # Store client user name in the corresponding client socket.
      client.name = username

      # Add user to Redis and message other users that newbie joined.
      addUser client.name, (error, value) ->

        greeting = "User #{client.name} joined."
        console.log greeting

        # Notify other chat members that new user joined.
        client.broadcast.emit 'join',    client.name
        client.broadcast.emit 'message', greeting

        # For each member stored in Redis.
        redisClient.smembers 'users', (err, users) ->

          # Notify current new user about all present chat members.
          client.emit('join', user) for user in users.reverse()

          # Give the last N messages to the joined user.
          redisClient.lrange 'messages', 0, -1, (err, messages) ->
            unless err?
              for message in messages.reverse()
                message = JSON.parse message
                client.emit 'message', {user: message.name, message: message.data}
            else
              console.log "ERROR: #{err}"
    , null

module.exports = chatserver
