'use strict';

const dictionaryController = {
    getDictionaryDefinition: async (req, res) => {
        const { word } = req.params;

        // get definition from public dictionary API
        const url = `https://api.dictionaryapi.dev/api/v2/entries/en/${word}`;
        try {
            const response = await fetch(url);
            const jsonData = await response.json();
            res.json(jsonData);
        } catch (error) {
            console.error('Error parsing JSON:', error);
            res.status(500).send('Internal Server Error: Error handling JSON data.');
        }
    },
};

module.exports = dictionaryController;
