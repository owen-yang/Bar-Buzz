/**
 * Resets all data in the database and initializes it with
 * default objects.
 */

var init = function() {
    require('mongoose').connect('mongodb://localhost:27017/barbuzz');

    require('./init')(function() {
        process.exit();
    });
};

require('mongodb')
.MongoClient
.connect('mongodb://localhost:27017/barbuzz', function (err, db) {
    db.dropCollection('bars', function (err, result) {
        console.log('Dropped collection \'bars\'');
        init();
    });
});