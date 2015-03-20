var Bar = require('../../models/bar.js');
var bars = require('fs').readFileSync(__dirname+'/bars.csv',{encoding:'utf8'}).split('\n');

module.exports = function (next) {
    var numBars = bars.length;
    bars.forEach(function (bar) {
        bar = bar.split(',');
        bar = {
            name:       bar[0],
            nickname:   bar[1],
            address:    bar[2]+', '+bar[3]+', '+bar[4]+', '+bar[5]
        };

        var newBar = new Bar(bar);
        newBar.save(function (err) {
            if (err) throw err;
            if (--numBars === 0) {
                if (next) next();
            }
        });
    });
};