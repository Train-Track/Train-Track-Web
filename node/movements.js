var StompClient = require('stomp-client').StompClient;

var username = process.env.NETWORK_RAIL_USERNAME;
var password = process.env.NETWORK_RAIL_PASSWORD;

var ppm = new StompClient('datafeeds.networkrail.co.uk', 61618, username, password, '1.0');
ppm.connect(function(sessionId) {
    console.log('Trying to subscribe...');
    ppm.subscribe('/topic/TRAIN_MVT_ALL_TOC', function(body, headers) {
    	var data = JSON.parse(body);
    	console.log(data);
    });
});
