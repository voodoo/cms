
function getLocation() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(showPosition);
	} else {
		console.log("Geolocation is not supported by this browser.")
	}
}
function showPosition(position) {
	$('#way_lng').val(position.coords.longitude)
	$('#way_lat').val(position.coords.latitude)
	var btn = $('#btnHereIAm')
	if(btn.length > 0) btn.button('enable')
  else{
  	submitWay()
  }

	console.log("Latitude: " + position.coords.latitude +  "Longitude: " + position.coords.longitude)
}

function submitWay(position) {
  var frm = $('#new_way')
	$.ajax({
		type:'POST', 
		url: "/mblz/ways", 
		data: frm.serialize()
	})
}

getLocation()

// function getLocation() {
// 	if (navigator.geolocation) {
// 		navigator.geolocation.getCurrentPosition(showPosition);
// 	} else {
// 		console.log("Geolocation is not supported by this browser.")
// 	}
// }

	  
// }

// getLocation()