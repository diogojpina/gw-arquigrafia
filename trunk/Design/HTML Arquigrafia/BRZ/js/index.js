// JavaScript Document
form_window_loaded = false;

$(document).ready(function(){
	
	$('#registration_button').click(function(){
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		if (!form_window_loaded) $('#registration').load('modal/signup.html');	
		form_window_loaded = true;
	});
	
	$('#upload').click(function(){
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		if (!form_window_loaded) $('#registration').load('modal/upload.html');	
		form_window_loaded = true;
	});
	
	$('#upload_bar').click(function(){
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		if (!form_window_loaded) $('#registration').load('modal/upload_bar.html');	
		form_window_loaded = true;
	});
	
	$('#contact').click(function(){
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		if (!form_window_loaded) $('#registration').load('modal/contact_us.html');	
		form_window_loaded = true;
	});
	
	$('#login_button').click(function(){
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		if (!form_window_loaded) $('#registration').load('modal/login.html');	
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
	
	$('#complete_search').click(function() {
	  $('#complete_search_bar').slideToggle('slow', function() {
	  });
	});
	
	$('#printer_icon').click(function() {
	  window.print();
	  return false;
	});

});
