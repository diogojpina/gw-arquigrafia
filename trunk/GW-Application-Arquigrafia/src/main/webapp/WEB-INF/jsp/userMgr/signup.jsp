<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="<c:url value="/js/signup.js" />"></script>


<h2>Cadastro</h2>
	<p>Faça seu cadastro para poder compartilhar imagens no Arquigrafia.<br />
  	<small>* Todos os campos a seguir são obrigatórios.</small></p>
	<form id="signup" method="post" name="cadastroForm" action='<c:url value="/groupware-workbench/users/${userMgr.id}/save"  />' onsubmit="return checkCheckBox();">
	<p>
		<input type="hidden" id="url" name="url" value="/" />
		
	  	<label>Nome*:</label>
	  		<input name="user.name" type="text" id="name"  value="<c:out value="${user.name}" />" />
	  	<!-- <label>Sobrenome*:</label>
	  		<input name="lastname" type="text" class="text" /> -->
	  	<br />
	  	<label>Login*:</label>
	  		<input name="user.login" type="text" value="<c:out value="${user.login}" />" />
	  	<label>E-mail*:</label>
	  		<input name="user.email" type="text" value="<c:out value="${user.email}" />"  />
	  	<br />
	  	<label>Senha*:</label>
	  		<input name="user.password" type="password" id="password" value="" />
	  	<label>Repita a senha*:</label>
	  		<input name="passwordConfirm" type="password" id="confirm" value="" />
	</p>
	<p>Li e aceito os <a href="<c:url value="/18/termsOfService" />"  target="_blank" style="text-decoration: underline;">termos de compromisso</a>: <input name="terms" type="checkbox" value="read" onclick="javascript:validar(this);"/> <br /> <br /><a href="http://creativecommons.org/licenses/?lang=pt" id="creative_commons" style="text-decoration:underline;">Creative Commons</a></p>
	<p>
  	    <input name="enviar" type="submit" class="submit cursor" value=""/>
	</p>
	</form>