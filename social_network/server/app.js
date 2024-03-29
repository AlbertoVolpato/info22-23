'use strict'

//plugin personali
//fine plugin personali

// Pass --options via CLI arguments in command to enable these options.
module.exports.options = {}

module.exports = async function (fastify, opts) {
  // Place here your custom code!

  const path = require('path')
  const AutoLoad = require('@fastify/autoload')
  const cors = require('@fastify/cors')

  //aggiunta cors
  fastify.register(cors, {
    origin: '*'
  })

  fastify.register(require('@fastify/postgres'), {
    connectionString: 'postgres://postgres:Alberto@localhost/socialnetwork'
  })

  //codice aggiunto da me
  fastify.register(require('@fastify/static'), {
    root: path.join(__dirname, 'uploads'),
    prefix: '/uploads/', // optional: default '/'
  })


  // Do not touch the following lines
  // This loads all plugins defined in plugins
  // those should be support plugins that are reused
  // through your application
  fastify.register(AutoLoad, {
    dir: path.join(__dirname, 'plugins'),
    options: Object.assign({}, opts)
  })


  // This loads all plugins defined in routes
  // define your routes in one of these
  fastify.register(AutoLoad, {
    dir: path.join(__dirname, 'routes'),
    options: Object.assign({}, opts)
  });

}
