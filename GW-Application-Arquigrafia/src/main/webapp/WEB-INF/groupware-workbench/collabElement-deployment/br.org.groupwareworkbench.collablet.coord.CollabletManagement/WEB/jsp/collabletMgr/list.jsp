<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Gerenciador de Ferramentas</title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
    </head>
    <body>
        <w:topo collabletInstance="${collabletInstance}" />
        <w:conteudoPagina titulo="Gerenciador de Ferramentas">
            <form method="post" action="<c:url value="/groupware-workbench/${collabletInstance.id}/collabletMgr/refresh" />">
                <c:choose>
                    <c:when test="${not empty collabletInstance.subordinatedInstances}">
                        <br />
                        Abaixo est&atilde;o as Ferramentas que podem ser usados neste contexto.
                        <br />
                        <br />
                        <input type="hidden" name="allCollabletComponentCods" value="" />
                        <input type="hidden" name="allCollabletComponentCods" value="<c:out value="${collabletInstance.component.cod}" />" />
                        <input type="hidden" name="checkedCollabletComponentCods" value="" />
                        <input type="hidden" name="checkedCollabletComponentCods" value="<c:out value="${collabletInstance.component.cod}" />" />
                        <%-- TODO: Rever a formatação. --%>
                        <table cellpadding="3" cellspacing="0">
                            <thead>
                                <tr>
                                    <th style="border-color: black; border-width: 1px; border-style: solid; ">Habilitado</th>
                                    <th style="border-color: black; border-width: 1px; border-style: solid; ">Ferramenta</th>
                                    <th style="border-color: black; border-width: 1px; border-style: solid; ">Grupo</th>
                                    <th style="border-color: black; border-width: 1px; border-style: solid; ">Descri&ccedil;&atilde;o</th>
                                </tr>
                            </thead>
                            <c:forEach var="instance" items="${collabletInstance.subordinatedInstances}">
                                <tr>
                                    <td style="border-color: black; border-width: 1px; border-style: solid;">
                                        <input type="hidden" name="allCollabletComponentCods" value="<c:out value="${instance.component.cod}" />" />
                                        <input type="checkbox" name="checkedCollabletComponentCods" value="<c:out value="${instance.component.cod}" />"
                                        <c:if test="${instance.enabled}">checked="checked"</c:if> />
                                    </td>
                                    <td style="border-color: black; border-width: 1px; border-style: solid; "><c:out value="${instance.component.name}" /></td>
                                    <td style="border-color: black; border-width: 1px; border-style: solid; "><c:out value="${instance.component.cod}" /></td>
                                    <td style="border-color: black; border-width: 1px; border-style: solid; "><c:out value="${instance.component.description}" /></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <br />
                        N&atilde;o existem ferramentas para serem utilizadas neste contexto.
                        <br />
                        <br />
                    </c:otherwise>
                </c:choose>
                <div style=" clear: both; padding-top: 8px;">
                    <input class="botao" type="submit" name="Ok" value="Ok - Refresh" />
                </div>
            </form>
            <div class="barra_botoes">
                <w:voltar collabletInstance="${collabletInstance}" />
            </div>
        </w:conteudoPagina>
    </body>
</html>