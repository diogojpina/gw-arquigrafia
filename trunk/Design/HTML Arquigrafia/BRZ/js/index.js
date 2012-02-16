// JavaScript Document
form_window_loaded = false;

$(document).ready(function(){
	$('#mask').hide();
	$('#form_window').hide();
	
	$('#registration_button').click(function(){
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		if (!form_window_loaded) $('#registration').load('modal/signup.html');	
		form_window_loaded = true;
	});
	
	$('#form_window .close').click(function (e) {
		e.preventDefault();
		
		$('#mask').fadeOut();
		$('#form_window').fadeOut('fast');
	});		
	
	$('#mask').click(function () {
		$(this).fadeOut();
		$('#form_window').fadeOut('fast');
	});
		
});