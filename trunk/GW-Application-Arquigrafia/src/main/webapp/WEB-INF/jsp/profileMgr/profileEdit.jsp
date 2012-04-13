<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="profile"
	uri="http://www.groupwareworkbench.org.br/widgets/profile"%>

<h2>Editar perfil</h2>
<form id="form1" class="cmxform" name="dados" method="POST"
	action="<c:url value="/groupware-workbench/profile/${profileMgr.id}/save" />"
	accept-charset="UTF-8" autocomplete="off">
	<input type="hidden" name="user.id" value="<c:out value="${user.id}" />" /> 
    <input type="hidden" name="profile.birthday" value="<c:out value="${profile.birthday}" />" /> 
    <input type="hidden" name="profile.nativeLanguage" value="<c:out value="${profile.nativeLanguage}" />" /> 
    <input type="hidden" name="profile.webPage" value="<c:out value="${profile.webPage}" />" /> 
    <input type="hidden" name="profile.relationship" value="<c:out value="${profile.relationship}" />" /> 
    <input type="hidden" name="profile.gender" value="<c:out value="${profile.gender}" />" /> 
    <input type="hidden" name="profile.address" value="<c:out value="${profile.address}" />" /> 
    <input type="hidden" name="profile.city" value="<c:out value="${profile.city}" />" /> 
    <input type="hidden" name="profile.stateOrProvince" value="<c:out value="${profile.stateOrProvince}" />" /> 
    <input type="hidden" name="profile.country" value="<c:out value="${profile.country}" />" /> 
    <input type="hidden" name="profile.phone" value="<c:out value="${profile.phone}" />" /> 
    <input type="hidden" name="profile.profession" value="<c:out value="${profile.profession}" />" /> 
    <input type="hidden" name="profile.company" value="<c:out value="${profile.company}" />" /> 
	<c:if test="${profileMgr.collablet.enabled}">
		<profile:edit_formacao profileMgr="${profileMgr}" user="${user}" />
	</c:if>
	<div>
		<input name="enviar" type="submit" class="submit cursor" value="" />
	</div>
</form>