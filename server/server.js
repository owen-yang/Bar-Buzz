var express = require('express');
var server = express();

require('./api')(server);

server.get('/', function (req, res) {
    res.send('Bar Buzz coming soon');
});


/**
 * Open server on port
 * 
 * To start the server in production mode (on port 80)
 *     MODE=prod [node|nodemon] server.js
 *
 * To start the server in development mode (on port 3000)
 *     MODE=dev  [node|nodemon] server.js
 *     
 */
if (process.env.MODE === 'prod') {
    server.listen(80);
    console.log('LIVE - Production Mode');
} else if (process.env.MODE === 'dev') {
    server.listen(3000);
    console.log('LIVE - Development Mode');
} else {
    console.log('SERVER NOT STARTED');
    console.log('Please specify a valid server mode:');
    console.log('MODE=[prod|dev] [node|nodemon] server.js\n');
    process.exit();
}

// How to handle uncaught exceptions
process.on('uncaughtException', function (err) {
    console.dir(err);
    console.trace(err);
});