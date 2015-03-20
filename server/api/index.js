module.exports = function (server) {

    // Connect to our database
    require('node-restful').mongoose.connect('mongodb://localhost:27017/barbuzz');

    var api = require('express')();
    api.use(require('body-parser').json());
    require('./models/bar').register(api,'/bars') 
    server.use('/api', api);
}