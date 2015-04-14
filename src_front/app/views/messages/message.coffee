'use strict'
define (require) ->

  Backbone        = require 'backbone'
  Message         = require 'models/message'
  messageTemplate = require 'templates/messages/message'

  MessageView = Backbone.View.extend
    tagName: 'li'

    className: 'message'

    template: messageTemplate

    render: () ->
      @.$el.html @.template(@.model.attributes)
      return @
