// JavaScript Document
function pageResize() {
	var height = $(window).height();
	var width = $(window).width();
	var diff1 = $("#header").height() 
	+ ($("#available_components").outerHeight(true) - 
			$("#available_components").height()) + 90; //TODO: GAMBIARRA
        $("#tabs").css("height", height - 80); //TODO: GAMBIARRA
	if (height - diff1 > 0) {
		$("#available_components").css("height", height - diff1);
	}
	var diff2 = $(".component_canvas").outerWidth(true) + 70; //TODO: GAMBIARRA
	var diff3 = diff1 + 30;
	if (width - diff2 > 0) {
		$("#installed_components").css("width", width - diff2);
		$("#installed_components").css("height", height - diff1);
                $("#left_installed_components").css("height", $("#installed_components").innerHeight(true) - 10);
                $("#widget_list").css("height", $("#installed_components").innerHeight(true) - ($("#instance_selector").outerHeight(true) + $("#default_header").outerHeight(true)) - 40)
		$("#component_canvas").css("width", $("#installed_components").width() - $("#left_installed_components").outerWidth());
        $("#canvas_tabs").css("height", height - diff3);
        $(".canvas_tab").css("height", height - 190);
        $("#local_canvas").css("height", height - 263);
        $("#local_canvas2").css("height", height - 263);
	}
}
	