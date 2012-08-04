	
	$(function(){
	  $('.list_photos a.load_photos').on('click', function(e){
	    e.preventDefault();
	    return_photos(this);
	  });
	
	  $('.list_photos a.not_load_photos').live('click', function(e){
	    e.preventDefault();
	  });
	});
	
	
	
	function return_photos(load_photos){
		var load = $('<li class="load">Aguarde, carregando...</li>'),
				$load_photos = $(load_photos),
				list = $load_photos.data('list'),
				page = $load_photos.data('page');
		$load_photos.text('Aguarde, carregando...');
	  $(list).append(load);
	
	  $.get(load_photos.href, {page: $load_photos.data('page')}, function(photos){
		  if (isFinite(photos)) {
			  $load_photos.removeClass('load_photos').addClass('not_load_photos')
			  						.off()
			  						.text('Não existem mais imagens com esse termo');
		  } else {
		    load.fadeOut(function(){
		    	$load_photos.next().after(photos);
		      $(this).remove();
		      $load_photos.data('page', page + 1).text('Ver mais 8 imagens');
		    });
		  }
	  });
	  
	}
