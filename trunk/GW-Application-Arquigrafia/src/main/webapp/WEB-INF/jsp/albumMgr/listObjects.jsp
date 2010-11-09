<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="album" uri="http://www.groupwareworkbench.org.br/widgets/album"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/page_content.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/search.css" />
        <title>Arquigrafia Brasil - Lista de fotos</title>
    </head>
    <body>
        <w:topo collabletInstance="${albumMgr.collablet}" />
        <w:conteudoPagina titulo="Album: ${album.title}">
            <br />
            <h1><span class="style1">Lista de elementos</span></h1>
            <br />

            <div id="search_scroll">
                <album:listPhotos  albumMgr="${albumMgr}" objects="${objectList}" showName="true" />
                <%--<photo:list photos="${photoList}" photoInstance="${photoInstance}" showName="true" showLocation="false" lineClass="search_line" /> --%>
            </div>
            <br />
        </w:conteudoPagina>
    </body>
</html>