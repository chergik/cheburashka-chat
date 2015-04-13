'use strict'
define (require) ->

  Backbone            = require 'backbone'
  messageBoxTemplate  = require 'templates/messages/message_box'
  ebus                = require('lib/event_bus')()

  MessageBox = Backbone.View.extend

    template: messageBoxTemplate

    initialize: () ->

    events:
      'submit form[name=send_message]': 'sendMessage'

    sendMessage: (e) ->
      e.preventDefault()
      ebus.trigger 'client:message', @.currentMessage()
      @.clearBox()
      false

    currentMessage: () ->
      @msgBox.val()

    clearBox: () ->
      @msgBox.val ''

    render: () ->
      @.$el.append @.template()
      @msgBox = @.$el.find('input[name=message]')
      return @
