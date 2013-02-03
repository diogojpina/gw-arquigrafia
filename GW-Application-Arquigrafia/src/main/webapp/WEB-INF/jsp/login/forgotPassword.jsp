<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="forgot_password_modal_box">
	<h2>Esqueci minha senha</h2>
	<p>Não se preocupe! Digite seu e-mail e nós enviaremos instruções de redefinição de senha.</p>
	<br />
	<form id="send_forgot_password" method="post" name="loginForm" action="<c:url value="/users/${userMgr.id}/password" />">
		<div>
			<label>E-mail:</label> 
			<input name="email" type="text" class="email" /> <br /> 

		</div>

     <div id="validation_error" class="message_delivery_generic" >
     </div>   


		<input name="enviar" type="submit" value="" id="login_white_button" />
	</form>
</div>

<script type="text/javascript" src="<c:url value="/js/login.js" />"></script>	
