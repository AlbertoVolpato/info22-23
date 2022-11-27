'use strict'

module.exports = async function (fastify, opts) {
    fastify.get('/comment-like', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { rows } = await client.query(
                'SELECT * FROM comment_likes',
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.get('/comment-like/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const id = req.params.id;
            const { rows } = await client.query(
                'SELECT * FROM comment_likes WHERE id = $1', [id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.post('/comment-like', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { user_id, comment_id } = req.body;
            const { rows } = await client.query(
                'INSERT INTO comment_likes (user_id,comment_id) VALUES ($1,$2) RETURNING id',
                [user_id, comment_id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.put('/comment-like/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { user_id, comment_id } = req.body;
            const id = req.params.id;
            const { rows } = await client.query(
                'UPDATE comment_likes SET user_id = $1 ,comment_id = $2 WHERE id = $3 RETURNING id',
                [user_id, comment_id, id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.delete('/comment-like/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const id = req.params.id;
            const { rows } = await client.query(
                'DELETE FROM comment_likes WHERE id = $1 RETURNING id', [id]
            )
            return rows
        } finally {
            client.release()
        }
    })
}
