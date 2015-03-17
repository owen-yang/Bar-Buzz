var restful = require('node-restful');
var mongoose = restful.mongoose;

var promotionSchema = mongoose.Schema({
    name: String,
    description: String,
    code: String
});


var Promotion = restful.model('Promotion', promotionSchema).methods(['get']);

module.exports = Promotion;