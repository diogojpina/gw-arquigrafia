<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>


<%@ attribute name="counterMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.counter.CounterMgrInstance" %>
<%@ attribute name="amount" required="false" rtexprvalue="false" type="java.lang.Integer" %>
<%@ attribute name="columns" required="false" rtexprvalue="false" type="java.lang.Integer" %>

<c:if test="${counterMgr.collablet.enabled}">
	<r:callMethod methodName="listGreaters" instance="${counterMgr}" var="greaters" >
    	<r:param type="java.lang.Integer" value="${amount}" />
	</r:callMethod>
	<div class="images_column">
	<c:forEach var="foto" items="${greaters}" varStatus="counter">
		<div class="images_column" style="float: left">
			<a rel="linkimage"
				href="<c:url value="/groupware-workbench/photo/${foto.id}"/>"> <img
				src="<c:url value="/groupware-workbench/photo/img-thumb/${foto.id}"/>?_log=no" width="170" height="117" />
			</a>
            <c:if test="${ ( (counter.count > 1) and ((counter.count mod columns) eq 0 ))}">
                 </div>
                 <div class="images_column">
            </c:if>
		</div>
	</c:forEach>
	</div>
</c:if>