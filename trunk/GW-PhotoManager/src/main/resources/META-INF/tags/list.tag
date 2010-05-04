<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.groupwareworkbench.org.br/taglibs/reflection"
	prefix="r"%>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag"
	prefix="TagMgr"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" 
	type="br.org.groupware_workbench.photo.PhotoMgrInstance"%>
<%@ attribute name="photos" required="true" rtexprvalue="true"
	type="java.util.List"%>
<%@ attribute name="linkClass" required="false" type="String" %>
<%@ attribute name="showName" required="false" type="Boolean" rtexprvalue="false" %>
<%@ attribute name="showLocation" required="false" type="Boolean" rtexprvalue="false" %>
<%@ attribute name="nameClass" required="false" type="String" %>
<%@ attribute name="locationclass" required="false" type="String" %>

<r:callMethod methodName="getDirImagesRelativo"
	instance="${photoInstance}" var="dirImagen" />
<r:callMethod methodName="getThumbPrefix" instance="${photoInstance}"
	var="thumbPrefix" />
<r:callMethod methodName="getMostraPrefix" instance="${photoInstance}"
	var="showPrefix" />

	<c:forEach var="foto" items="${photos}">
		<c:if test="${showName} || ${showLocattion}">
			<div><div>
		</c:if>
		<a class="${linkClass}" rel="linkimage"
				href="<c:url value="/groupware-workbench/${photoInstance.id}/photo/show/${foto.id}"/>">							
			<img
				src="${pageContext.request.contextPath}/${dirImagen}/${thumbPrefix}${foto.nomeArquivo}" alt="${foto.nome}"/>
			</a>
			<c:if test="${showName} || ${showLocattion}">
				</div>
			</c:if>
			<c:if test="${showName}">
				<div class="${nameClass}">
					${foto.nome}
				</div>
			</c:if>
			<c:if test="${showLocation}">
				<div class="${locationClass}" >
					${foto.lugar}
				</div>
			</c:if>
			<c:if test="${showName} || ${showLocattion}">
				</div>
			</c:if>
		</tr>
	</c:forEach>
</table>

