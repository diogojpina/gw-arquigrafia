<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<repository>
    <components>
        <c:forEach var="cmp" items="${componentList}">
            <component
            	id="<c:out value="${cmp.id}" />"
            	name="<c:out value="${cmp.name}" />"
            	description="<c:out value="${cmp.description}" />"
            	action="<c:out value="${cmp.action}" />"
            	version="<c:out value="${cmp.version}" />"
            	md5hash="<c:out value="${cmp.md5hash}" />"
            	size="<c:out value="${cmp.size}" />"
            />
        </c:forEach>
    </components>
</repository>