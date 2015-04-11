// Generated by CoffeeScript 1.9.0
(function() {
  'use strict';
  define(function(require) {
    var Backbone, Message, MessageView, messageTemplate;
    Backbone = require('backbone');
    Message = require('models/message');
    messageTemplate = require('templates/message');
    return MessageView = Backbone.View.extend({
      tagName: 'li',
      template: messageTemplate,
      render: function() {
        this.$el.html(this.template(this.model.attributes));
        return this;
      }
    });
  });

}).call(this);