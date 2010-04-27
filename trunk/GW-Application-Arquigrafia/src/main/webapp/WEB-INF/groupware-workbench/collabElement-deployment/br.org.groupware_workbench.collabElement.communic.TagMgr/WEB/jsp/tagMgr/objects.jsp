<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="cache-control" content="no-cache">
        <title>Obejetos Tagueados</title>
        <link href="${pageContext.request.contextPath}/css/novo.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <Widgets:Topo collabletInstance="${collabletInstance}" />
        <Widgets:ConteudoPagina titulo="Obejetos Tagueados">            
	        <c:forEach items="${geList}" var="genericEntity">
	            <a href="${pageContext.request.contextPath}${urlComponent}/${genericEntity.id}">${urlComponent}/${genericEntity.id}</a>
	            <br/>
	        </c:forEach>
	        <br/>
	    <Widgets:Voltar collabletInstance="${collabletInstance}" isCollabElement="true" />
        </Widgets:ConteudoPagina>
    </body>
</html>