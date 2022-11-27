'use strict'

const path = require('path')
const AutoLoad = require('@fastify/autoload')
//plugin personali
const oauthPlugin = require('@fastify/oauth2')
const cors = require('@fastify/cors')
//fine plugin personali


// Pass --options via CLI arguments in command to enable these options.
module.exports.options = {}

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

  //OAUTH GOOGLE 
  fastify.register(oauthPlugin, {
    name: 'googleOAuth2',
    scope: ['profile', 'email'],
    credentials: {
      client: {
        id: process.env.GOOGLE_OAUTH_CLIENT_ID,
        secret: process.env.GOOGLE_OAUTH_CLIENT_SECRET
      },
      auth: oauthPlugin.GOOGLE_CONFIGURATION,
    },
    startRedirectPath: '/login/google',
    callbackUri: 'http://localhost:3000/api/auth/google/callback',
    callbackUriParams: {
      // custom query param that will be passed to callbackUri
      access_type: 'offline', // will tell Google to send a refreshToken too
    },
  });

  fastify.get("/api/auth/google/callback", {}, async function (req, res) {
    // Fastify instance gets decorated with this method on OAuth plugin initialization
    const token = await fastify.googleOAuth2.getAccessTokenFromAuthorizationCodeFlow(req);

    console.log({ token }); // Just for debugging

    // Redirect to a route serving HTML or to your front-end
    res.redirect("http://localhost:3000/user")
  })
}
