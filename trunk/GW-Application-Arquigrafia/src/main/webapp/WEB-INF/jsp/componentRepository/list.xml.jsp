<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<repository>
    <components>
        <c:forEach var="cmp" items="${componentList}">
            <component id="${cmp.id}" name="${cmp.name}" description="${cmp.description}" action="${cmp.action}" version="${cmp.version}" md5hash="${cmp.md5hash}" size="${cmp.size}" />
        </c:forEach>
    </components>
</repository>