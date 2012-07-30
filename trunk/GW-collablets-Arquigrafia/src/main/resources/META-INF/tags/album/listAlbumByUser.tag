<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ taglib prefix="album" uri="http://www.groupwareworkbench.org.br/widgets/album" %>
<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance" %>
<%@ attribute name="user" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.user.User" %>

<%@ attribute name="albumListClass" required="false" rtexprvalue="true"
	type="java.lang.String"%>

<%@ attribute name="albumBarId" required="false" rtexprvalue="true"
	type="java.lang.String"%>


<r:callMethod methodName="listByUser" instance="${albumMgr}" var="albunsByUser" >
    <r:param type="br.org.groupwareworkbench.collablet.coord.user.User" value="${user}" />
</r:callMethod>

<div class="<c:out value="${albumListClass}" default="album-list-block"/>">
			
			<input id="context_path" type="hidden" value="${pageContext.request.contextPath}"/>
			
      <div id="<c:out value="${albumBarId}" default="album_bar"/>">
		<h1>Álbuns:</h1>
		<a id="new_album" href="<c:url value="/groupware-workbench/album/${albumMgr.id}"/>">+ Adicionar</a>
        <br />

		<c:forEach items="${albunsByUser}" var="album">
			<album:album album="${album}" albumMgr="${albumMgr}" />
			<c:if test="${sessionScope.userLogin.id eq album.owner.id}">
				<a id="edit_album" href="<c:url value="/groupware-workbench/album/${albumMgr.id}/edit/${album.id}"/>">Editar</a>
				<a id="delete_album" href="<c:url value="/groupware-workbench/album/${albumMgr.id}/destroy/${album.id}"/>">Excluir</a>
			</c:if>
			<strong id="name" class="name_album">${album.title}</strong>
		</c:forEach>
    
    </div>
</div>