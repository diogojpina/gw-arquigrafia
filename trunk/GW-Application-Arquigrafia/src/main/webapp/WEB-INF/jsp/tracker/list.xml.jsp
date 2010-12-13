<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<GeoObjects>
    <c:forEach var="ti" items="${trackingInfoList}">
        <GeoObject lat="<c:out value="${ti.latitude}" />"
        lon="<c:out value="${ti.longitude}" />"
        label="<c:out value="${ti.user.name}" />"
        reference="<c:out value="${ti.accuracy}" />"
        type="user" />
    </c:forEach>
</GeoObjects>