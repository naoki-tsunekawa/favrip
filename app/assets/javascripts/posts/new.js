
// modal表示イベント
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
	}

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
});



// google mapを表示
// function dispMap(e) {

// const status = this.el.getAttribute('data-map-status');

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
