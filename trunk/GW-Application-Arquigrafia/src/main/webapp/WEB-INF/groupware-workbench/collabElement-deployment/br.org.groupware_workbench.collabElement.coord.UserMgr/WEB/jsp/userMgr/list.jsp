<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usu&aacute;rio</title>
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" language="JavaScript">
        function incluir() {
            window.location.href = "<c:url value="/groupware-workbench/${param.collablet}/userMgr/${param.userMgr}/0" />";
        }

        function deletar(url) {
            $.post(url,
            	    { _method: 'DELETE'},
            	    function(data) {
            	        window.open('<c:url value="/groupware-workbench/${param.collablet}/userMgr/${param.userMgr}" />', '_self');
            	        return false;
            	    } ); }
        </script>
    </head>
    <body>
        <Widgets:Topo collabletInstance="${collabletInstance}" />
        <Widgets:ConteudoPagina titulo="Usuários">
        <br/>
        <script type="text/javascript">
            var tabUsers = new Tabela('tabUsers');
            tabUsers.addColuna('Nome', 'left', true);
            tabUsers.addColuna('Login', 'left', true);
            tabUsers.addColuna('Email', 'left', true);
            tabUsers.addColuna('Op&ccedil;&otilde;es', 'left', false);
        </script>
        
        <script type="text/javascript">
            <c:forEach var="user" items="${userList}">
            tabUsers.addCelula('<c:out value="${user.name}" />', '<c:out value="${user.name}" />');
            tabUsers.addCelula('<c:out value="${user.login}" />', '<c:out value="${user.login}" />');
            tabUsers.addCelula('<c:out value="${user.email}" />', '<c:out value="${user.email}" />');

            var options =
                '<a id="a1" href="<c:url value="/groupware-workbench/${param.collablet}/userMgr/${param.userMgr}/${user.id}" />" >' +
                '<img src="${pageContext.request.contextPath}/images/icon/edit.gif" border="0" alt="Editar">' +
                '</a> | ';

            options +=
                "<a href=\"#\" onclick=\"deletar('<c:url value="/groupware-workbench/${param.collablet}/userMgr/${param.userMgr}/${user.id}" />');\" >" +
                "<img src='${pageContext.request.contextPath}/images/icon/delete.gif' border='0' alt='delete' />" +
                "</a>";

            tabUsers.addCelula(options, '<c:out value="${user.id}" />');
            </c:forEach>
            tabUsers.mostraListagem();
        </script>

        <div style="clear: both; padding-top: 8px;">
            <input type="button" class="botao" onclick="incluir()" value="Adicionar novo usuário" />
            <Widgets:Voltar collabletInstance="${collabletInstance}" isCollabElement="true" />
        </div>
        </Widgets:ConteudoPagina>
    </body>
</html>