<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="cache-control" content="no-cache">
        <title>Pap&eacute;is</title>
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
    </head>
    <body>
        <Widgets:Topo collabletInstance="${collabletInstance}" />
        <Widgets:ConteudoPagina titulo="Tags">
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
                		<li class="bt_cell_submit"><input type="button" class="botao" value="Cancela" onclick="history.back()" /></li>
                	</ul>
                </div>
            </form>
            <br />
        </Widgets:ConteudoPagina>
    </body>
</html>