<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/photomanager" prefix="photo" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/binomial" prefix="binomialMgr" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Foto Busca</title>
        <link type="text/css" href="${pageContext.request.contextPath}/css/jquery-ui-1.8.custom.css" rel="Stylesheet" />
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/page_content.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/fancybox/jquery.fancybox-1.3.1.css" media="screen" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.custom.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/fancybox/jquery.mousewheel-3.0.2.pack.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/fancybox/jquery.fancybox-1.3.1.js"></script>
    </head>
    <body>
        <Widgets:Topo collabletInstance="${photoInstance}" />
        <Widgets:ConteudoPagina titulo="Busca Fotos">

            <div id="subtitle_1">
                <span class="subTitulo">Configura&ccedil;&atilde;o</span>
                <Widgets:Configuracao collabletInstance="${photoInstance}" />
            </div>

            <c:if test="${not empty photoInstance.subordinatedInstances}">
                <div id="subtitle_3">
                    <span class="subTitulo">Collablets</span>
                    <Widgets:MenuFerramentas collabletInstance="${photoInstance}" groups="${groups}" />
                </div>
            </c:if>

            <div>
                <a href="<c:url value="/groupware-workbench/${photoInstance.id}/photo/registra"/>">Registrar uma nova foto</a>
            </div>

            <div>
                <h1>Busca de Fotos</h1>
                <photo:search photoInstance="${photoInstance}"/>
            </div>
            <div>
                <photo:list photos="${fotos}" photoInstance="${photoInstance}" showName="true" showLocation="true"/>
            </div>
            <div>
                <h1>Lista Fotos</h1>
                <photo:listAll photoInstance="${photoInstance}" keepRatio="true"/>
            </div>

            <c:forEach var="error" items="${errors}">
                <c:out value="${error.category}" /> - <c:out value="${error.message}" />
                <br />
            </c:forEach>
            <Widgets:Voltar collabletInstance="${photoInstance}" />
        </Widgets:ConteudoPagina>
    </body>
</html>