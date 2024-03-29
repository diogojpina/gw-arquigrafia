<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r"
	uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ taglib prefix="s"
	uri="http://www.groupwareworkbench.org.br/widgets/security"%>
<%@ taglib prefix="album"
	uri="http://www.groupwareworkbench.org.br/widgets/album"%>
<%@ attribute name="albumMgr" required="true" rtexprvalue="true"
	type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance"%>
<%@ attribute name="user" required="true" rtexprvalue="true"
	type="br.org.groupwareworkbench.collablet.coord.user.User"%>

<%@ attribute name="albumListClass" required="false" rtexprvalue="true"
	type="java.lang.String"%>

<%@ attribute name="albumBarId" required="false" rtexprvalue="true"
	type="java.lang.String"%>


<r:callMethod methodName="listByUser" instance="${albumMgr}"
	var="albunsByUser">
	<r:param type="br.org.groupwareworkbench.collablet.coord.user.User"
		value="${user}" />
</r:callMethod>

<div
	class="<c:out value="${albumListClass}" default="album-list-block"/>">

	<input id="context_path" type="hidden"
		value="${pageContext.request.contextPath}" />

	<div id="<c:out value="${albumBarId}" default="album_bar"/>">
		<c:choose>
			<c:when test="${empty user.photoURL}">
				<img id="single_view_user_thumbnail"
					src="<c:url value="/img/avatar.jpg" />" />
			</c:when>
			<c:otherwise>
				<img id="single_view_user_thumbnail"
					src="<c:url value="${user.photoURL}" />" />
			</c:otherwise>
		</c:choose>

		<span id="single_view_owner_name"><a
			href="<c:url value="/friends/11/show/${user.id}" />" id="name">
				${user.name} </a></span> <br /> <br /> <br />

		<h1>Coleções:</h1>
		<s:check name="X-X-usuario">
			<a id="new_album" href="<c:url value="/album/${albumMgr.id}"/>">+
				Adicionar</a>
		</s:check>
		<br />

		<c:forEach items="${albunsByUser}" var="album">
			<div style="text-align: center;">
				<album:album album="${album}" albumMgr="${albumMgr}" />
				<span class="name_album"> <strong id="name">${album.title}</strong>
					<c:if
						test="${sessionScope.userLogin.id eq album.owner.id and album.title ne 'Favoritos'}">
						<a id="edit_album"
							href="<c:url value="/album/${albumMgr.id}/edit/${album.id}"/>">Editar</a>
						<a id="delete_album"
							href="<c:url value="/album/${albumMgr.id}/destroy/${album.id}"/>">Excluir</a>
					</c:if>
				</span>
			</div>
		</c:forEach>
	</div>
</div>