'use strict'
define (require) ->

  Backbone              = require 'backbone'
  Message               = require 'models/message'
  MessageView           = require 'views/messages/message'
  messagesListTemplate  = require 'templates/messages/messages_list'
  ebus                  = require('lib/event_bus')() # EventBus singelton.

  MessagesListView = Backbone.View.extend
    tagName: 'ul'

    template: messagesListTemplate

    initialize: () ->

      # Add new message to the list view as soon as it is added to the
      # collection.
      @.listenTo @.collection, 'add', @.addOne

      # When message arrives from the server socket we should add new
      # message model to the collection of messages.
      # ebus even 'message' is triggered by the Chat as soon as Chat gets
      # the event 'chat message' from the server.
      ebus.on 'message', (data) =>
        @.collection.add new Message(user: data.user, message: data.message)

    render: () ->

      # Initial element structure.
      @.$el.html @.template()

      # For each model in the collection
      # create messageView and append it to the current $el.
      @.addAll()

      return @

    addOne: (model) ->
      newMessage = new MessageView(model: model)
      @.$el.append newMessage.render().el

    addAll: () ->
      @.addOne(messageModel) for messageModel in @.collection.models

