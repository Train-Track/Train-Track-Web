var StompClient = require('stomp-client').StompClient;
var mysql       = require('mysql');

var db = mysql.createConnection({
  host     : 'localhost',
  user     : process.env.TRAINS_DATABASE_USER,
  password : process.env.TRAINS_DATABASE_PASSWORD,
  database : 'trains'
});
db.connect();

var operatorCodes = { }
var username = process.env.NETWORK_RAIL_USERNAME;
var password = process.env.NETWORK_RAIL_PASSWORD;

db.query('SELECT numeric_code, id FROM operators WHERE numeric_code IS NOT NULL', function(err, rows, fields) {
	if (err) throw err;
	for (var i = rows.length - 1; i >= 0; i--) {
		operatorCodes[rows[i].numeric_code] = rows[i].id;
	}
	console.log(operatorCodes);
});

var ppm = new StompClient('datafeeds.networkrail.co.uk', 61618, username, password, '1.0');
ppm.connect(function(sessionId) {
    console.log('Trying to subscribe...');
    ppm.subscribe('/topic/RTPPM_ALL', function(body, headers) {
    	var data = JSON.parse(body);
    	var operators = data.RTPPMDataMsgV1.RTPPMData.OperatorPage;
    	for (var i = operators.length - 1; i >= 0; i--) {
    		operator_id = operatorCodes[operators[i].Operator.code];
    		var operator = {
    			operator_id: operator_id,
    			name: operators[i].Operator.name,
    			total: operators[i].Operator.Total,
    			cancel_very_late: operators[i].Operator.CancelVeryLate,
    			late: operators[i].Operator.Late,
    			on_time: operators[i].Operator.OnTime,
    			ppm: operators[i].Operator.PPM.text,
    			created_at: new Date(),
    			updated_at: new Date()
    		}
			console.log("Inserting:", operator);
    		db.query("INSERT INTO ppms SET ?", operator, function(err, result) {
				if (err) throw err;
			});
    	};
    });
});

