var constants = require('../utils/constants.js');

var restful = require('node-restful');
var mongoose = restful.mongoose;

var barSchema = mongoose.Schema({
    name: String,
    nickname: String,
    address: String,

    location: {
        type: [Number],
        index: '2dsphere'
    },

    promotions: [{ 
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'Promotion' 
    }]
});


var Bar = restful.model('Bar', barSchema).methods(['get', 'post', 'put']);

/**
 * Before a bar is created or updated, we request new lat/lng coordinates
 * for the bar (in case address has changed)
 */
Bar.before('post', fillLatLong).before('put', fillLatLong);

/**
 * Gets and fills the long/lat of a bar on a POST/PUT request
 */
function fillLatLong(req, res, next) {
    if (req.method === 'PUT') {
        Bar.findById(req.params.id, function (err, bar) {
            if (err) {
                console.log(err);
                next();
            }

            if (!bar) next();

            if ('address' in req.body) {
                bar.address = req.body.address;
            }

            if ('address' in bar) {
                requestLatLong(bar.address, function (err, geocode) {
                    if (err) throw err;

                    bar.location = geocode;
                    bar.save(function (err) {
                        if (err) {
                            console.log(err);
                        }
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
                if (err) {
                    console.log(err);
                    next();
                }
                req.body.location = geocode;
                next();
            });
        } else {
            next();
        }
    }
};

/**
 * Requests the geocoded lat/lng of address from Google's geocoding API
 * 
 * @param  {[type]}   address  A string containing the address to geocode
 * @param  {Function} callback A function with the signature function (err, geocode),
 *                             where geocode is of the form [lat, lng].
 */
function requestLatLong(address, callback) {
    var reqString = 'https://maps.googleapis.com/maps/api/geocode/json?address='
                    + address.replace(/ /g, '+').replace(/#/g, '')
                    + '&key='
                    + constants.SERVER_API_KEY;

    require('https').get(reqString, function (res) {
        var data = '';
        res.on('data', function (chunk) {
            data += chunk;
        });

        res.on('end', function() {
            data = JSON.parse(data);
            if (data.status === 'OK') {
                callback(null, 
                         [data.results[0].geometry.location.lat,
                          data.results[0].geometry.location.lng]);
            } else {
                callback(Error('Google Geocode response status error - ' + data.status), null);
            }
        })
    }).on('error', function (err) {
        callback(err, null);
    });
}

/**
 * URL params lat, lng, radius
 * 
 * radius given in miles (default 1 mile)
 */
Bar.route('locate.get', function (req, res) {

    // Check to make sure parameters are all valid ones
    var validKeys = ['lat', 'lng', 'radius'];
    var keys = Object.keys(req.query);
    for (var i in keys) {
        if (validKeys.indexOf(keys[i]) == -1) {
            res.status('400').send('Invalid request parameter(s)');
            return;
        }
    }

    // Check to make sure lat/lng are included
    if (!('lat' in req.query) || !('lng' in req.query)) {
        res.status('400').send('Missing required request parameter(s)');
        return;
    }

    // If radius was not included, set a default value
    if (!('radius' in req.query)) {
        req.query.radius = 1;
    }

    // Create query options
    var options = {
        center: {
            type: 'Point',
            coordinates: [req.query.lat, req.query.lng]
        },
        // maxDistance given in meters
        maxDistance: req.query.radius * constants.METERS_PER_MILE
    }

    // Execute query
    Bar.where('location').near(options).exec(function (err, results) {
        if (err) {
            res.status('500').send('There was an error completing your request');
        } else {
            res.send(results);
        }
        return;
    });
});

module.exports = Bar;