<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Categoria</title>
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    </head>
    <body>
        <w:topo collabletInstance="${collabletInstance}" />
        <w:conteudoPagina titulo="Categoria">
            <br/>
            <ul>
                <c:forEach var="error" items="${errors}">
                    <li><c:out value="${error.message}" /> - <c:out value="${error.category}" /></li>
                </c:forEach>
            </ul>

            <form id="dados" class="cmxform" name="dados" method="POST" action="<c:url value="/groupware-workbench/${param.collablet}/categoryMgr/${param.categoryMgr}" />" accept-charset="UTF-8">
                <input type="hidden" name="category.id" value="<c:out value="${category.id}" />" />
                <br/>
                Nome: <input type="text" name="category.name" value="${category.name}" />
                <br/>
                <input type="submit" class="botao" value="Ok">
                &nbsp; &nbsp;
                <w:voltar collabletInstance="${collabletInstance}" />
            </form>
        </w:conteudoPagina>
    </body>
</html>