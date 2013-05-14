<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>

<%@ attribute name="userMgr" required="true" rtexprvalue="true"
	type="br.org.groupwareworkbench.collablet.coord.user.UserMgrInstance"%>

<c:if test="${userMgr.collablet.enabled}">
	<r:callMethod methodName="countAllUsers" instance="${userMgr}" var="count" />
	<p id="image_counter">O Arquigrafia conta com um total de <c:out value="${count}"/> usuários.</p>
</c:if>