'use strict'
define (require) ->

  Backbone        = require 'backbone'
  Message         = require 'models/message'
  messageTemplate = require 'templates/messages/message'

  MessageView = Backbone.View.extend

    template: messageTemplate

    render: () ->
      @.setElement @.template(@.model.attributes)
      return @
