function searchInputResize() {
    var width = $(window).width() - 620;
    $("#search_input").css("width", width);
}
function headerBasicAndEvents() {
	$("#search_input").load( function() {
		searchInputResize();  
	});
	$(window).bind("resize", function() { //Adjusts image when browser resized
		searchInputResize();  
	});
}