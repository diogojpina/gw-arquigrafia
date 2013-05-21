<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>

<%@ attribute name="tagMgr" required="true" rtexprvalue="true"
	type="br.org.groupwareworkbench.collablet.communic.tag.TagMgrInstance"%>

<c:if test="${tagMgr.collablet.enabled}">
	<r:callMethod methodName="countAllTags" instance="${tagMgr}" var="count" />
	<p class="counter">O Arquigrafia conta com um total de <c:out value="${count}"/> tags.</p>
</c:if>