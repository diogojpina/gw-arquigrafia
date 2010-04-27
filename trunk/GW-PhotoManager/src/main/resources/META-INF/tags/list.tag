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

<r:callMethod methodName="getDirImagesRelativo"
	instance="${photoInstance}" var="dirImagen" />
<r:callMethod methodName="getThumbPrefix" instance="${photoInstance}"
	var="thumbPrefix" />
<r:callMethod methodName="getMostraPrefix" instance="${photoInstance}"
	var="showPrefix" />
		
<table>
	<thead>
		<tr>
			<td><b>Imagem</b></td>
			<td><b>Nome</b></td>
			<td><b>Lugar</b></td>
		</tr>
	</thead>

	<c:forEach var="foto" items="${photos}">
		<tr>
			<td><a rel="linkimage"
				href="<c:url value="/groupware-workbench/${photoInstance.id}/photo/show/${foto.id}"/>">
											
			<img
				src="${pageContext.request.contextPath}/${dirImagen}/${thumbPrefix}${foto.nomeArquivo}" />
			</a></td>
			<td>${foto.nome}</td>
			<td>${foto.lugar}</td>
		</tr>
	</c:forEach>
</table>

