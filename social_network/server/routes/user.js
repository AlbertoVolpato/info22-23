'use strict'

const multer = require('fastify-multer') // or import multer from 'fastify-multer'
const crypto = require('crypto');

module.exports = async function (fastify, opts) {
    fastify.register(multer.contentParser)

    var storage = multer.diskStorage({ //multers disk storage settings
        destination: function (req, file, cb) {
            cb(null, 'uploads/picture')
        },
        filename: function (req, file, cb) {
            var id = crypto.randomUUID()
            cb(null, id + '.' + file.originalname.split('.')[file.originalname.split('.').length - 1])
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
    }).single('picture');

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

    fastify.post('/user', { preHandler: upload },
        async (req, reply) => {
            const client = await fastify.pg.connect()
            try {
                const { username, email, password, google_token } = req.body;
                let image = req.file.filename;
                const { rows } = await client.query(
                    'INSERT INTO users (username,email,password,google_token,picture) VALUES ($1,$2,$3,$4,$5) RETURNING id',
                    [username, email, password, google_token, image]
                )
                return rows
            } finally {
                client.release()
            }
        }
    )

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
