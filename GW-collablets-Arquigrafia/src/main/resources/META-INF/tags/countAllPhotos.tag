<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>

<%@ attribute name="photoMgr" required="true" rtexprvalue="true"
	type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance"%>

<c:if test="${photoMgr.collablet.enabled}">
	<r:callMethod methodName="countAllPhotos" instance="${photoMgr}" var="count" />
	<r:callMethod methodName="countLastMonthPhotos" instance="${photoMgr}" var="countLM" />
	<r:callMethod methodName="countLastWeekPhotos" instance="${photoMgr}" var="countLW" />	
	
	<p id="image_counter">O Arquigrafia conta com um total de <c:out value="${count}"/> fotos,
	sendo <c:out value="${countLM}"/> fotos novas no último mês e <c:out value="${countLW}"/>
	na última semana.</p>
</c:if>