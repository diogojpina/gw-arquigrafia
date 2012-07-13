<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="profile" uri="http://www.groupwareworkbench.org.br/widgets/profile" %>

<h2>Editar Usuário</h2>
<br />
	<small>* Todos os campos a seguir são obrigatórios.</small></p>
	<form id="form1" class="cmxform" name="dados" method="POST" action="<c:url value="/groupware-workbench/users/${userMgr.id}" />" accept-charset="UTF-8" autocomplete="off">
		<input type="hidden" name="user.id" value="<c:out value="${user.id}" />" />
		<input type="hidden" name="_method" value="put" />
		<input type="hidden" name="user.photoURL" <c:out value="${user.photoURL}" />" />
       	<div>
       	<h3>Dados do usuário</h3>
   		<p>
				<label>Senha antiga*:</label>
     		<input type="password" class="required" name="user.password" />
   			<br />
   			<label>Nova senha*:</label>
 				<input type="password" class="required" name="newPassword" id="password" />
   			<label>Confirmar nova senha*:</label>
 				<input type="password" class="required" name="confirmationPassword" />
   		</p>
		</div>
		<div>
			<input name="enviar" type="submit" class="submit cursor" value="" />
		</div>
	</form>