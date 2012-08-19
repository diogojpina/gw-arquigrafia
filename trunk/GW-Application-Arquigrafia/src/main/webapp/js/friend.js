

$(function(){
	
	$('#accept, #reject').click(function(e) {
		e.preventDefault();
		$.post(this.href);
		$(this).parent().remove();
	}); 
	
	$('.to-invite').click(function(e) {
		e.preventDefault();
		$.post($(this).data('url'));
		$(this).remove();
	});
	
	
    $('#comments_create').hide();
    $('#comments_bar_link2').hide();

    $('#comments_bar_link').click(function(){
        $('#comments_create').slideDown();
        $('#comments_bar_link').hide();
        $('#comments_bar_link2').show();
    });

    $('#comments_bar_link2').click(function(){
        $('#comments_create').slideUp();
        $('#comments_bar_link2').hide();
        $('#comments_bar_link').show();
    });

	
	
});


//function acceptFriend(id) {
//    var url = "${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/acceptRequest/" + id;
//$.post(url <c:if test="${afterAcceptFunction != null}">, ${afterAcceptFunction}</c:if>);
//}
//
//function rejectFriend(id) {
//    var url = "${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/rejectRequest/" + id;
//$.post(url <c:if test="${afterRejectFunction != null}">, ${afterRejectFunction}</c:if>);
//}
