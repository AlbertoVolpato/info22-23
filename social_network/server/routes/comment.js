'use strict'

module.exports = async function (fastify, opts) {
    fastify.get('/comment', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { rows } = await client.query(
                'SELECT * FROM comment',
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.post('/comment', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { rows } = await client.query(
                'SELECT * FROM comment',
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.put('/comment', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { rows } = await client.query(
                'SELECT * FROM comment',
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.delete('/comment', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { rows } = await client.query(
                'SELECT * FROM comment',
            )
            return rows
        } finally {
            client.release()
        }
    })
}
