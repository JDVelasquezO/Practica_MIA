const express = require('express');
const app = express();
const routes = require('../routes/router');
const port = process.env.port || 3000;

app.use(express.urlencoded({
    extended: true
}));
app.use(express.json());
app.use('/', routes);

app.set('port', port);

module.exports = app;
