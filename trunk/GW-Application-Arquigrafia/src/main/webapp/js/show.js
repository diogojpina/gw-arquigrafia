function pageResize() {
	$("#photoRel").css("height", "auto");
    var maxWidthPhoto = calcMaxWidthPhoto(); // Max width for the image
    var maxWidthLayout = calcMaxWidthLayout(); // Max width for the image
    var maxHeight = 600;       // Max height for the image
    $('.resizeblePhoto1 img').css("width", "auto").css("height", "auto"); // Remove existing CSS
    $("#photoWrap").css("margin-left", "auto");
    $('.resizeblePhoto1 img').removeAttr("width").removeAttr("height"); // Remove HTML attributes
    var width = $('.resizeblePhoto1 img').width();    // Current image width
    var height = $('.resizeblePhoto1 img').height();  // Current image height

    if (width > height) {
        // Check if the current width is larger than the max
        if (width > maxWidthPhoto) {
            var ratio = maxWidthPhoto / width;   // get ratio for scaling image
            height = height * ratio;        // Reset height to match scaled image
            $('.resizeblePhoto1 img').css("width", maxWidthPhoto); // Set new width
            $('.resizeblePhoto1 img').css("height", height);  // Scale height based on ratio
            $("#search_input").css("width", $(window).width() - 680);
            $("#map_canvas").css("width", maxWidthPhoto);
            $("#map_canvas").css("height", height);
        }
        else {
            $("#search_input").css("width", $(window).width() - 680);
            $("#map_canvas").css("width", width);
            $("#map_canvas").css("height", height);
        }
        // Check if current height is larger than max
    } else if (height > maxHeight) {
        var ratio = maxHeight / height; // get ratio for scaling image
        width = width * ratio;  // Reset width to match scaled image
        $('.resizeblePhoto1 img').css("height", maxHeight);   // Set new height
        $('.resizeblePhoto1 img').css("width", width);    // Scale width based on ratio
        $("#map_canvas").css("width", width);
        $("#map_canvas").css("height", maxHeight);
        $("#search_input").css("width", $(window).width() - 680);
    }
    else {
        $("#search_input").css("width", $(window).width() - 680);
        $("#map_canvas").css("width", width);
        $("#map_canvas").css("height", height);
    }
    if (width <= maxWidthPhoto) {
    	if (maxWidthPhoto < maxWidthLayout) {
    		var marginLeft = ((maxWidthLayout - ((2 * width) + 15)) / 2) - 30 ;
    		if (marginLeft < 0) {
    			marginLeft = 0;
    		}
    		$("#photoWrap").css("margin-left", marginLeft);
    	}
    	else {
    		var marginLeft = ((maxWidthPhoto - width) / 2) - 30 ;
    		if (marginLeft < 0) {
    			marginLeft = 0;
    		}
    		$("#photoWrap").css("margin-left", marginLeft);
    	}
	    $("#search_input").css("width", $(window).width() - 715 - ((maxWidthLayout - width) / 2));
	    $("#photoRelSub").css("width", (width* 2) + 10);
	}
    else {
        $("#photoRelSub").css("width", (maxWidthPhoto* 2) + 10);
    }
    $("#comments_bar_bg").css("width", maxWidthLayout + 45);
    $("#comments_create").css("width", maxWidthLayout + 35);
    $("#comments_show").css("width", maxWidthLayout + 45);
}

function calcMaxWidthPhoto() {
	if ($("#photoTitle_tab_1").is(":visible")) {
		return $(window).width() - 355;
	}
	else {
		return ($(window).width() - 355) / 2;
	}
};
function calcMaxWidthLayout() {
	return $(window).width() - 355;
};



function basicAndEvents() {
	$("#search_input").css("width", $(window).width() - 680);
    $('.resizeblePhoto1 img').load(function() {
        $("#map_canvas").hide();
        pageResize();//Triggers when document first loads
    });      

    $(window).bind("resize", function() { //Adjusts image when browser resized
        pageResize();
        heightPhotoRel = $("#photoBackground").height();
        $("#photoRel").css("height", heightPhotoRel);
    });

    $("#avgLink").click(function() {
        $("#binomialsUser").fadeOut(400, function() {
            $("#binomialsAvg").fadeIn(400);
        });
    });
    
    $("#myLink").click(function() {
        $("#binomialsAvg").fadeOut(400, function() {
            $("#binomialsUser").fadeIn(400);
        });
    });

    $("#add").click(function() {
        $("#add2").show();
        $("#add").hide();
        $("#tagsAdd").slideDown(function(){
        	heightPhotoRel = $("#photoBackground").height();
            $("#photoRel").css("height", heightPhotoRel);
        });
    });
    
    $("#add2").click(function() {
        $("#add").show();
        $("#add2").hide();
        $("#tagsAdd").slideUp(function () {
        	$("#photoRel").css("height", "auto");
        	heightPhotoRel = $("#photoBackground").height();
            $("#photoRel").css("height", heightPhotoRel);
        });
    });
    
    $("#photoTitle_tab_1").click(function() {
    	$("#photoTitle_tab_1").hide();
    	$("#photoTitle_tab_2").show();
        pageResize();
        $("#map_canvas").show();
        $("#photoRelSub").slideDown(function () {
        	heightPhotoRel = $("#photoBackground").height();
            $("#photoRel").css("height", heightPhotoRel);
        });
        
    });

    $("#photoTitle_tab_2").click(function() {
    	$("#photoTitle_tab_2").hide();
    	$("#photoTitle_tab_1").show();
        $("#map_canvas").hide();
        $("#photoRelSub").slideUp();
        pageResize();
    });
    
    $(window).bind("load", function() {
        $("#map_canvas").hide();
        $("#photoRelSub").hide();
    	$("#photoTitle_tab_2").hide();
        $("#binomialsAvg").hide();
        $("#add2").hide();
        $("#tagsAdd").hide();
    });
};