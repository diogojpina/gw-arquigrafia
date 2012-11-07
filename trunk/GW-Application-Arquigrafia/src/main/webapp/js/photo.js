

$(function(){
	
	$('#edit_image').click(function(e){
		e.preventDefault();
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		$('#registration').load(this.href);	
		form_window_loaded = true;

	});
	
	
});