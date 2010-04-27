<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tags</title>
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript">
            function confirmDeleteTag(v, url) {
                if (!confirm('Confirma remover Tag?')) {
                    v.href = "";
                    return false;
                }
                $.post(url,
                    { _method: 'DELETE' },
                    function(data) {
                        window.open('<c:url value="/groupware-workbench/${collabletInstance.id}/tagMgr/${param.tagMgr}" />', '_self');
                        window.location.reload(true);
                        return false;
                    }
                );
            }
            function listTaggedObjects(url){
            	window.open(url, '_self');
            }
        </script>
    </head>
    <body>
        <Widgets:Topo collabletInstance="${collabletInstance}" />
        <Widgets:ConteudoPagina titulo="Tags">
            <table>
                <c:forEach var="tag" items="${tagList}">
                    <tr>
                        <td>
                            <a href="#" onclick="javascript:listTaggedObjects('<c:url value="/groupware-workbench/${collabletInstance.id}/tagMgr/${tag.idInstance}/objects/${tag.id}" />');" ><c:out value="${tag.name}" /></a>
                        </td>
                        <td>
                            <a href="<c:url value="/groupware-workbench/${collabletInstance.id}/tagMgr/${tag.idInstance}/${tag.id}" />">editar</a>
                            |
                            <a href="#" onclick="javascript:confirmDeleteTag(this, '<c:url value="/groupware-workbench/${collabletInstance.id}/tagMgr/${tag.idInstance}/${tag.id}" />');">delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <a href="<c:url value="/groupware-workbench/${collabletInstance.id}/tagMgr/${param.tagMgr}/0" />">Adicionar tag</a>
            <br />
            <Widgets:Voltar collabletInstance="${collabletInstance}" isCollabElement="true" />
        </Widgets:ConteudoPagina>
    </body>
</html>
