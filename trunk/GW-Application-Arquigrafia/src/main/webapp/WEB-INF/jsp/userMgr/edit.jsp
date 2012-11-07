<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="profile" uri="http://www.groupwareworkbench.org.br/widgets/profile" %>

<h2>Editar Usuário</h2>
<br />
	<small>* Todos os campos a seguir são obrigatórios.</small></p>
	<form id="form1" class="cmxform" name="dados" method="POST" action="<c:url value="/users/${userMgr.id}/saveWithUrl" />" accept-charset="UTF-8" autocomplete="off">
		<input type="hidden" name="user.id" value="<c:out value="${user.id}" />" />
       	<input type="hidden" id="url" name="url" value="/friends/${friendsMgr.id}/show/${userLogin.id}" />
       	<input type="hidden" id="part" name="part" value="<c:out value="${part}" />" />
       	<div>
       	<h3>Dados do usuário</h3>
       		<p>
				<label>Login*:</label>
     				<input type="text" class="required" name="user.login" value="<c:out value="${user.login}" />" />
     			<label>Senha*:</label>
     				<input type="password" class="required" name="user.password" value="<c:out value="${user.password}" />" id="password" /></li>
     			<br />
     			<label>E-mail*:</label>
     				<input type="text" class="required email" name="user.email" value="<c:out value="${user.email}" />" id="email" /></li>
     			<label>Nome*:</label>
     				<input type="text" class="required" name="user.name" value="<c:out value="${user.name}" />"  id="name" />
     			<br />
     			<label>Endereço da sua foto:</label>
     				<input type="text" name="user.photoURL" value="<c:out value="${user.photoURL}" />"  id="photoURL" />
     		</p>
		</div>
		<c:if test="${profileMgr.collablet.enabled}">
			<c:if test="${part == 'perfil'}">
				<profile:edit_perfil profileMgr="${profileMgr}" user="${user}" />
			</c:if>
			<c:if test="${part == 'formacao'}">
				<profile:edit_formacao profileMgr="${profileMgr}" user="${user}" />
			</c:if>
			<c:if test="${part == 'localizacao'}">
				<profile:edit_localizacao profileMgr="${profileMgr}" user="${user}" />
			</c:if>
			<c:if test="${part == 'contato'}">
				<profile:edit_contato profileMgr="${profileMgr}" user="${user}" />
			</c:if>
		</c:if>
		<div>
			<input name="enviar" type="submit" class="submit cursor" value="" />
		</div>
	</form>