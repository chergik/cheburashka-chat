'use strict'
define (require) ->

  Backbone              = require 'backbone'
  UsersCollection       = require 'collections/users'
  MessagesCollection    = require 'collections/messages'
  MessageBoxView        = require 'views/message_box'
  chat                  = require('lib/chat')() # chat singleton.

  AppView = Backbone.View.extend
    el: '#app'

    initialize: () ->

    render: () ->

      # Get user's name first.
      @username = prompt "What is your name?"

      # Users in the chat room.
      usersListView = new UsersListView(collection: new UsersCollection())
      @.$el.append usersListView.render().el

      # Messages backlog.
      messagesListView = new MessagesListView(collection: new MessagesCollection())
      @.$el.append messagesListView.render().el

      # Create message box controls.
      messageBoxView = new MessageBoxView()
      @.$el.append messageBoxView.render().el

      # Add user to the chatroom.
      chat.join @username

      return @



      ###
      socket = io()
      username = prompt "What is your name?"

      $('h2.username').text username
      $('title').text "Chat: #{username}"
      form = $('form[name="send_message"]')
      message = form.find 'input[name="message"]'

      addMessage = (msg) ->
        $('ul.messages').append $("<li class='message'>").html(msg)

      addUser = (user) ->
        $('ul.users').append $("<li class='user' data-name='#{user}'>")
          .html(user)

      remUser = (username) ->
        $("ul.users li[data-name=#{username}]").remove()

      socket.on 'remove user', remUser

      socket.on 'chat message', addMessage

      socket.on 'join', addUser

      form.submit (e) ->
        e.preventDefault()
        socket.emit 'chat message', $(message).val()
        $(message).val ''
        false

      socket.emit 'join', username
      ###
