<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true"
	type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance"%>

<c:if test="${photoInstance.collablet.enabled}">
	<r:callMethod methodName="countAllPhotos" instance="${photoInstance}" var="count" />
	<span>"${count}"</span>
</c:if>