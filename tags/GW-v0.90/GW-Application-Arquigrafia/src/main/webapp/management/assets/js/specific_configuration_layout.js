$(window).load(function() {
    pageResize();
    pageResize(); // some peaple need height and width assigned before this method can properly work
});

$(window).bind("resize", function() {
    pageResize();
});


