async function routes(fastify, options) {
    //Access our client instance value from our decorator
    const client = fastify.db.client
    //GET ALL USERS
    fastify.get('/', async function (request, reply) {
        try {
            const { rows } = await client.query('SELECT * FROM dati')
            reply.send(rows)
        } catch (err) {
            throw new Error(err)
        }
    });
    //GET ONLY ONE USER;

    //POST A NEW USER
    fastify.post('/', { schema: nuovoUtente }, async function (request, reply) {
        const { Nome, Cognome, Età, Residenza, Sesso } = request.body
        const query = {
            text: `INSERT INTO dati (Nome, Cognome, Età, Residenza, Sesso) VALUES($1, $2, $3, $4, $5) RETURNING *`,
            values: [Nome, Cognome, Età, Residenza, Sesso],
        }
        try {
            const { rows } = await client.query(query)
            console.log(rows[0])
            reply.code(201)
            return { created: true }
        } catch (err) {
            throw new Error(err)
        }

    })
    //EDIT AN EXISTENT USER

    //DELATE AN USER
}
module.exports = routes
