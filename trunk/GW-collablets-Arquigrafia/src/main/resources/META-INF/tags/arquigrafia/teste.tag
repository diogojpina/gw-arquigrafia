form_window_loaded = false;

$(document).ready(function(){

	$('#edit_perfil_button').click(function(){
		var part = "perfil";
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		$('#registration').load('/GW-Application-Arquigrafia/user/edit/2/'+part+'');	
		form_window_loaded = true;
	});

	$('#edit_formacao_button').click(function(){
		var part = "formacao";
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		$('#registration').load('/GW-Application-Arquigrafia/user/edit/2/'+part+'');	
		form_window_loaded = true;
	});

	$('#edit_localizacao_button').click(function(){
		var part = "localizacao";
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		$('#registration').load('/GW-Application-Arquigrafia/user/edit/2/'+part+'');	
		form_window_loaded = true;
	});

	$('#edit_contato_button').click(function(){
		var part = "contato";
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		$('#registration').load('/GW-Application-Arquigrafia/user/edit/2/'+part+'');	
		form_window_loaded = true;
	});
	
	$('#registration_button').click(function(){
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		$('#registration').load('/GW-Application-Arquigrafia/users/7/signup');	
		form_window_loaded = true;
	});
	
	$('#upload').click(function(){
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		$('#registration').load('/GW-Application-Arquigrafia/photo/6/upload');	
		form_window_loaded = true;
	});
	
	$('#upload_bar').click(function(){
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		$('#registration').load('modal/upload_bar.html');	
		form_window_loaded = true;
	});

	$('#contact').click(function(){
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		$('#registration').load('/GW-Application-Arquigrafia/17/contact');	
		form_window_loaded = true;
	});

	$('#login_button').click(function(){
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		$('#registration').load('/GW-Application-Arquigrafia/users/7/login');	
		form_window_loaded = true;
	});

	$('#comment_login_link').click(function(){
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		$('#registration').load('/GW-Application-Arquigrafia/users/7/login');	
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
		
	$('#printer_icon').click(function() {
	  window.print();
	  return false;
	});
		
	// IMAGES HOVERS
	
	$('.image').mouseenter(function(){
		$('.image').css('opacity',0.6);
		$(this).css('opacity',1);
	});

	$('#panel').mouseleave(function(){ 
		$('.image').css('opacity',1);
	});
	
	$('.footer_image').mouseenter(function(){
		$('.footer_image img').css('opacity',0.6);
		$($(this).children('img'),this).css('opacity',1);
	});

	$('.images_line').mouseleave(function(){ 
		$('.footer_image img').css('opacity',1);
	});
	
	// FOOTER
	
	var Dist = 905;
	var Qtd = 0;
	//var Local = $('.images_line').css('margin-left');
		
	$('#arrow-left').click(function(){
		if(Qtd != 0){
			Qtd--;
			$('.images_line').animate({marginLeft : - (Qtd * Dist)}, 500);
		}
	});
	
	
	$('#arrow-right').click(function(){
		if(Qtd != 2){
			Qtd++
			$('.images_line').animate({marginLeft: - (Qtd * Dist)}, 500);
		}
	});
	
	// ADVANCED SEARCH
	
	var ON = false;
	
	$('a#complete_search').click(function(){
		if(ON == false){
			ON = true;
			$('#header').animate({height:142}, 200, function(){
				$('#complete_search_bar').fadeIn(200);	
			});
				
		} else {
			ON = false;
			$('#header').animate({height:102}, 200, function(){
				$('#complete_search_bar').fadeOut(200);	
			
			});
		}
	})
});


function load(firstTime) {
	if ( firstTime == 1) {
		$('#mask').fadeIn('fast');
		$('#form_window').fadeIn('slow');
		$('#registration').load('/GW-Application-Arquigrafia/17/welcome');	
		form_window_loaded = true;
	}
}