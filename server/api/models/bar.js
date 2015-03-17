var restful = require('node-restful');
var mongoose = restful.mongoose;

var barSchema = mongoose.Schema({
    name: String,
    address: String,
    promotions: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Promotion' }]
});


var Bar = restful.model('Bar', barSchema).methods(['get']);

module.exports = Bar;