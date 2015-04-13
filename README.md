# cheburashka-chat
## Tech involved:
  - Node.js
  - Express.js
  - common.js
  - socket.io
  - require.js (client side)
  - Backbone
  - Jade (backend & clientside precompiled to javascript functions with gulp-jade)
  - coffeescript (backend/frontend)
  - Redis (to store user sets and list of chat messages)

## Patterns:
  - MV*
  - Singleton
  - Eventbus
  - Reactor

## Build:

Almost all javascrips are generated by the ``coffee -wcbo ./ ./src_node`` and ``coffee -wco ./public/javascripts ./src_front``.
Templates for both backend and frontend are based on Jade. For the frontend they are precompiled into javascript functions
using the ``gulp templates`` command (see ``gulpfile.js`` for details).

In order to launch express run ``nodemon --watch '**/*.*' bin/www``. Then go to localhost:3000 and enter your name in the prompt.
Happy lame-chatting, sir!

## What it does not have:
 - redis/serverside interaction error handling
 - login page / backbone router
 - serverside views generation (only templates are compiled to js)
 - build file of any kind
 - styles of any kind (twitter-bootstrap could be an easy fit)
