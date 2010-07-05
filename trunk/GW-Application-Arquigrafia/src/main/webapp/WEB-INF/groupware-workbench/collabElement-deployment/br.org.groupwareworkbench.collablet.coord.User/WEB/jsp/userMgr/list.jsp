<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="coll" uri="http://www.groupwareworkbench.org.br/widgets/collections" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Usu&aacute;rio</title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <w:tabela baseUrl="/groupware-workbench/${param.collablet}/userMgr/${param.userMgr}"
                  msgAdd="Adicionar novo usuário"
                  msgDelete="Tem certeza que deseja remover o usuário?"
                  target="tabela-users"
                  titles="${coll:asList3('Nome', 'Login', 'E-mail')}"
                  columns="${coll:asList3('name', 'login', 'email')}"
                  elements="${userList}" />
    </head>
    <body>
        <w:topo collabletInstance="${collabletInstance}" />
        <w:conteudoPagina titulo="Usu&aacute;rios">
            <div id="tabela-users"></div>
            <div class="barra_botoes">
                <w:voltar collabletInstance="${collabletInstance}" />
            </div>
        </w:conteudoPagina>
    </body>
</html>