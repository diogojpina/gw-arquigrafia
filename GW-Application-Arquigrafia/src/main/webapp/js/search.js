

$(function(){
	var context_path = $('#context_path').val(),
	    url = context_path.concat('/photos/7/counts/search/term'),
	    q = encodeURIComponent($('#search_bar').val());
	
	$.get(url, {term: q}, function(results) {
		
		for ( var photo in results) {
			for ( var index in results[photo]) {
				var count = results[photo][index][1],
					selector = '#'.concat(results[photo][index][0]);
				if (count > 8) {
					$(selector).data("count", count-8).text('Ver mais imagens');
				}
				
			}
		}
	});
});
