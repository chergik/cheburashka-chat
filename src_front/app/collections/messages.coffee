'use strict'
define (require) ->

  Backbone    = require 'backbone'
  Message     = require 'models/message'

  MessagesCollection = Backbone.Collection.extend
    model: Message

