<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Arquigrafia Brasil OAuth Provider</title>
    </head>
    <body>
        <jsp:include page="banner.jsp"/>

    <h3>"${appDesc}" está intentando acessar suas informações.</h3>

    <form name="authZForm" action='<c:url value="/authorize"/>' method="POST">
        <input type="hidden" name="oauth_token" value="${token}"/>
        <input type="hidden" name="oauth_callback" value="${callback}"/>
        <input type="submit" name="Authorize" value="Authorize"/>
    </form>

    <form name="authZForm" action='<c:url value="/"/>' method="GET">
        <input type="submit" name="Authorize" value="Deny"/>
    </form>

    </body>
</html>
