<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>


<%@ attribute name="counterMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.counter.CounterMgrInstance" %>
<%@ attribute name="amount" required="false" rtexprvalue="false" type="java.lang.Integer" %>

<c:if test="${counterMgr.collablet.enabled}">
	<r:callMethod methodName="listGreaters" instance="${counterMgr}" var="greaters" >
    	<r:param type="java.lang.Integer" value="${amount}" />
	</r:callMethod>
	<c:forEach var="foto" items="${greaters}" varStatus="counter">
			<c:if test="${foto.deleted == false}">
				<a rel="linkimage" class="footer_image"
					href="<c:url value="/photo/${foto.id}"/>">
					<img src="<c:url value="/photo/img-thumb/${foto.id}"/>?_log=no" />
				</a>
			</c:if>
	</c:forEach>
</c:if>