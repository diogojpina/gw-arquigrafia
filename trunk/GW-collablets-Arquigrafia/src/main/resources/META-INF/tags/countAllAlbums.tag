<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>

<%@ attribute name="albumMgr" required="true" rtexprvalue="true"
	type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance"%>

<c:if test="${albumMgr.collablet.enabled}">
	<r:callMethod methodName="countAllAlbums" instance="${albumMgr}" var="count" />
	<r:callMethod methodName="countLastMonthAlbums" instance="${albumMgr}" var="countLM" />
	<r:callMethod methodName="countLastWeekAlbums" instance="${albumMgr}" var="countLW" />
	
	<p id="image_counter">O Arquigrafia conta com um total de <c:out value="${count}"/> coleções,
	sendo <c:out value="${countLM}"/> coleções novas no último mês e <c:out value="${countLW}"/>
	na última semana.</p>
</c:if>