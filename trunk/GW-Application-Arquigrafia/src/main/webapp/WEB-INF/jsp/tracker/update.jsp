<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>TrackingInfo</title>
        <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/images/favicon.ico" />"/>
    </head>
    <body>
        <c:if test="${empty errors}">OK</c:if>
            <c:if test="${!empty errors}">
                ERRO!
                <c:forEach var="error" items="${errors}">
                    <c:out value="${error.category}" /> - <c:out value="${error.message}" />
                    <br />
                </c:forEach>
            </c:if>
    </body>
</html>