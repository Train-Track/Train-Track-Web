$(document).ready(function() {
  if (navigator.geolocation != null) {
  	$('.geo').on('click', function() {
      var field = $(this).data('field');
      var url = $(this).data('url');
      navigator.geolocation.getCurrentPosition(function(position) {
	      $.ajax({
		      type     : 'GET',
		      dataType : 'jsonp',
		      headers: { 
		        "Accept"      : "application/json; charset=utf-8",
		        "Content-Type": "application/json; charset=utf-8"
		      },
		      url      : url,
		      data     : 'lat='+position.coords.latitude+'&lng='+position.coords.longitude,
		      success  : 
		        function(data) {
		          $('#'+field).val(data[0].name);
		        } 
	     });
      }, function(e) {
      	alert(e.message);
      });
    });
  }
  else {
  	$('.geo').hide();
  }
});