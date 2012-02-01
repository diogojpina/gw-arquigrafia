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
        <title>Papel</title>
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
        <script type="text/javascript" src="<c:url value="/js/jquery.boxy.js"/>"></script>
	    
        <script type="text/javascript">
            $(document).ready(function() {
                $("div#makeMeScrollable").smoothDivScroll({
                    scrollingSpeed: 12,
                    mouseDownSpeedBooster: 3,
                    visibleHotSpots: "always",
                    startAtElementId: "startAtMe"
                });

                $("div#makeMeScrollable2").smoothDivScroll({
                    scrollingSpeed: 12,
                    mouseDownSpeedBooster: 3,
                    visibleHotSpots: "always",
                    startAtElementId: "startAtMe"
                });
            });
        </script>
    </head>
    <body>
        <arq:header2 photoInstance="${photoMgr}" />
        <w:conteudoPagina titulo="Papel">
            <br />
            <form name="dados" method="POST" action='<c:url value="/groupware-workbench/roles/${roleMgr.id}" />' accept-charset="UTF-8">
                <input type="hidden" name="role.id" value="<c:out value="${role.id}" />" />
                <input type="hidden" name="role.idInstance" value="<c:out value="${roleMgr.id}" />" />
                <div class="form_1" id="role_retrieve_f1">
                    <ul class="field_line_f1">
                        <li class="label_f1"><span>Nome</span></li>
                        <li class="input_f1"><input type="text" name="role.name" value="<c:out value="${role.name}" />" /></li>
                    </ul>
                </div>
                <div class="form_1">
                    <ul class="bt_line_f1">
                        <li class="bt_cell_submit"><input type="submit" class="botao" value="Ok" /></li>
                    </ul>
                </div>
            </form>
            <br>
            <c:if test="${role.id != null}">
                <a href='<c:url value="/groupware-workbench/roles/${roleMgr.id}/role/${role.id}/functionalities" />'>Editar funcionalidades</a>
            </c:if>
            <br>
            <div class="barra_botoes">
                <w:voltar collabletInstance="${roleMgr.collablet}" />
            </div>
        </w:conteudoPagina>
        <div>
            <div style="height: 30px; background-color: #fff"></div>
            <arq:footer photoInstance="${photoMgr}" />
        </div>
    </body>
</html>