<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Pap&eacute;is</title>
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
    </head>
    <body>
        <w:topo collabletInstance="${collabletInstance}" />
        <w:conteudoPagina titulo="Tags">
            <form name="dados" method="post" action="<c:url value="/groupware-workbench/${collabletInstance.id}/tagMgr/${tag.idInstance}" />">
                <input type="hidden" name="tag.id" value="<c:out value="${tag.id}" />" />
                <div class="form_1" id="tag_retrieve_f1">
                    <ul class="field_line_f1">
                        <li class="label_f1"><span>Nome</span></li>
                        <li class="input_f1"><input type="text" name="tag.name" value="<c:out value="${tag.name}" />" /></li>
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