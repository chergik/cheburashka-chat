'use strict'

requirejs.config

  # From this dir we will load all app js files.
  # Like so: var MyCoolModule = require('some_amd_module_file_from_the_app_dir')
  baseUrl: 'javascripts/app'

  # Set module names and paths for out of the root libraries.
  paths:
    jquery:     '../lib/jquery'
    underscore: '../lib/underscore'
    backbone:   '../lib/backbone'
    socketio:   '../lib/socket.io'
    main:       '../main'

  # Setup dependant and other weird tricks.
  shim:

    # Handle backbone stuff.
    backbone:

      # Load dependencies asynchronously first.
      deps: ['jquery', 'underscore']
      exports: 'Backbone'

    # Map global underscore '_' to the local '_'.
    underscore:
      exports: '_'

    socketio:
      exports: 'io'

  # Weird trick to make require.js work and do not hang on lob loading.
  waitSeconds: 0

define (require) ->
  AppView = require 'views/app'
  $ ->
    appView = new AppView
    appView.render()

