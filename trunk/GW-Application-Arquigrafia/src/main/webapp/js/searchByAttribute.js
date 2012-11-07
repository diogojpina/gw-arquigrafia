

$(function(){
	var context_path = $('#context_path').val(),
	    url = context_path.concat('/photos/7/count/search/term'),
	    search = encodeURIComponent($('#search').val()),
	    term = $('#term').val();
	
	$.get(url, {q: search, term: term}, function(count) {
		if (count > 8) {
			$('#'+term).data("count", count-8).text('Ver mais imagens');
		}
				
	});
});
