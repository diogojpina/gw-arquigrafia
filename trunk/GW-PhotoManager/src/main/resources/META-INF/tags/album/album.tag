<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="album" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.Album" %>
<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance" %>
<div style="margin-bottom: 30px;">
    <a href="${pageContext.request.contextPath}/groupware-workbench/album/${albumMgr.id}/listPhotos/${album.id}">
        <div style="background-color: gray; width: 56px; margin-left:auto; margin-right:auto;">
        <img style="border: 0; margin: 3px; width: 50px; height: 50px;" src="${album.urlCover}"/>
        </div>
        <div style="text-align: center;">${album.title}</div>
    </a>
</div>