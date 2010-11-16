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
        <title>Arquigrafia Brasil - Edi&ccedil;&atilde;o de &aacute;lbum</title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/jquery.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.custom.min.js"></script>
        
        <script type="text/javascript">
            $(document).ready((function() {
                $("#dateInput").datepicker({
                    "showOn": "button",
                    "changeMonth": true,
                    "changeYear": true,
                    "width": 15,
                    "dateFormat": "dd/mm/yy",
                    "buttonImage": "${pageContext.request.contextPath}/images/calendar.gif",
                    "buttonImageOnly": true
                });
            }));            
        </script>
    </head>
    <body>
        <w:topo collabletInstance="${albumMgr.collablet}" />
        <w:conteudoPagina titulo="Álbum: ${album.title}">
            <br />
            <h1><span class="style1">Editar &aacute;lbum</span></h1>
            <br />
            <form name="dados" method="POST" action="<c:url value="/groupware-workbench/album/${albumMgr.id}/save"/>">
                <input type="hidden" name="album.id" value="${album.id}" />
                <div>
                    <ul>
                        <li>T&iacute;tulo</li>
                        <li><input size="60" type="text" name="album.title" value="${album.title}" /></li>
                    </ul>
                    <ul>
                        <div class="${formLineClass}">
                            <label for="album.creationDate" class="${formLabelClass}"><span>Data de cria&ccedil;&atilde;o:</span></label>
                            <span class="${formInputClass}">
                                <input type="text" id="dateInput" name="album.creationDate" value="${album.formattedCreationDate}" />
                            </span>
                        </div>
                    </ul>
                    <ul>
                        <div class="${formLineClass}">
                            <label for="album.description" class="${formLabelClass}"><span>Descri&ccedil;&atilde;o:</span></label>
                            <span class="${formInputClass}">
                                <textarea name="album.description">${album.description}</textarea>
                            </span>
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
                <w:voltar collabletInstance="${albumMgr.collablet}" />
            </div>
        </w:conteudoPagina>
    </body>
</html>
