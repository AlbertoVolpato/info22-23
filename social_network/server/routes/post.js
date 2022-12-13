'use strict'

const multer = require('fastify-multer') // or import multer from 'fastify-multer'
const upload = multer({ dest: 'uploads/' })


module.exports = async function (fastify, opts) {

    fastify.register(multer.contentParser)


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

    fastify.get('/post/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const id = req.params.id;
            const { rows } = await client.query(
                'SELECT * FROM posts WHERE id = $1', [id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.post('/post', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { content, user_id, image } = req.body;
            const { rows } = await client.query(
                'INSERT INTO posts (content,user_id,image) VALUES ($1,$2,$3) RETURNING id',
                [content, user_id, image]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.put('/post/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const { content, user_id, image } = req.body;
            const id = req.params.id;
            const { rows } = await client.query(
                'UPDATE posts SET content = $1, user_id = $2, image = $3 WHERE id = $4 RETURNING id',
                [content, user_id, image, id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.delete('/post/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const id = req.params.id;
            const { rows } = await client.query(
                'DELETE FROM posts WHERE id = $1 RETURNING id', [id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.post('/upload', { preHandler: upload.single('images') },
        async (req, reply) => {
            // request.file is the `avatar` file
            // request.body will hold the text fields, if there were any
            const client = await fastify.pg.connect()
            try {
                reply.code(200).send('SUCCESS')

            } finally {
                client.release()
            }
        }
    )
}
