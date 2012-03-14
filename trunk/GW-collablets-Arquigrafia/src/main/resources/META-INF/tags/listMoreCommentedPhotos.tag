<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>

<%@ attribute name="commentMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.communic.comment.CommentMgrInstance" %>
<%@ attribute name="amount" required="false" rtexprvalue="false" type="java.lang.Integer" %>

<c:if test="${commentMgr.collablet.enabled}">
	<r:callMethod methodName="listMoreCommented" instance="${commentMgr}" var="photos" >
    	<r:param type="java.lang.Integer" value="${amount}" />
	</r:callMethod>
	<c:forEach var="foto" items="${photos}">
		<div class="${lineClass}" style="float: left">
			<a class="${linkClass}" rel="linkimage"
				href="<c:url value="/groupware-workbench/photo/${foto.id}"/>"> <img
				src="<c:url value="/groupware-workbench/photo/img-thumb/${foto.id}"/>?_log=no" />
			</a>
		</div>
	</c:forEach>
</c:if>