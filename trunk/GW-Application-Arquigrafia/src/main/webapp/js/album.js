

$(function(){
	$('#album_bar').on('click', 'img', function(e) {
		e.preventDefault();
		var url = $(this).parent().attr('href'), 
			context_path = $('#context_path').val(),
			icon = $('<img src="' + context_path + '/img/loader.gif"/>');
		$.ajax({
			url: url,
			type: 'get',
			dataType: 'html',
			beforeSend: function() {
				$('#galery_box').html(icon);
			},
			success: function(photos) {
				$('#galery_box').empty().append(photos);
			},
			complete: function() {
				icon.remove();
			}
		});
		
	});
	
	$('#new_album, #edit_album').click(function(e){
		e.preventDefault();
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		$('#registration').load(this.href);	
		form_window_loaded = true;
	});

});
