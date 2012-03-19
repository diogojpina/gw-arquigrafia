<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	function validar(obj){
		var form = document.cadastroForm;
		if(obj.checked == true){
			form.enviar.disabled = false;
		}else{
			form.enviar.disabled= true;
		}
}
</script>

<h2>Cadastro user</h2>
	<p>Faça seu cadastro para poder publicar fotos no site Arquigrafia.<br />
  	<small>* Todos os campos a seguir são obrigatórios.</small></p>
	<form id="cadastroForm" method="post" name="cadastroForm" action='<c:url value="/groupware-workbench/users/${userMgr.id}/save"  />' onsubmit="return checkCheckBox();">
	<p>
		<input type="hidden" id="url" name="url" value="/" />
		
	  	<label>Nome*:</label>
	  		<input name="user.name" type="text" class="required" id="name"  value="<c:out value="${user.name}" />" />
	  	<!-- <label>Sobrenome*:</label>
	  		<input name="lastname" type="text" class="text" /> -->
	  	<br />
	  	<label>Login*:</label>
	  		<input name="user.login" type="text" class="required" value="<c:out value="${user.login}" />" />
	  	<label>E-mail*:</label>
	  		<input name="user.email" type="text" class="email" value="<c:out value="${user.email}" />"  />
	  	<br />
	  	<label>Senha*:</label>
	  		<input name="user.password" type="password" class="required" id="password" value="" />
	  	<label>Repita a senha*:</label>
	  		<input name="passwordConfirm" type="password" class="required" id="confirm" value="" />
	</p>
	<p>Li e aceito os <a href="#" style="text-decoration: underline;">termos de compromisso</a>: <input name="terms" type="checkbox" value="read" onclick="javascript:validar(this);"/> <br /><a href="#" id="creative_commons" style="text-decoration:underline;">Creative Commons</a></p>
	<p>
  	    <input name="enviar" type="submit" class="submit cursor" value="" disabled/>
	</p>
	</form>