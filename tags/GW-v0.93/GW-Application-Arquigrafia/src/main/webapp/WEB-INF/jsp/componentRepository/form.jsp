<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Arquigrafia Brasil</title>
        <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/images/favicon.ico" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/reset.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/arq-common.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/header.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/know_more.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/forms.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/plugins/sds/css/smoothDivScroll.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/bay.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/footer.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/jquery.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/tagcloud.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/image_wall.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/boxy.css" />"/>
        <script type="text/javascript" src="<c:url value="/js/jquery.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery-ui.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/scroll.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/chili-1.7.pack.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.easing.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.dimensions.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.accordion.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/bay.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.boxy.js"/>"></script>
        <style type="text/css">
        	ul{ margin-left: 100px;}
        	input[type=text], input[type=file], textarea{ width: 250px; margin-bottom: 10px; }
        	input[type=submit]{ margin: 0 auto; }
        </style>
    </head>
    <body>
        <div id="wrap">
            <arq:header2 photoInstance="${photoMgr}" />
            <div class="default_div">
                <h1>Cadastre um novo componente no Reposit&oacute;rio</h1>
                <c:if test="${!empty errors}">
                    <c:forEach var="error" items="${errors}">
                        <p><c:out value="${error.category}" />: <c:out value="${error.message}" /></p>
                    </c:forEach>
                </c:if>
                <form method="post" action="<c:url value="/groupware-workbench/repository/${componentRepository.id}/new" />" enctype="multipart/form-data">
                    <ul>
                        <li>Nome:<br /><input type="text" name="component.name" value="<c:out value="${component.name}" />" /></li>
                        <li>Descri&ccedil;&atilde;o:<br /><textarea name="component.description"><c:out value="${component.description}" /></textarea></li>
                        <li>Pacote:<br /><input type="text" name="component.packageName" value="<c:out value="${component.packageName}" />" /></li>
                        <li>A&ccedil;&atilde;o:<br /><input type="text" name="component.action" value="<c:out value="${component.action}" />" /></li>
                        <li>Vers&atilde;o:<br /><input type="text" name="component.version" value="<c:out value="${component.version}" />" /></li>
                        <li>Arquivo APK:<br /><input type="file" name="componentUploadedFile" /></li>
                        <li><input type="submit" value="Cadastrar" /></li>
                    </ul>
                </form>
	        </div>
	        <div style="height: 30px; background-color: #fff;">&nbsp;</div>
            <arq:footer photoInstance="${photoMgr}" />
        </div>
    </body>
</html>