'use strict'

module.exports = async function (fastify, opts) {
    fastify.get('/user', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { rows } = await client.query(
                'SELECT * FROM users',
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.get('/user/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        const id = req.params.id;
        try {
            const { rows } = await client.query(
                'SELECT * FROM users WHERE id = $1', [id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.post('/user', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { username, email, password } = req.body;
            const { rows } = await client.query(
                'INSERT INTO users (username,email,password) VALUES ($1,$2,$3) RETURNING id',
                [username, email, password]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.put('/user/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { username, email, password } = req.body;
            const id = req.params.id;
            const { rows } = await client.query(
                'UPDATE users SET username = $1, email = $2, password = $3 WHERE id = $4 RETURNING id',
                [username, email, password, id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.delete('/user/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const id = req.params.id;
            const { rows } = await client.query(
                'DELETE FROM users WHERE id = $1 RETURNING id', [id]
            )
            return rows
        } finally {
            client.release()
        }
    })
}
