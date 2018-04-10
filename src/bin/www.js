const http = require('http');
const app = require('../config/app');

const server = http.createServer(app);

server.listen(3000, (err) => {
    if (err) {
        return console.log('something bad happened', err)
    }
    console.log(`server is listening on ${3000}`)
});