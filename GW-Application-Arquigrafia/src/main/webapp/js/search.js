


	var Search = {};

	Search.init = function () { 
		Search.context_path = $('#context_path').val(),
		Search.urlCountPhotos = Search.context_path.concat('/photos/7/counts/search/term'),
		Search.urlCountPeople = Search.context_path.concat('/users/count/search'),
		Search.q = encodeURIComponent($('#search_bar').val());
		
		Search.countPhotosSearchByAttribute();
		Search.countPeopleSearchByName();
		
	};
	
	Search.countPhotosSearchByAttribute = function() {
		$.get(Search.urlCountPhotos, {term: Search.q}, function(results) {
			
			for ( var index in results) {
				var count = results[index][1],
					selector = '#'.concat(results[index][0]);
				console.log(count);
				if (count > 8) {
					$(selector).data("count", count-8).text('Ver mais imagens');
				}
				
			}
		});
		
	};

	Search.countPeopleSearchByName = function() {
		$.get(Search.urlCountPeople, {q: Search.q}, function(count) {
			if (count > 8) {
				$("#people").data("count", count-8).text('Ver mais imagens');
			}
		});
	};

	$(document).ready(Search.init);
	
//$(function(){
//	var context_path = $('#context_path').val(),
//	    url = context_path.concat('/photos/7/counts/search/term'),
//	    q = encodeURIComponent($('#search_bar').val());
//	
//	$.get(url, {term: q}, function(results) {
//		
//		for ( var index in results) {
//			var count = results[index][1],
//				selector = '#'.concat(results[index][0]);
//			if (count > 8) {
//				$(selector).data("count", count-8).text('Ver mais imagens');
//			}
//			
//		}
//	});
//});
