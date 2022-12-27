'use strict'

const multer = require('fastify-multer') // or import multer from 'fastify-multer'
const crypto = require('crypto');


module.exports = async function (fastify, opts) {
    fastify.register(multer.contentParser)

    var storage = multer.diskStorage({ //multers disk storage settings
        destination: function (req, file, cb) {
            cb(null, 'uploads')
        },
        filename: function (req, file, cb) {
            var datetimestamp = Date.now();
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
    }).array('images', 10);


    fastify.get('/post', async (req, reply) => {
        const client = await fastify.pg.connect()
        const { page, size } = req.query;
        try {
            const { rows } = await client.query(
                'SELECT * FROM posts LIMIT $2 OFFSET(($1 - 1) * 2);', [page, size]);
            return rows
        } finally {
            client.release()
        }
    })

    fastify.get('/post&user', async (req, reply) => {
        const client = await fastify.pg.connect()
        const { page, size } = req.query;

        try {
            const { rows } = await client.query(
                'SELECT * FROM posts, users WHERE posts.user_id = users.user_id LIMIT $2 OFFSET(($1 - 1) * $2);', [page, size],
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
                'SELECT * FROM posts WHERE post_id = $1', [id]
            )
            return rows
        } finally {
            client.release()
        }
    })

    fastify.post('/post', { preHandler: upload },
        async (req, reply) => {
            const client = await fastify.pg.connect()
            try {
                const { content, user_id } = req.body;
                let image = [];
                for (let i in req.files) {
                    if (req.files[i].filename != null) {
                        image[i] = req.files[i].filename
                    }
                }
                const { rows } = await client.query(
                    'INSERT INTO posts (content,user_id,image) VALUES ($1,$2,$3) RETURNING post_id',
                    [content, user_id, image]
                )
                reply.code(200).send('post created')

            } finally {
                client.release()
            }
        }
    )

    fastify.delete('/post/:id', async (req, reply) => {
        const client = await fastify.pg.connect()
        try {
            const id = req.params.id;
            const { rows } = await client.query(
                'DELETE FROM posts WHERE post_id = $1 RETURNING post_id', [id]
            )
            return rows
        } finally {
            client.release()
        }
    })


    //fastify.post('/upload', { preHandler: upload },
    //    async (req, reply) => {
    //        const client = await fastify.pg.connect()
    //        try {
    //            for(let i in req.files){
    //                if(req.files[i].filename != null){
    //                    console.log(req.files[i].filename)
    //                }
    //            }
    //            reply.code(200).send('uploaded file')
    //        } finally {
    //            client.release()
    //        }
    //    }
    //)

    //fastify.put('/post/:id', async (req, reply) => {
    //    const client = await fastify.pg.connect()
    //    try {
    //        const { content, user_id, image } = req.body;
    //        const id = req.params.id;
    //        const { rows } = await client.query(
    //            'UPDATE posts SET content = $1, user_id = $2, image = $3 WHERE id = $4 RETURNING id',
    //            [content, user_id, image, id]
    //        )
    //        return rows
    //    } finally {
    //        client.release()
    //    }
    //})
}
