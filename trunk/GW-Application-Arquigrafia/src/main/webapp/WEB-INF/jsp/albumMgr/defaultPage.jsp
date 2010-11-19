<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="album" uri="http://www.groupwareworkbench.org.br/widgets/album"%>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <title>Arquigrafia Brasil - &Aacute;lbuns</title>
    
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/arq-common.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/know_more.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/forms.css"  />
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/plugins/sds/css/smoothDivScroll.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/bay.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/footer.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/jquery.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/tagcloud.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/image_wall.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/boxy.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.custom.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/scroll.js"></script>
    <style type="text/css">
     .text, .title, .span_link{
        font-size: 12px;
        font-family: Arial,Helvetica,sans-serif;
     }
     .title {
        font-weight: bold;
     }
     .span_link {
        color: blue;
        cursor: pointer;
        text-decoration: underline;
     }
     .component_header {
        background-color: #483E37;
        color: white;
        padding: 5px;
        -moz-border-radius: 5px 5px 0 0;
        margin-bottom: 10px;
     }
     
    </style>
</head>
<body>
    <arq:header2 photoInstance="${photoMgr}" />
    <div style="display: block;">
    <div class="text" style="float: left; margin-left: -350px; border: 1px solid; -moz-border-radius: 5px; width: 170px;">
        <div class="component_header" style="height: 25px;"><span class="title" style="color:white;">Meus Albums</span></div>
        <div style="margin-bottom: 30px;"><span class="span_link" style="margin-left: 10px;">criar novo album</span></div>
        <album:listByUser albumMgr="${albumMgr}" user="${userLogin}"/>
    </div>
    <album:anadir albumMgr="${albumMgr}" user="${userLogin}" style="margin-left:200px; width:80%; height:640px; margin-right: auto; border: 1px solid; -moz-border-radius: 5px;"/>
    </div>
    <arq:footer photoInstance="${photoMgr}" />    
</body>
</html>