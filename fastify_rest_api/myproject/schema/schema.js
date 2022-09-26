const nuovoUtente = {
    response: {
        200: {
            type: 'array',
            items: {
                type: 'object',
                required: ['Nome', 'Cognome', 'Età', 'Residenza', 'Sesso'],
                properties: {
                    Nome: { type: 'string' },
                    Cognome: { type: 'string' },
                    Età: { type: 'string' },
                    Residenza: { type: 'string' },
                    Sesso: { type: 'char' }
                }
            }
        }
    }
}
export.default