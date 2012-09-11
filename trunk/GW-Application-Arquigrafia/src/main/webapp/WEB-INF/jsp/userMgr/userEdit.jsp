<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="profile" uri="http://www.groupwareworkbench.org.br/widgets/profile" %>

<h2>Editar Usuário</h2>
<br />
	<small>* Todos os campos a seguir são obrigatórios.</small></p>
	<form id="form1" class="cmxform" name="dados" method="POST" action="<c:url value="/users/${userMgr.id}" />" accept-charset="UTF-8" autocomplete="off">
		<input type="hidden" name="user.id" value="<c:out value="${user.id}" />" />
		<input type="hidden" name="user.photoURL" <c:out value="${user.photoURL}" />" />
       	<div>
       	<h3>Dados do usuário</h3>
       		<p>
				<label>Login*:</label>
     				<input type="text" class="required" name="user.login" value="<c:out value="${user.login}" />" />
     			<br />
     			<label>E-mail*:</label>
     				<input type="text" class="required email" name="user.email" value="<c:out value="${user.email}" />" id="email" /></li>
     			<label>Nome*:</label>
     				<input type="text" class="required" name="user.name" value="<c:out value="${user.name}" />"  id="name" />
     			<br />
     		</p>
		</div>
		<div>
			<input name="enviar" type="submit" class="submit cursor" value="" />
		</div>
	</form>