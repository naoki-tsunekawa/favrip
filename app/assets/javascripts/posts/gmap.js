// 宣言
let geocoder
let inputAddress
const addressDis = document.getElementById('results');

// googlemapを表示する
function initMap(){

	navigator.geolocation.getCurrentPosition(
		// 取得成功した場合
		function(position) {
			// 緯度・経度を変数に格納
			let mapLatLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
			// マップオプションを変数に格納
			let mapOptions = {
				zoom : 8,          // 拡大倍率
				center : mapLatLng  // 緯度・経度
			};
			// マップオブジェクト作成
			map = new google.maps.Map(
				document.getElementById("map"), // マップを表示する要素
				mapOptions         // マップオプション
			);
			// 　マップにマーカーを表示する
			var marker = new google.maps.Marker({
				map : map,             // 対象の地図オブジェクト
				position : mapLatLng   // 緯度・経度
			});
		}
	);

};

// 検索&Googlemap更新処理
function codeAddress(){
	geocoder = new google.maps.Geocoder();
	inputAddress = document.getElementById('address').value;

	console.log(inputAddress);

  geocoder.geocode( { 'address': inputAddress}, function(results, status) {
    if (status == 'OK') {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });

			addressDis.textContent = results[0].formatted_address;

    } else {
      alert('該当する結果がありませんでした：' + status);
    }
  });
}
