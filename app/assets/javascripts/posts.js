
// googlemapを表示する
function initMap(){
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

	//mapをクリックしたときのイベントを設定
	window.onload = function() {
		google.maps.event.addListener(map, 'click', mylistener);
	}

	//クリックしたときの処理
	function mylistener(event){
		//marker作成
		var marker = new google.maps.Marker();
		//markerの位置を設定
		//event.latLng.lat()でクリックしたところの緯度を取得
		marker.setPosition(new google.maps.LatLng(event.latLng.lat(), event.latLng.lng()));
		//marker設置
		marker.setMap(map);
	}

};


let geocoder
const addressDis = document.getElementById('results')

// 検索&Googlemap更新処理
function codeAddress(){
	geocoder = new google.maps.Geocoder();

  let inputAddress = document.getElementById('address').value;

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

window.onload = function() {
	// modal
	const btn = document.getElementById('btn-modal');
	const modal = document.getElementById('modal');
	const closeBtn = document.getElementById('closeBtn');
	// 表示ボタン押下時処理
	btn.addEventListener('click', function() {
		modal.style.display = 'block';
	});

	// 閉じるボタン押下処理
	closeBtn.addEventListener('click', function() {
		modal.style.display = 'none';
	});
}



// google mapを表示
// function dispMap(e) {

// 	const status = this.el.getAttribute('data-map-status');

// 	if (status === 'unactive') {
// 		this.el.setAttribute('data-map-status', 'active');
// 	}else{
// 		this.el.setAttribute('data-map-status', 'unactive');
// 	}
// }

// window.onload = function() {
// 	const mapBtn = document.getElementById('btn-disp-map');
// 	const target = document.getElementById('form-map-container');
// 	console.log('hoge');
// 	mapBtn.addEventListener('click', {el: target, handleEvent: dispMap});
// }
