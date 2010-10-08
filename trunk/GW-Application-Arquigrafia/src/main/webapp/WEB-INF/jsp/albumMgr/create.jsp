<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="album" uri="http://www.groupwareworkbench.org.br/widgets/album" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Create Album</title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        
        <script type="text/javascript">
            $(function() {
                $("#datepicker").datepicker({
                    "showOn": "button",
                    "changeMonth": true,
                    "changeYear": true,
                    "width": 15,
                    "dateFormat": "dd/mm/yy",
                    "buttonImage": "${pageContext.request.contextPath}/images/calendar.gif",
                    "buttonImageOnly": true
                });

                $("#imageUpload").jqUploader({
                    background: "FFFFDF",
                    barColor: "CD270A",
                    allowedExt: "*.avi; *.jpg; *.jpeg; *.png",
                    allowedExtDescr: "Images and movies (*.avi; *.jpg; *.jpeg; *.png)"
                });
            });
        </script>
    </head>
    <body>
        <w:topo collabletInstance="${albumMgr.collablet}" />
        <w:conteudoPagina titulo="Create Album">
            <br />
            <h1><span class="style1">Create Album</span></h1>
            <br />
            <form name="dados" method="post" action="<c:url value="${pageContext.request.contextPath}/groupware-workbench/album/save/${album.id}"/>">
                <input type="hidden" name="album.id" value="<c:out value="${album.id}" />" />
                <div>
                    <ul>
                        <li>Title</li>
                        <li><input size="60" type="text" name="album.title" value="<c:out value="${album.title}" />" /></li>
                    </ul>
                    <ul>
                        <div class="${formLineClass}">
                            <label for="album.creationDate" class="${formLabelClass}"><span>Creation Date:</span></label>
                            <span class="${formInputClass}"><input type="text" id="datepicker" name="album.creationDate" /></span>
                        </div>
                    </ul>
                    <ul>
                        <div class="${formLineClass}">
                            <label for="album.updateDate" class="${formLabelClass}"><span>Update Date:</span></label>
                            <span class="${formInputClass}"><input type="text" id="datepicker" name="album.updateDate" /></span>
                        </div>
                    </ul>
                    <ul>
                        <li></li>
                        <li>
                            <input type="submit" class="botao" value="Save" />
                        </li>
                    </ul>
                </div>
            </form>
            <div class="barra_botoes">
                <w:voltar collabletInstance="${albumMgr.collablet.parent}" />
            </div>
        </w:conteudoPagina>
    </body>
</html>
