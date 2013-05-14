<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>

<%@ attribute name="albumMgr" required="true" rtexprvalue="true"
	type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance"%>

<c:if test="${albumMgr.collablet.enabled}">
	<r:callMethod methodName="countAllAlbums" instance="${albumMgr}" var="count" />
	<p id="image_counter">O Arquigrafia conta com um total de <c:out value="${count}"/> coleções.</p>
</c:if>