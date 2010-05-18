<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/collections" prefix="coll" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usu&aacute;rio</title>
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <Widgets:Tabela baseUrl="/groupware-workbench/${param.collablet}/userMgr/${param.userMgr}"
                        msgAdd="Adicionar novo usuário"
                        msgDelete="Tem certeza que deseja remover o usuário?"
                        target="tabela-users"
                        titles="${coll:asList3('Nome', 'Login', 'E-mail')}"
                        columns="${coll:asList3('name', 'login', 'email')}"
                        elements="${userList}" />
    </head>
    <body>
        <Widgets:Topo collabletInstance="${collabletInstance}" />
        <Widgets:ConteudoPagina titulo="Usu&aacute;rios">
            <div id="tabela-users"></div>
            <div class="barra_botoes">
                <Widgets:Voltar collabletInstance="${collabletInstance}" />
            </div>
        </Widgets:ConteudoPagina>
    </body>
</html>