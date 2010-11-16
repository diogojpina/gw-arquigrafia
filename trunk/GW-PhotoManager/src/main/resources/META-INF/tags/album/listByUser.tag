<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance" %>
<%@ attribute name="user" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.user.User" %>

<r:callMethod methodName="listByUser" instance="${albumMgr}" var="albunsByUser" >
    <r:param type="br.org.groupwareworkbench.collablet.coord.user.User" value="${user}" />
</r:callMethod>

<c:forEach items="${albunsByUser}" var="album">
    <div>${album.title}</div>
</c:forEach>
