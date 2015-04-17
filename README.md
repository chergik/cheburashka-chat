# cheburashka-chat
## Tech involved:
  - Node.js
  - Express.js
  - common.js
  - socket.io
  - require.js (client side)
  - Backbone
  - jQuery
  - Bootstrap
  - Jade (backend & clientside precompiled to javascript functions with gulp-jade)
  - coffeescript (backend/frontend)
  - Redis (to store user sets and list of chat messages)

## Patterns:
  - MV*
  - Singleton
  - Eventbus
  - Reactor

## Build:

Install ``node.js``, ``npm``

Install and run ``Redis``

Then install libraries so that you can run them globally: ``sudo npm install coffee-script gulp nodemon -g``.

Generate javascript files by ``coffee -wcbo ./ ./src_node`` and ``coffee -wco ./public/javascripts ./src_front``.
Templates for both backend and frontend are based on Jade. For the frontend pre-compile templates into javascript functions functions using ``gulp templates`` command (see ``gulpfile.js`` for details).

In order to launch express run ``nodemon --watch '**/*.*' bin/www``. Then go to localhost:3000 and enter your name in the prompt.
Happy lame-chatting, Sir!

## What it does not have:
 - redis/serverside interaction error handling
 - login page / backbone router
 - serverside views generation (only templates are compiled to js)
 - build file (besides one for compiling jade tepmlates)
