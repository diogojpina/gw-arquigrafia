<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Friendly OAuth Provider</title>
    </head>
    <body>
        <jsp:include page="banner.jsp"/>
        
    <h3>"${appDesc}" is trying to access your information.</h3>
    
    Enter the userId you want to be known as:
    <form name="authZForm" action='<c:url value="/authorize"/>' method="POST">
        <%--input type="text" name="userId" value="${sessionScope['userLogin'].id}" size="20" /><br--%>
        <input type="text" name="userId" value="" size="20" /><br>
        <input type="hidden" name="oauth_token" value="${token}"/>
        <input type="hidden" name="oauth_callback" value="${callback}"/>
        <input type="submit" name="Authorize" value="Authorize"/>
    </form>
    
    </body>
</html>
