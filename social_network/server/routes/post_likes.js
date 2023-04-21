'use strict'

module.exports = async function (fastify, opts) {
    fastify.get('/post-like', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { rows } = await client.query(
                'SELECT * FROM post_likes',
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.get('/post-like/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const id = req.params.id;
            const { rows } = await client.query(
                'SELECT * FROM post_likes WHERE post_id = $1', [id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.get('/post-like-fromuser/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const id = req.params.id;
            const { rows } = await client.query(
                'SELECT * FROM post_likes WHERE user_id = $1', [id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.post('/post-like', 
    async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { user_id, post_id } = req.body;
            const { rows } = await client.query(
                'INSERT INTO post_likes (user_id,post_id) VALUES ($1,$2) RETURNING id',
                [user_id, post_id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.put('/post-like/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { user_id, post_id } = req.body;
            const id = req.params.id;
            const { rows } = await client.query(
                'UPDATE post_likes SET user_id = $1 ,post_id = $2 RETURNING id',
                [user_id, post_id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.delete('/post-like/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const id = req.params.id;
            const { rows } = await client.query(
                'DELETE FROM post_likes WHERE id = $1 RETURNING id', [id]
            )
            return rows
        } finally {
            client.release()
        }
    })
}
