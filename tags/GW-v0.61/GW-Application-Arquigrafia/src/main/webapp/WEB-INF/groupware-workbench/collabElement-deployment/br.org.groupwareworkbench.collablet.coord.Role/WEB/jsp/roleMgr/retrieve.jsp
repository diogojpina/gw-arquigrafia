<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Papel</title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
    </head>
    <body>
        <w:topo collabletInstance="${collabletInstance}" />
        <w:conteudoPagina titulo="Papel">
            <br />
            <form name="dados" method="POST" action='<c:url value="/groupware-workbench/${collabletInstance.id}/roleMgr/${roleMgr.id}" />' accept-charset="UTF-8">
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
            <div class="barra_botoes">
                <w:voltar collabletInstance="${collabletInstance}" />
            </div>
        </w:conteudoPagina>
    </body>
</html>