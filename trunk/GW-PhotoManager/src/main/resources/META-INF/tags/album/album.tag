<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="album" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.Album" %>
<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance" %>

<div class="album">
    <a href="${pageContext.request.contextPath}/groupware-workbench/album/${albumMgr.id}/listPhotos/${album.id}">
        <div class="img-container">
            <img src="${album.urlCover}" />
        </div>
        <div class="album-name"><span><c:out value="${album.title}" /></span></div>
    </a>
</div>