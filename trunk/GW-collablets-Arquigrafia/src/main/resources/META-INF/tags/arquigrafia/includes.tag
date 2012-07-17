<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="arquigrafiaInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.main.ArquigrafiaMgrInstance" %>

<!--   FAVICON   -->
<link rel="icon" href="<c:url value="/img/arquigrafia_icon.ico" />" type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value="/img/arquigrafia_icon.ico" />" type="image/x-icon" />
<!--   ESTILO GERAL   -->
<link rel="stylesheet" type="text/css" href="<c:url value="/css/style.css" />" />
<!--[if lt IE 8]>
<link rel="stylesheet" type="text/css" href="css/ie7.css" />
<![endif]-->
<link rel="stylesheet" type="text/css" media="print" href="<c:url value="/css/print.css" />" />


<!--   JQUERY - Google Ajax API CDN (Also supports SSL via HTTPS)   -->
<script type="text/javascript" src="<c:url value="/js/jquery_javascript_library_v1.7.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery-ui-1.8.17.custom.min.js" />"></script>

<!-- JS - Font size increment and decrement -->
<script type="text/javascript" src="<c:url value="/js/font_increment.js" />"></script>

<!-- Google Maps API -->
<script type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=true"></script>

<script type="text/javascript">
	form_window_loaded = false;

	$(document).ready(function(){

		$('#edit_perfil_button').click(function(){
			var part = "perfil";
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/groupware-workbench/profile/${profileMgr.id}/edit/${userLogin.id}"/>');	
			form_window_loaded = true;
		});
		
		$('#edit_user_button').click(function(){
			var part = "perfil";
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/groupware-workbench/users/${userMgr.id}/edit/${userLogin.id}"/>');	
			form_window_loaded = true;
		});

		$('#edit_user_password_button').click(function(){
			var part = "perfil";
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/groupware-workbench/users/${userMgr.id}/edit/${userLogin.id}/password"/>');	
			form_window_loaded = true;
		});
		
		$('#registration_button').click(function(){
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/users/8/signup"/>');	
			form_window_loaded = true;
		});
		
		$('#upload').click(function(){
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/photo/7/upload"/>');	
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
			$('#registration').load('<c:url value="/18/contact" />');	
			form_window_loaded = true;
		});

		$('#login_button').click(function(){
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/users/8/login"/>');	
			form_window_loaded = true;
		});

		$('#comment_login_link').click(function(){
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/users/8/login"/>');	
			form_window_loaded = true;
		});

		$('#footer_login_link').click(function(){
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/users/8/login"/>');	
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
        
        var ua = $.browser;
        // desativa para ff 
        if ( !(ua.mozilla) ) {
            $('.image').mouseenter(function(){
                $('.image').css('opacity',0.6);
                $(this).css('opacity',1);
            });
            $('#panel').mouseleave(function(){ 
                $('.image').css('opacity',1);
            });
        }
        
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
		var FooterCont = 0;
		//var Local = $('.images_line').css('margin-left');
		
		function ArrowValidation(FooterCont){
			if(FooterCont <= 0){
				$('#arrow-left').css({'display':'none'});
			}
			
			if(FooterCont >= 2){
				$('#arrow-right').css({'display':'none'});
			}
		}
		
		function FooterCarouselAnimation(Qtd){
			$('.images_line').animate({marginLeft: - (Qtd * Dist)}, 500);
		}
		
		$('#arrow-left').click(function(){
			if(Qtd != 0){
				Qtd--;
				FooterCarouselAnimation(Qtd);
			}
			else{
				Qtd = 2;
				FooterCarouselAnimation(Qtd);
			}
		});
		
		$('#arrow-right').click(function(){
			if(Qtd != 2){
				Qtd++
				FooterCarouselAnimation(Qtd);
			}
			else{
				Qtd = 0;
				FooterCarouselAnimation(Qtd);
			}
		});
		
		//TABS
		
		$('.tab_link').click(function(){
			var tabCurrentClass = $(this).attr("class");
			
			if(!$(this).hasClass("selected_tab_link")){
				var tabDestiny = $(this).attr("href");
				var tabDestinyPreview = $('.selected_tab_link').attr("href");
				
				$(tabDestiny).css({'display':'block'});
				$(tabDestinyPreview).css({'display':'none'});
				
				$(".selected_tab_link").removeClass("selected_tab_link");
				
				$(this).addClass("selected_tab_link");
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
		});
	});

	
	function load(firstTime) {

	
			message_delivery(firstTime); // 1=Mensagem enviada!; 2=Falha no envio.

		
					
//		if ( null!== showMessage ) {
//			$('#mask').fadeIn('fast');
//			$('#form_window').fadeIn('slow');
//			$('#registration').load('<c:url value="/18/showMessage" />');	
//			form_window_loaded = true;
//		}
		
	}

	function message_delivery (message_delivery_value){
		if (message_delivery_value == 1) {
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/18/welcome" />');	
			form_window_loaded = true;
		}
		else if (message_delivery_value == 2) {
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/users/8/signup"/>');	
			form_window_loaded = true;
		}		
		else if (message_delivery_value==3){
			$('#message_delivery').fadeIn('fast');
		}
		else if(message_delivery_value==4){
			$('#fail_message_delivery').fadeIn('fast');
		}
		else if(message_delivery_value==5){
			$('#message_upload_ok').fadeIn('fast');
		}		
		else if(message_delivery_value==6){
			$('#message_upload_error').fadeIn('fast');
		}
		else if(message_delivery_value==7){
			$('#message_login_error').fadeIn('fast');
		}		
		else{
			$('#fail_message_delivery, message_delivery').fadeOut('fast');
		}
	}
	
	//MAP AND GEOREFERENCING CREATION AND SETTING
	var geocoder;
	var map;
	
	function initialize() {
		var street = "<c:out value="${photo.street}"/>";
		var district = "<c:out value="${photo.district}"/>";
		var city = "<c:out value="${photo.city}"/>";
		var state = "<c:out value="${photo.state}"/>";
		var country = "<c:out value="${photo.country}"/>";
		var address = street + "," + city + "-" + state + "," + country;
		
		geocoder = new google.maps.Geocoder();
		
		var latlng = new google.maps.LatLng(-34.397, 150.644);
		var myOptions = {
		  zoom: 15,
		  center: latlng,
		  mapTypeId: google.maps.MapTypeId.ROADMAP
		}						    

		map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
		
		geocoder.geocode( { 'address': address}, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				map.setCenter(results[0].geometry.location);
				var marker = new google.maps.Marker({
					map: map,
					position: results[0].geometry.location
			});
			} else {
				alert("Geocode was not successful for the following reason: " + status);
			}
		});
	}
</script>	

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-20571872-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>