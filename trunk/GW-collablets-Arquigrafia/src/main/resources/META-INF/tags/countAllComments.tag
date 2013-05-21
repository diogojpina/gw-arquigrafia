<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>

<%@ attribute name="commentMgr" required="true" rtexprvalue="true"
	type="br.org.groupwareworkbench.collablet.communic.comment.CommentMgrInstance"%>

<c:if test="${commentMgr.collablet.enabled}">
	<r:callMethod methodName="countAllComments" instance="${commentMgr}" var="count" />
	<r:callMethod methodName="countLastMonthComments" instance="${commentMgr}" var="countLM" />
	<r:callMethod methodName="countLastWeekComments" instance="${commentMgr}" var="countLW" />

	<p id="image_counter">O Arquigrafia conta com um total de <c:out value="${count}"/> comentários,
	sendo <c:out value="${countLM}"/> comentários novos no último mês e <c:out value="${countLW}"/>
	na última semana.</p>
</c:if>