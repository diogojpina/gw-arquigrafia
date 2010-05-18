<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="cache-control" content="no-cache">
        <title>Objetos Tagueados</title>
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <Widgets:Topo collabletInstance="${collabletInstance}" />
        <Widgets:ConteudoPagina titulo="Objetos Tagueados">
            <c:forEach items="${geList}" var="genericEntity">
                <a href="<c:url value="${Widgets:urlIdCollablet(urlComponent, genericEntity.idInstance)}/${genericEntity.id}" />" ><c:url value="${Widgets:urlIdCollablet(urlComponent, genericEntity.idInstance)}/${genericEntity.id}" /></a>
                <br />
            </c:forEach>
            <div class="barra_botoes">
                <Widgets:Voltar collabletInstance="${collabletInstance}" />
            </div>
        </Widgets:ConteudoPagina>
    </body>
</html>