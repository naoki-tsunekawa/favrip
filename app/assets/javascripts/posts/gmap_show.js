let map;
let marker;
let geocoder;
const postAddress = document.getElementById('address');
const address = postAddress.getAttribute('value');
const postTitle = document.getElementById('postTitle');

function initMap() {
	geocoder = new google.maps.Geocoder();
	geocoder.geocode({
	//住所
	'address': address
	}, function(results, status) {
		if (status === google.maps.GeocoderStatus.OK) {
		map = new google.maps.Map(document.getElementById('map'), {
			center: results[0].geometry.location,
			//ズーム
			zoom: 14
		});
	marker = new google.maps.Marker({
	position: results[0].geometry.location,
	map: map
	});
	infoWindow = new google.maps.InfoWindow({
	content: `<h4> ${postTitle.innerText} </h4>`
	});
	marker.addListener('click', function() {
		infoWindow.open(map, marker);
	});
	} else {
		alert(status);
	}
});
}
