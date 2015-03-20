var constants = require('../utils/constants.js');

var restful = require('node-restful');
var mongoose = restful.mongoose;

var barSchema = mongoose.Schema({
    name: String,
    nickname: String,
    address: String,

    lat: Number,
    lng: Number,

    promotions: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Promotion' }]
});


var Bar = restful.model('Bar', barSchema).methods(['get', 'post', 'put']);

/**
 * Before a bar is created or updated, we request new lat/lng coordinates
 * for the bar (in case address has changed)
 */
Bar.before('post', fillLatLong).before('put', fillLatLong);
function fillLatLong(req, res, next) {
    if (req.method === 'PUT') {
        Bar.findById(req.params.id, function (err, bar) {
            if (err) throw err;

            if (!bar) next();

            if (req.body.address) {
                bar.address = req.body.address;
            }

            if (bar.address) {
                requestLatLong(bar.address, function (err, geocode) {
                    if (err) throw err;
                    bar.lat = geocode.lat;
                    bar.lng = geocode.lng;
                    bar.save(function (err) {
                        if (err) throw err;
                        next();
                    })
                });
            } else {
                next();
            }
        });
    } else {
        if (req.body.address) {
            requestLatLong(req.body.address, function (err, geocode) {
                if (err) throw err;
                req.body.lat = geocode.lat;
                req.body.lng = geocode.lng;
                next();
            });
        } else {
            next();
        }
    }
};

/**
 * Requests the geocoded lat/long of address from Google's geocoding API
 * 
 * @param  {[type]}   address  A string containing the address to geocode
 * @param  {Function} callback A function with the signature function (err, geocode),
 *                             where geocode is of the form {lat, lng}.
 */
function requestLatLong(address, callback) {
    var reqString = 'https://maps.googleapis.com/maps/api/geocode/json?address='
                    + address.replace(/ /g, '+')
                    + '&key='
                    + constants.SERVER_API_KEY;

    require('https').get(reqString, function (res) {
        res.on('data', function (data) {
            data = JSON.parse(data);
            if (data.status === 'OK') {
                callback(null,
                         { lat: data.results[0].geometry.location.lat,
                           lng: data.results[0].geometry.location.lng }
                        );
            } else {
                callback(Error('Response status error - ' + data.status), null);
            }
        });
    }).on('error', function (err) {
        callback(err, null);
    });
}

module.exports = Bar;