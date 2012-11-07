<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="album" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.Album" %>
<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance" %>


<a href="${pageContext.request.contextPath}/album/${albumMgr.id}/listPhotos/${album.id}" class="image">
	<img src="<c:out value="${pageContext.request.contextPath}/img/album_icon-1.png" default="${pageContext.request.contextPath}/img/album_icon-1.png"/>" width="170" height="117" alt="<c:out value="${album.title}" />"/>
</a>

