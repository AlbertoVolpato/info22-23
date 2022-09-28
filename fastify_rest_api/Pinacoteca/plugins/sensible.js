'use strict'

const fp = require('fastify-plugin')

/**
 * This plugins adds some utilities to handle http errors
 *
 * @see https://github.com/fastify/fastify-sensible
 */
module.exports = fp(async function (fastify, opts) {
  fastify.register(require('@fastify/sensible'), {
    errorHandler: false
  })
})
const { Client } = require('pg')
require('dotenv').config()
const client = new Client({
  user: 'postgres',
  password: 'Alberto',
  host: 'localhost',
  port: 5432,
  database: 'pinacoteca'
})
async function dbconnector(fastify, options) {
  try {
    await client.connect()
    console.log("db connected succesfully")
    fastify.decorate('db', { client })
  } catch (err) {
    console.error(err)
  }
}
module.exports = fp(dbconnector)
