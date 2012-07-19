<%@ tag body-content="empty" pageEncoding="UTF-8" %>

<script type="text/javascript">

$(function(){
	
	$('#plus').click(function(e){
		e.preventDefault();
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		$('#registration').load(this.href);	
		form_window_loaded = true;
	});
		
});


</script>
