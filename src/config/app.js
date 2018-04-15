const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('Hi world from devops professional with integration test from digital ocean!');
});

module.exports = app;
