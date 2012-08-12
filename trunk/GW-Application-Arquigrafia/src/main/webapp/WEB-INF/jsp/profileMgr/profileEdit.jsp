<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="profile" uri="http://www.groupwareworkbench.org.br/widgets/profile"%>
<%@ taglib prefix="coll" uri="http://www.groupwareworkbench.org.br/widgets/collections" %>

<h2>Editar perfil</h2>
<p>
<small>* Todos os campos a seguir são obrigatórios.</small><p/>

<form id="form1" class="cmxform" name="dados" method="POST" action="<c:url value="/groupware-workbench/profile/${profileMgr.id}/save" />" accept-charset="UTF-8" autocomplete="off">
	<input type="hidden" name="_method" value="put" />
	<input type="hidden" name="profile.id" value='<c:out value="${profile.id}" />' />
	<input type="hidden" name="profile.birthday" value='<c:out value="${profile.birthday}" />' />
	<input type="hidden" name="profile.nativeLanguage" value='<c:out value="${profile.nativeLanguage}" />' /> 
	<input type="hidden" name="profile.webPage"value='<c:out value="${profile.webPage}" />' /> 
	<input type="hidden" name="profile.relationship" value='<c:out value="${profile.relationship}" />' /> 
	<input type="hidden" name="profile.gender" value='<c:out value="${profile.gender}" />' />
	<input type="hidden" name="profile.address" value='<c:out value="${profile.address}" />' />
	<input type="hidden" name="profile.city" value='<c:out value="${profile.city}" />' />
	<input type="hidden" name="profile.stateOrProvince" value='<c:out value="${profile.stateOrProvince}" />' />
	<input type="hidden" name="profile.country" value='<c:out value="${profile.country}" />' />
	<input type="hidden" name="profile.phone" value='<c:out value="${profile.phone}" />' />
	<input type="hidden" name="profile.profession" value='<c:out value="${profile.profession}" />' />
	<input type="hidden" name="profile.company" value='<c:out value="${profile.company}" />' />

	<c:if test="${profileMgr.collablet.enabled}">
			<div>
				<h3>Dados do perfil</h3>
				<p>
					<label>Sobrenome:</label>
					<input type="text" class="required" name="profile.secondName" value="<c:out value="${profile.secondName}" />" /><br/>
					<label>Escolaridade:</label>
     			<select name="profile.scholarity">
          		<c:forEach var="scholarity" items="${coll:enumValues('br.org.groupwareworkbench.collablet.coord.profile.Profile$Scholarity')}" >
              		<option value="${scholarity}" <c:if test="${profile.scholarity == scholarity}">selected</c:if>>
                  		<c:out value="${scholarity.name}" />
              		</option>
          		</c:forEach>
      		</select><br/>
					<label>Curso:</label>
					<input type="text" class="required" name="profile.course" value='<c:out value="${profile.course}" />' /><br/>
					<label>Instituição:</label>
					<input type="text" class="required" name="profile.institution" value='<c:out value="${profile.institution}" />' /><br/>
					<label>Ocupação:</label>
					<input type="text" class="required" name="profile.occupation" value='<c:out value="${profile.occupation}" />' /><br/>
				</p>
			</div>
	</c:if>
	<div>
		<input name="enviar" type="submit" class="submit cursor" value="" />
	</div>
</form>