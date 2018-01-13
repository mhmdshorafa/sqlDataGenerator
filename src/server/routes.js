const router = require('express').Router();
const { readFile } = require('./controllers/readFileController.js');

module.exports = router
  .get('/readfile', readFile);
