var constants = require('./utils/constants.js');

module.exports = function (server) {

    // Connect to our database
    require('node-restful').mongoose.connect('mongodb://localhost:27017/barbuzz');

    var api = require('express')();

    // Check if request contains valid API token
    api.use(function (req, res, next) {
        // Verify API token
        if (constants.API_TOKENS.indexOf(req.query.t) != -1 ||
            constants.API_TOKENS.indexOf(req.headers['x-access-token']) != -1) {
            
            // If verification passed, remove token from request
            delete req.query.t;
            delete req.headers['x-access-token'];

            return next();
        } else {
            return res.status(401).send('Unauthorized token')
        }
    });

    api.use(require('body-parser').json());
    require('./models/bar').register(api,'/bars') 
    server.use('/api', api);
}