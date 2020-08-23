// 宣言
let geocoder
let inputAddress
const addressDis = document.getElementById('results');

// googlemapを表示する
function initMap(){
	// initMap確認用
	console.log("fuga");

	navigator.geolocation.getCurrentPosition(
		// 取得成功した場合
		function(position) {
			// 緯度・経度を変数に格納
			var mapLatLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
			// マップオプションを変数に格納
			var mapOptions = {
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
		},

		// 取得失敗した場合
		function(error) {
			// エラーメッセージを表示
			switch(error.code) {
				case 1: // PERMISSION_DENIED
					alert("位置情報の利用が許可されていません");
					break;
				case 2: // POSITION_UNAVAILABLE
					alert("現在位置が取得できませんでした");
					break;
				case 3: // TIMEOUT
					alert("タイムアウトになりました");
					break;
				default:
					alert("その他のエラー(エラーコード:"+error.code+")");
					break;
			}
		}
	);

};


// 検索&Googlemap更新処理
function codeAddress(){
	geocoder = new google.maps.Geocoder();
  inputAddress = document.getElementById('address').value;

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
