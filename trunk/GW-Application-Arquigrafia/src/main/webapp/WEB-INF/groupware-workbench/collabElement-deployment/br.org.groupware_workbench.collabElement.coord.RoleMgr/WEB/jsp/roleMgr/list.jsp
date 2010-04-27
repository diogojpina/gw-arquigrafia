<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
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
    <script type="text/javascript">
        function incluir() {
            window.location.href = "<c:url value="/groupware-workbench/${param.collablet}/roleMgr/${param.roleMgr}/0" />";
        }

        function deletar(url) {
            $.post(url, { _method: 'DELETE'},
            	    function(data) {
                        window.open('<c:url value="/groupware-workbench/${param.collablet}/roleMgr/${param.roleMgr}" />', '_self');
                        window.location.reload(true);
                        return false;
                    }
            ); }
    </script>
    </head>
    <body>
        <Widgets:Topo collabletInstance="${collabletInstance}" />
        <Widgets:ConteudoPagina titulo="Papéis">
            <br/>
            <script type="text/javascript">
                var tabRoles = new Tabela('tabRoles');
                tabRoles.addColuna('Papel', 'left', true);
                tabRoles.addColuna('Opções', 'left', false);
            </script>

            <script type="text/javascript">
            <c:forEach var="role" items="${roleList}">
                tabRoles.addCelula('${role.name}', '${role.name}');

                var options =
                    '<a href="<c:url value="/groupware-workbench/${param.collablet}/roleMgr/${param.roleMgr}/${role.id}" />">' +
                    '<img src="${pageContext.request.contextPath}/images/icon/edit.gif" border="0" alt="Editar">' +
                    '</a> | ';
                options +=
                    "<a href=\"#\" onclick=\"deletar('<c:url value="/groupware-workbench/${param.collablet}/roleMgr/${param.roleMgr}/${role.id}" />');\" >" +
                    "<img src='${pageContext.request.contextPath}/images/icon/delete.gif' border='0' alt='delete' />" +
                    "</a>";

                tabRoles.addCelula(options, '${role.id}');
            </c:forEach>
            tabRoles.mostraListagem();
            </script>
            <div style=" clear: both; padding-top: 8px;">
                <input type="button" class="botao" onclick="incluir()" value="Adicionar Papel" />
                <br/>
                <Widgets:Voltar collabletInstance="${collabletInstance}" isCollabElement="true" />
            </div>
        </Widgets:ConteudoPagina>
    </body>
</html>