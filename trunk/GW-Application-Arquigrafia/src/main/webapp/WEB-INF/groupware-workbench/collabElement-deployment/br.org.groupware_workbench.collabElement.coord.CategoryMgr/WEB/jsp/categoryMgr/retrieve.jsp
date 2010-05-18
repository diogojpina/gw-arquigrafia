<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
        <meta http-equiv="Cache-Control" content="no-cache" >
        <title>Categoria</title>
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    </head>
    <body>
        <Widgets:Topo collabletInstance="${collabletInstance}" />
        <Widgets:ConteudoPagina titulo="Categoria">
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
                <Widgets:Voltar collabletInstance="${collabletInstance}" />
            </form>
        </Widgets:ConteudoPagina>
    </body>
</html>