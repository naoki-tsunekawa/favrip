
// addEventListenerのエラー対策
// turbolinks有効時のwindow.loadの代わりに使う
document.addEventListener('turbolinks:load', function() {

	// 確認用console.log
	console.log("hoge");

	//mapクリックイベント
	window.onload = function() {
		google.maps.event.addListener(map, 'click', mylistener);

	}

	//mylistener関数
	function mylistener(event){
		//marker作成
		var marker = new google.maps.Marker();
		//markerの位置を設定
		//event.latLng.lat()でクリックしたところの緯度を取得
		marker.setPosition(new google.maps.LatLng(event.latLng.lat(), event.latLng.lng()));
		//marker設置
		marker.setMap(map);
		console.log("fuga");
	}
});
