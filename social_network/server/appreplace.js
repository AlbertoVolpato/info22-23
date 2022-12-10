'use strict'

const path = require('path')
const AutoLoad = require('@fastify/autoload')
//plugin personali
const cors = require('@fastify/cors')
//fine plugin personali

// Pass --options via CLI arguments in command to enable these options.
module.exports.options = {
  fastify.listen({ port: 3000 }, function (err, address) {
    if (err) {
      fastify.log.error(err)
      process.exit(1)
    }
  }
}

module.exports = async function (fastify, opts) {
  // Place here your custom code!

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

  //aggiunta cors
  fastify.register(cors, {
    origin: '*'
  })

  //codice aggiunto da me
  fastify.register(require('@fastify/postgres'), {
    connectionString: 'postgres://postgres:Alberto@localhost/socialnetwork'
  })
}
