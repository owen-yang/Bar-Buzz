var restful = require('node-restful');
var mongoose = restful.mongoose;

var promotionSchema = mongoose.Schema({
    name: String,
    description: String,
    code: String,
    startDate: Date,
    endDate: Date
});


var Promotion = restful.model('Promotion', promotionSchema).methods(['get']);

module.exports = Promotion;