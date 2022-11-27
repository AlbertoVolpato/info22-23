'use strict'

module.exports = async function (fastify, opts) {
    fastify.get('/comment', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { rows } = await client.query(
                'SELECT * FROM comments',
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.get('/comment/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const id = req.params.id;
            const { rows } = await client.query(
                'SELECT * FROM comments WHERE id = $1', [id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.post('/comment', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { content, post_id, user_id } = req.body;
            const { rows } = await client.query(
                'INSERT INTO comments (content, post_id, user_id ) VALUES ($1,$2,$3) RETURNING id',
                [content, post_id, user_id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.put('/comment/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { content, post_id, user_id } = req.body;
            const id = req.params.id;
            const { rows } = await client.query(
                'UPDATE comments SET content = $1, post_id = $2, user_id = $3 WHERE id = $4 RETURNING id',
                [content, post_id, user_id, id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.delete('/comment/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const id = req.params.id;
            const { rows } = await client.query(
                'DELETE FROM comments WHERE id = $1 RETURNING id', [id]
            )
            return rows
        } finally {
            client.release()
        }
    })
}
