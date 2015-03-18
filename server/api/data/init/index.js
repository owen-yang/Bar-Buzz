var initBars = require('./bars.js');

module.exports = function (next) {
    initBars(function() {
        console.log('Added collection \'bars\'');
        if (next) next();
    });
};