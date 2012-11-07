<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Arquigrafia Brasil - Admin</title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jquery-ui-1.8.custom.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/page_content.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.custom.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/fancybox/jquery.mousewheel-3.0.2.pack.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/fancybox/jquery.fancybox-1.3.1.js"></script>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/fancybox/jquery.fancybox-1.3.1.css" media="screen" />
    </head>
    <body>
        <w:topo collabletInstance="${photoInstance.collablet}" />
        <w:conteudoPagina titulo="Busca Fotos">
            <span class="subTitulo">Collablets</span>
            <br />
            <br />
            <w:menuFerramentas collabletInstance="${photoInstance.collablet}" />
            <br />
            <br />
            <br />
            <a href="<c:url value="/groupware-workbench/photo/${photoInstance.id}/registra"/>">Registrar uma nova foto</a>
            <br />
            <br />
            <div>
                <h1>Busca de Fotos</h1>
                <photo:search photoInstance="${photoInstance}" />
            </div>
            <div>
                <photo:list photos="${fotos}" photoInstance="${photoInstance}" showName="true" showLocation="true" />
            </div>
            <div>
                <h1>Lista Fotos</h1>
                <photo:listAll photoInstance="${photoInstance}" keepRatio="true" />
            </div>

            <c:forEach var="error" items="${errors}">
                <c:out value="${error.category}" /> - <c:out value="${error.message}" />
                <br />
            </c:forEach>

            <div class="barra_botoes">
                <w:voltar collabletInstance="${photoInstance.collablet}" />
            </div>
        </w:conteudoPagina>
    </body>
</html>