<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="login_modal_box">
<h2>Login</h2>
<p>Fa�a seu login para poder compartilhar imagens no Arquigrafia.</p>
<br />
<form id="usuariosForm" method="post" name="loginForm" action="<c:url value="/users/${userMgr.id}/login" />">
<div>
  <label>Login:</label>
  <input name="user.login" type="text" class="email" autofocus="autofocus" />
  <br />
  <label>Senha:</label>
  <input name="user.password" type="password" class="text" />
  <br />
  
  <br/>
  <div>
  	<a href="<c:url value="/groupware-workbench/externalaccount/${externalAccountMgr.id}/${userMgr.id}/${roleMgr.id}/loginFacebookAuth?auth=s"
/>"><img src="<c:url value="/img/redesSociais/facebook.jpeg"/>" alt="Loggin with facebook"/></a><br/><br/>
  	<a href="<c:url value="/groupware-workbench/externalaccount/${externalAccountMgr.id}/${userMgr.id}/${roleMgr.id}/TwitterApi"/>"><img src="
<c:url value="/img/redesSociais/twitter-signin.png"/>" alt="Loggin with twitter"/></a><br/><br/>
  	<a href="<c:url value="/groupware-workbench/externalaccount/${externalAccountMgr.id}/${userMgr.id}/${roleMgr.id}/loginOrkutAuth"/>"><img s
rc="<c:url value="/img/redesSociais/google.png"/>" alt="Loggin with orkut"/></a><br/>
  </div>
  
  
</div>
<div>
  Ainda n�o e usu�rio do arquigrafia?
  <br />
  Envie um email para <a href="mailto:arquigrafiabrasil@gmail.com " target="_blank">arquigrafiabrasil@gmail.com</a> e assim que poss�vel convidaremos voc� para participar.
  <!-- N�o possui cadastro, pois ent�o n�o perca tempo, <a href="#" name="Cadastre-se">cadastre-se</a> e comece a publicar e compartilhar fotos no site.
  <br />
  <br />
  Ou ent�o, fa�a seu login pelo <a href="#" name="Facebook">facebook</a>, <a href="#" name="Twitter">twitter</a> ou <a href="#" name="Twitter">Google</a>.
  <br />
  <a href="#" name="Facebook" id="login_facebook_icon"></a>
  <a href="#" name="Twitter" id="login_twitter_icon"></a><br />
  <a href="#" name="Google" id="login_google_icon"></a>  -->
  <br/><br/>
  <a id="forgot_password" href="<c:url value="/users/${userMgr.id}/forgotPassword"/>" >Esqueceu sua senha?</a>
</div>
<input name="enviar" type="submit" value="" id="login_white_button" />
</form>
</div>