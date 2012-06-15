<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true"
	type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance"%>
<%@ attribute name="user" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.user.User" %>

<c:if test="${photoInstance.collablet.enabled}">
	<r:callMethod methodName="listPhotosByUser" instance="${photoMgr}" var="photos" >
    	<r:param type="br.org.groupwareworkbench.collablet.coord.user.User" value="${user}" />
	</r:callMethod>
	
	<c:forEach var="foto" items="${photos}">
			<a class="search_image" 
				href="<c:url value="/photo/${foto.id}"/>"> <img
				src="<c:url value="/photo/img-thumb/${foto.id}"/>?_log=no" />
			</a>
	</c:forEach>
</c:if>