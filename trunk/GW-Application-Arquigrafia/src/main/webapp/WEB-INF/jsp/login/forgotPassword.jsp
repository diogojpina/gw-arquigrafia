<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="forgot_password_modal_box">
	<h2>Esqueci minha senha</h2>
	<p>Não se preocupe! Digite seu e-mail e nós enviaremos instruções de redefinição de senha.</p>
	<br />
	<form id="send_forgot_password" method="post" name="loginForm" action="<c:url value="/groupware-workbench/users/${userMgr.id}/password" />">
		<div>
			<label>E-mail:</label> 
			<input name="email" type="text" class="email" /> <br /> 

		</div>

     <div id="validation_error" class="message_delivery_generic" >
     </div>   


		<input name="enviar" type="submit" value="" id="login_white_button" />
	</form>
</div>


<script type="text/javascript">

$(function() {
	
	function success(message) {
 			$('#forgot_password_modal_box').empty().append(message);
	}
	
	$('#send_forgot_password').submit(function(e){
		e.preventDefault();
 		$.post(this.action, $(this).serialize(), success, 'json')
		
 		.error(function(validation) {
				var messages = $.parseJSON(validation.responseText),
						validations = '';
				jQuery.each(messages.errors, function(index, item){
					validations += item.message;
				});			
				$('#validation_error').empty().append(validations);
 		 });
 	});
	
	
});

</script>
