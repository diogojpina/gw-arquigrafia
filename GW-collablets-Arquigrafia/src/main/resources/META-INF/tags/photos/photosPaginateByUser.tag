<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>

<%@ attribute name="photoMgr" required="true" rtexprvalue="true"
	type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance"%>
<%@ attribute name="user" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.user.User" %>
<%@ attribute name="photoPageNumber" required="false" rtexprvalue="true"
	type="java.lang.Long"%>
<%@ attribute name="photosPerPage" required="true" rtexprvalue="true"
	type="java.lang.Long"%>
<%@ attribute name="linkToPage" required="true" rtexprvalue="true"
	type="java.lang.String"%>

<c:if test="${photoMgr.collablet.enabled}">
	<r:callMethod methodName="photoPaginateCountByUser" instance="${photoMgr}" var="counter" >
    	<r:param type="java.lang.Long" value="${photosPerPage}"/>
    	<r:param type="br.org.groupwareworkbench.collablet.coord.user.User" value="${user}" />
	</r:callMethod>
	<c:if test="${counter > 1}">
		<ul>
			<c:forEach begin="0" end="${counter-1}" var="i">
				<item>
					<c:if test="${(not empty photoPageNumber) && (photoPageNumber == i)}">
						<span class="selectedPageOnPhotoPagination">
					</c:if>
					<a href='<c:url value="${linkToPage}${i}"/>'>${i+1}</a>
					<c:if test="${(not empty photoPageNumber) && (photoPageNumber == i)}">
						</span>
					</c:if>
				</item>  
			</c:forEach>
		</ul>
	</c:if>
</c:if>