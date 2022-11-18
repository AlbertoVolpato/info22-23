'use strict'

module.exports = async function (fastify, opts) {
    fastify.get('/posts', (req, reply) => {
        fastify.pg.connect(onConnect)

        function onConnect(err, client, release) {
            if (err) return reply.send(err)

            client.query(
                'SELECT * FROM posts',
                function onResult(err, result) {
                    release()
                    reply.send(err || result)
                }
            )
        }
    })
}
