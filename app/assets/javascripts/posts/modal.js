document.addEventListener('turbolinks:load', function() {

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



