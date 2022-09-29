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
    //GET ONLY ONE PITTORE;
    fastify.get('/pittori/:id', async function (request, reply) {
        const id = request.params.id
        try {
            const { rows } = await client.query('SELECT * FROM pittori WHERE cognome = $1', [id])
            reply.send(rows)
        } catch (err) {
            throw new Error(err)
        }
    })
    //GET ONLY ONE STENZA;
    fastify.get('/stanze/:id', async function (request, reply) {
        const id = request.params.id
        try {
            const { rows } = await client.query('SELECT * FROM stanze WHERE numero = $1', [id])
            reply.send(rows)
        } catch (err) {
            throw new Error(err)
        }
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
            reply.send("POST REQUEST DONE")
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
            reply.send("POST REQUEST DONE")
            return { created: true }
        } catch (err) {
            reply.send(err)
        }
    });
    //DELATE A PITTORE
    fastify.delete('/pittori/:id', async function (request, reply) {
        console.log(request.params)
        try {
            const { rows } = await client.query('DELETE FROM pittori WHERE Nome = $1', [request.params.id])
            console.log(rows[0])
            reply.code(204)
            reply.send("DELETE REQUEST DONE")
        } catch (err) {
            throw new Error(err)
        }
    })
    //DELETE A STANZA
    fastify.delete('/stanze/:id', async function (request, reply) {
        console.log(request.params)
        try {
            const { rows } = await client.query('DELETE FROM stanze WHERE numero = $1', [request.params.id])
            console.log(rows[0])
            reply.code(204)
            reply.send("DELETE REQUEST DONE")
        } catch (err) {
            throw new Error(err)
        }
    })
    //EDIT PITTORI
    fastify.put('/pittori/:id', async function (request, reply) {
        const id = request.params.id
        const { nome, cognome } = request.body

        const query = {
            text: `UPDATE pittori SET nome = COALESCE($1, nome), cognome = COALESCE($2, cognome) WHERE cognome = $3`,
            values: [nome, cognome, id]
        }
        try {
            const { rows } = await client.query(query)
            console.log(rows[0])
            reply.code(204)
            reply.send("PUT REQUEST DONE")
        } catch (err) {
            throw new Error(err)
        }
    })
    //EDIT STANZE
    fastify.put('/stanze/:id', async function (request, reply) {
        const id = request.params.id
        const { numero, descrizione } = request.body

        const query = {
            text: `UPDATE stanze SET numero = COALESCE($1, numero), descrizione = COALESCE($2, descrizione) WHERE numero = $3`,
            values: [numero, descrizione, id]
        }
        try {
            const { rows } = await client.query(query)
            console.log(rows[0])
            reply.code(204)
            reply.send("PUT REQUEST DONE")
        } catch (err) {
            throw new Error(err)
        }
    })
}
module.exports = routes
