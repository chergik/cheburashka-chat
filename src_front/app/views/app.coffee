'use strict'
define (require) ->

  Backbone              = require 'backbone'
  UsersCollection       = require 'collections/users'
  MessagesCollection    = require 'collections/messages'
  MessageBoxView        = require 'views/messages/message_box'
  UsersListView         = require 'views/users/users_list'
  MessagesListView      = require 'views/messages/messages_list'
  appTemplate           = require 'templates/app'
  Chat                  = require('lib/chat') # chat.
  ebus                  = require('lib/event_bus')() # ebus singleton.

  AppView = Backbone.View.extend
    el: '#app'
    template: appTemplate

    initialize: () ->
      chat = new Chat()

    render: () ->

      # Users in the chat room.
      usersListView = new UsersListView(collection: new UsersCollection())

      # Messages backlog.
      messagesListView = new MessagesListView(collection: new MessagesCollection())

      # Create message box controls.
      messageBoxView = new MessageBoxView()

      # Get user's name first.
      @username = prompt "What is your name?"

      @.$el.html @.template(user: @username)
      @.$el.find('#users-list').append    usersListView.render().el
      @.$el.find('#messages-list').append messagesListView.render().el
      @.$el.find('#message-box').append   messageBoxView.render().el

      # Add user to the chatroom.
      ebus.trigger 'client:join', @username

      return @
