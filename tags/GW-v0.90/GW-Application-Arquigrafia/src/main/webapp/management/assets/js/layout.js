// JavaScript Document
function pageResize() {
    // TODO: Gambiarra.
    var mysteriousGambiMagicNumber1 = 90;
    var mysteriousGambiMagicNumber2 = 80;
    var mysteriousGambiMagicNumber3 = 70;
    var mysteriousGambiMagicNumber4 = 30;
    var mysteriousGambiMagicNumber5 = 10;
    var mysteriousGambiMagicNumber6 = 190;
    var mysteriousGambiMagicNumber7 = 263;
    var mysteriousGambiMagicNumber8 = 40;

    var height = $(window).height();
    var width = $(window).width();
    var diff1 = $("#header").height()
        + $("#available_components").outerHeight(true)
        - $("#available_components").height()
        + mysteriousGambiMagicNumber1;

    $("#tabs").css("height", height - mysteriousGambiMagicNumber2);
    if (height - diff1 > 0) {
        $("#available_components").css("height", height - diff1);
    }

    var diff2 = $(".component_canvas").outerWidth(true) + mysteriousGambiMagicNumber3;
    var diff3 = diff1 + mysteriousGambiMagicNumber4;

    if (width - diff2 > 0) {
        $("#installed_components").css("width", width - diff2);
        $("#installed_components").css("height", height - diff1);

        var ich = $("#installed_components").innerHeight(true) - mysteriousGambiMagicNumber5;
        $("#left_installed_components").css("height", ich);

        var wh = $("#installed_components").innerHeight(true)
            - $("#instance_selector").outerHeight(true)
            - $("#default_header").outerHeight(true)
            - mysteriousGambiMagicNumber8;
        $("#widget_list").css("height", wh);

        var cch = $("#installed_components").width() - $("#left_installed_components").outerWidth();
        $("#component_canvas").css("width", cch);

        $("#canvas_tabs").css("height", height - diff3);
        $(".canvas_tab").css("height", height - mysteriousGambiMagicNumber6);
        $("#local_canvas").css("height", height - mysteriousGambiMagicNumber7);
        $("#local_canvas2").css("height", height - mysteriousGambiMagicNumber7);
    }
}
