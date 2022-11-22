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

    fastify.post('/user', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { id, username, email, password } = req.body;
            const { rows } = await client.query(
                'INSERT INTO users (id,username,email,password) VALUES ($1,$2,$3,$4)',
                [id, username, email, password]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.put('/user/id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const id = parseInt(req.params.id);
            const { username, email, password } = request.body;
            const { rows } = await client.query(
                'UPDATE users SET username = $1, email = $2, password = $3 WHERE id = $4',
                [username, email, password, id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.delete('/user/id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const id = parseInt(req.params.id);
            const { rows } = await client.query(
                'DELETE FROM users WHERE id = $1', [id]
            )
            return rows
        } finally {
            client.release()
        }
    })
}
