'use strict'
define (require) ->

  Backbone              = require 'backbone'
  UsersCollection       = require 'collections/users'
  MessagesCollection    = require 'collections/messages'
  MessageBoxView        = require 'views/messages/message_box'
  UsersListView         = require 'views/users/users_list'
  MessagesListView      = require 'views/messages/messages_list'
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
      chat.joinUser @username

      return @
