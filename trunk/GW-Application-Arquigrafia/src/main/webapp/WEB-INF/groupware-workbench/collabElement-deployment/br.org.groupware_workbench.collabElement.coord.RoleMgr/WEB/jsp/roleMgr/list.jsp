<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/collections" prefix="coll" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Pap&eacute;is</title>
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <Widgets:Tabela baseUrl="/groupware-workbench/${collabletInstance.id}/roleMgr/${roleMgr.id}"
                        msgAdd="Adicionar Papel"
                        msgDelete="Tem certeza que deseja remover este papel?"
                        target="tabela-roles"
                        titles="${coll:asList1('Papel')}"
                        columns="${coll:asList1('name')}"
                        elements="${roleList}" />
    </head>
    <body>
        <Widgets:Topo collabletInstance="${collabletInstance}" />
        <Widgets:ConteudoPagina titulo="Pap&eacute;is">
            <div id="tabela-roles"></div>
            <Widgets:Voltar collabletInstance="${collabletInstance}" isCollabElement="true" />
        </Widgets:ConteudoPagina>
    </body>
</html>