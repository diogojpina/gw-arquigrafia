<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="login_modal_box">
<h2>Login</h2>
<p>Faça seu login para poder compartilhar imagens no Arquigrafia.</p>
<br />
<form id="usuariosForm" method="post" name="loginForm" action="<c:url value="/users/${userMgr.id}/login" />">
<div>
  <label>Login:</label>
  <input name="user.login" type="text" class="email" autofocus="autofocus" />
  <br />
  <label>Senha:</label>
  <input name="user.password" type="password" class="text" />
  <br />
  <br />
    <a id="forgot_password" href="<c:url value="/users/${userMgr.id}/forgotPassword"/>" >Esqueceu sua senha?</a>
  <br />
  
  <br/>

  
  
</div>
<div>
  Ainda não é usuário do arquigrafia?
  <br />Pois então não perca tempo, <a id="registration_user" href="<c:url value="/users/8/signup"/>" >cadastre-se</a> e comece a publicar e compartilhar fotos no site.
  <br />
  <br />Ou conecte-se com:</
  <br />
  <br />  
    <div>
      <br />
  	<a href="<c:url value="/groupware-workbench/externalaccount/${externalAccountMgr.id}/${userMgr.id}/${roleMgr.id}/loginFacebookAuth?auth=s"/>">
		<img src="<c:url value="/img/redesSociais/face-signin.png"/>" alt="Conectar com o facebook"/></a><br/><br/>
  	<a href="<c:url value="/groupware-workbench/externalaccount/${externalAccountMgr.id}/${userMgr.id}/${roleMgr.id}/TwitterApi"/>">
  		<img src=" <c:url value="/img/redesSociais/twitter-signin.png"/>" alt="Conectar com o facebook"/></a><br/><br/>
<%--   	<a href="<c:url value="/groupware-workbench/externalaccount/${externalAccountMgr.id}/${userMgr.id}/${roleMgr.id}/loginOrkutAuth"/>">
  		<img src="<c:url value="/img/redesSociais/google-signin.png"/>" alt="Conectar com o facebook"/></a><br/>
 --%>  </div>

</div>
<input name="enviar" type="submit" value="" id="login_white_button" />
</form>
</div>