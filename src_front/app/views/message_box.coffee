'use strict'
define (require) ->

  Backbone            = require 'backbone'
  messageBoxTemplate  = require 'templates/message_box'
  chat                = require('lib/chat')() # chat singleton.

  MessageBox = Backbone.View.extend

    template: messageBoxTemplate

    initialize: () ->

    events:
      'submit form[name=send_message]': 'sendMessage'

    sendMessage: (e) =>
      e.preventDefault()
      @chat.sendMessage currentMessage()

    currentMessage: () ->
      @msgBox.val()

    render: () ->
      @.$el.append @.template()
      @msgBox = @.$el.find('inpu[name=message]')
      return @
