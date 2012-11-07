<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag" %>

<%@ attribute name="tagMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.communic.tag.TagMgrInstance" %>

<c:set var="tags" value="${tagMgr.listByFrequency}" />
<c:set var="nValue" value="${tag:normalizedAssignments(10, tags)}" />
<c:set var="count" value="0" />
<!--   ÁREA DE TAGS   -->
<div class="tags_cloud">
	<ul>
    <c:forEach var="tag" items="${tags}">
    	<c:if test="${count<=4}"><li><a href="<c:url value="/tags/${tag.id}" />" class="C"><c:out value="${tag.name}" /></a></li></c:if>
    	<c:if test="${4<count && count<=11}"><li><a href="<c:url value="/tags/${tag.id}" />" class="B"><c:out value="${tag.name}" /></a></li></c:if>
    	<c:if test="${11<count && count<=21}"><li><a href="<c:url value="/tags/${tag.id}" />" class="A"><c:out value="${tag.name}" /></a></li></c:if>
    	<c:if test="${count==4 || count==11}"><br/></c:if>
        <c:set var="count" value="${count + 1}" />
    </c:forEach>
    </ul>
</div>
