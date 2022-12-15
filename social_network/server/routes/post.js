'use strict'

const multer = require('fastify-multer') // or import multer from 'fastify-multer'

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

    var storage = multer.diskStorage({ //multers disk storage settings
        destination: function (req, file, cb) {
            cb(null, 'uploads')
        },
        limits: {
            files: 1,
            fileSize: 1024 * 1024
        },
        filename: function (req, file, cb) {
            var datetimestamp = Date.now();
            cb(null, file.fieldname + '-' + datetimestamp + '.' + file.originalname.split('.')[file.originalname.split('.').length - 1])
        },
        onFileUploadStart: function (file) {
            console.log("Inside uploads");
            if (file.mimetype == 'image/jpg' || file.mimetype == 'image/jpeg' || file.mimetype == 'image/png') {
                return true;
            }
            else {
                return false;
            }
        }
    });
    var upload = multer({ //multer settings
        storage: storage
    }).array('images', 10);

    fastify.post('/upload', { preHandler: upload },
        async (req, reply) => {

            const client = await fastify.pg.connect()
            try {
                reply.code(200).send('SUCCESS')

            } finally {
                client.release()
            }
        }
    )
}
