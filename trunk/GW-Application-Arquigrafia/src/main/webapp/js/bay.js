jQuery().ready(function() {
    jQuery('#bay').accordion({
        header: 'div.bay_title',
        active: false,
        alwaysOpen: false,
        animated: 'easeslide',
        autoheight: false
    });
});