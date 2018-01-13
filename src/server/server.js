const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const compression = require('compression');
const routes = require('./routes.js');

app.use(compression());
app.use(bodyParser.json());
app.use(routes);

module.exports = app;
