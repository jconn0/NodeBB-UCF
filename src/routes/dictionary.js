'use strict';

const express = require('express');

const router = express.Router();

const dictionaryController = require('../controllers/dictionary');

router.get('/definition/:word', dictionaryController.getDictionaryDefinition);

module.exports = router;
