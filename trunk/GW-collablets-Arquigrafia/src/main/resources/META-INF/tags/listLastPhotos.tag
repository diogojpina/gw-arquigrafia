<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true"
	type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance"%>
<%@ attribute name="amount" required="false" rtexprvalue="false" type="java.lang.Integer" %>

<c:if test="${photoInstance.collablet.enabled}">
	<r:callMethod methodName="listLastPhotos" instance="${photoInstance}" var="photos" >
    	<r:param type="java.lang.Integer" value="${amount}" />
	</r:callMethod>
	<c:forEach var="foto" items="${photos}">
			<a class="footer_image" 
				href="<c:url value="/photo/${foto.id}"/>"> <img
				src="<c:url value="/photo/img-thumb/${foto.id}"/>?_log=no" />
			</a>
	</c:forEach>
</c:if>