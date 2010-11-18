<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<GeoObjects>
	<c:forEach var="ti" items="${trackingInfoList}">
		<GeoObject lat="${ti.latitude}" 
		lon="${ti.longitude}"
		label="${ti.userId}"
		reference="${ti.accuracy}" 
		type="user"/>
	</c:forEach>
</GeoObjects>