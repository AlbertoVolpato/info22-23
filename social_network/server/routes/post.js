'use strict'

module.exports = async function (fastify, opts) {
    fastify.get('/post', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { rows } = await client.query(
                'SELECT * FROM posts',
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.post('/post', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { rows } = await client.query(
                'SELECT * FROM posts',
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.put('/post', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { rows } = await client.query(
                'SELECT * FROM posts',
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.delete('/post', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { rows } = await client.query(
                'SELECT * FROM posts',
            )
            return rows
        } finally {
            client.release()
        }
    })
}
