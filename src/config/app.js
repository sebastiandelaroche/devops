const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('Hi world from digital ocean!');
});

module.exports = app;
