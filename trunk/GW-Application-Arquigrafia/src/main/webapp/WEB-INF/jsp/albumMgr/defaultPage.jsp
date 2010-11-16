<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="album" uri="http://www.groupwareworkbench.org.br/widgets/album"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/page_content.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <title>Arquigrafia Brasil - &Aacute;lbuns</title>
    <title>Insert title here</title>
</head>
<body>
    <w:topo collabletInstance="${albumMgr.collablet}" />
    <w:conteudoPagina titulo="Álbuns: ">
        <br />
        <h1><span class="style1">Lista de &Aacute;lbuns</span></h1>
        <br />
        <album:listByUser albumMgr="${albumMgr}" user="${userLogin}" />
    </w:conteudoPagina>
</body>
</html>