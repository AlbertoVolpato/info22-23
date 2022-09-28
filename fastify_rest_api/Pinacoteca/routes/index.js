async function routes(fastify, options) {
    //Access our client instance value from our decorator
    const client = fastify.db.client
    //GET ALL USERS
    fastify.get('/pittori', async function (request, reply) {
        try {
            const { rows } = await client.query('SELECT * FROM pittori')
            reply.send(rows)
        } catch (err) {
            throw new Error(err)
        }
    });
    fastify.get('/stanze', async function (request, reply) {
        try {
            const { rows } = await client.query('SELECT * FROM stanze')
            reply.send(rows)
        } catch (err) {
            throw new Error(err)
        }
    });
    //GET ONLY ONE USER;
    fastify.get('/pittore/id', async function (request, reply) {

    })
    //POST A NEW PITTORE
    fastify.post('/pittori', async function (request, reply) {
        const nuovoPittore = {
            nome: request.body.nome,
            cognome: request.body.cognome
        }
        const query = {
            text: `INSERT INTO pittori (nome,cognome) VALUES($1, $2) RETURNING *`,
            values: [nuovoPittore.nome, nuovoPittore.cognome],
        }
        try {
            const { rows } = await client.query(query)
            console.log(rows[0])
            reply.code(201)
            return { created: true }
        } catch (err) {
            reply.send(err)
        }
    });
    //POST A NEW STANZA
    fastify.post('/stanze', async function (request, reply) {

        const nuovaStanza = {
            numero: request.body.numero,
            descrizione: request.body.descrizione
        }
        const query = {
            text: `INSERT INTO stanze (numero,descrizione) VALUES($1, $2) RETURNING *`,
            values: [nuovaStanza.numero, nuovaStanza.descrizione],
        }
        try {
            const { rows } = await client.query(query)
            console.log(rows[0])
            reply.code(201)
            return { created: true }
        } catch (err) {
            reply.send(err)
        }
    });
    //DELATE AN USER
}
module.exports = routes
