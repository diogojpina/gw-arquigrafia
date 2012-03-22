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
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js"></script>
<script type="text/javascript" src="<c:url value="/js/jquery-ui-1.8.17.custom.min.js" />"></script>

<script type="text/javascript">
	form_window_loaded = false;

	$(document).ready(function(){

		$('#edit_perfil_button').click(function(){
			var part = "perfil";
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/groupware-workbench/user/edit/${userLogin.id}/'+part+'"/>');	
			form_window_loaded = true;
		});

		$('#edit_formacao_button').click(function(){
			var part = "formacao";
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/groupware-workbench/user/edit/${userLogin.id}/'+part+'"/>');	
			form_window_loaded = true;
		});

		$('#edit_localizacao_button').click(function(){
			var part = "localizacao";
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/groupware-workbench/user/edit/${userLogin.id}/'+part+'"/>');	
			form_window_loaded = true;
		});

		$('#edit_contato_button').click(function(){
			var part = "contato";
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/groupware-workbench/user/edit/${userLogin.id}/'+part+'"/>');	
			form_window_loaded = true;
		});
		
		$('#registration_button').click(function(){
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/users/${userMgr.id}/signup"/>');	
			form_window_loaded = true;
		});
		
		$('#upload').click(function(){
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/6/upload"/>');	
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
			$('#registration').load('<c:url value="/${arquigrafiaMgr.id}/contact" />');	
			form_window_loaded = true;
		});

		$('#login_button').click(function(){
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/users/${userMgr.id}/login"/>');	
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
	
			
	});

	function load(firstTime) {
		if ( firstTime == 1) {
			$('#mask').fadeIn('fast');
			$('#form_window').fadeIn('slow');
			$('#registration').load('<c:url value="/${arquigrafiaMgr.id}/welcome" />');	
			form_window_loaded = true;
		}
	}
</script>	