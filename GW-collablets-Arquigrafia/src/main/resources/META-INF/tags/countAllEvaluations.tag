<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>

<%@ attribute name="binomialMgr" required="true" rtexprvalue="true"
	type="br.org.groupwareworkbench.collablet.coop.binomial.BinomialMgrInstance"%>

<c:if test="${binomialMgr.collablet.enabled}">
	<r:callMethod methodName="countAllEvaluations" instance="${binomialMgr}" var="count" />
	<p class="counter">O Arquigrafia conta com um total de <c:out value="${count}"/> avaliações.</p>
</c:if>