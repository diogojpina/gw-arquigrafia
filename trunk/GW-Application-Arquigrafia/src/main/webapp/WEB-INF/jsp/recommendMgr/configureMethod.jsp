<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Recomenda&ccedil;&otilde;es</title>
        <link href="<c:url value="/css/common.css" rel="stylesheet" type="text/css" />"/>
        <script type="text/javascript" src="<c:url value="/js/listagem.js"/>"></script>
    </head>
    <body>
        <w:topo collabletInstance="${recommendMgr.collablet}" />
        <w:conteudoPagina titulo="Configuração dos atributos da ferramenta:">
            <br />

            <form method="POST" action="<c:url value="/groupware-workbench/recommend/${recommendMgr.id}/updateMethodsEnable" />">
                <c:forEach items="${classes}" var="clazz">
                    <div>
                        <p>Nome da classe: <c:out value="${clazz.name}" /></p>
                        <ul>
                            <c:forEach var="method" varStatus="status" items="${clazz.methods}">
                                <li>
                                    <input type="checkbox" name="enabledMethodList[${status.count}]" value="<c:out value="${clazz.name}" />:<c:out value="${method.value.name}" />" <c:if test="${method.value.enabled}">checked="checked"</c:if> />
                                    <c:out value="${method.value.name}" />
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:forEach>
                <input type="submit" class="botao" value="Confirma" />
            </form>

            <div class="barra_botoes">
                <w:voltar collabletInstance="${recommendMgr.collablet}" />
            </div>
        </w:conteudoPagina>
    </body>
</html>