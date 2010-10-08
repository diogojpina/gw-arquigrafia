<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Configura&ccedil;&atilde;o de Not&iacute;cias</title>
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
    </head>
    <body>
        <w:topo collabletInstance="${recommendMgr.collablet}" />
        <w:conteudoPagina titulo="Configuração de Recomendações:">
            <br />
            <form name="dados" method="POST" action="<c:url value="/groupware-workbench/recommend/${recommendMgr.id}/updateNumRelated" />">
                <div class="form_1">
                    N&uacute;mero de Recomenda&ccedil;&otilde;es: &nbsp;&nbsp;
                    <input type="text" name="max" size="4" value="${numRelated}" />
                    <input type="submit" class="botao" value="Ok" />
                </div>
            </form>
            <div class="form_1">
                <span class="style8">
                    <a href="<c:url value="/groupware-workbench/recommend/${recommendMgr.id}/calcRecommned"/>">Recalcular os valores de similaridade</a>
                </span>
            </div>

            <form name="dados" method="GET" action="<c:url value="/groupware-workbench/recommend/${recommendMgr.id}/configureMethod" />">
            	<div class="form_1">
                    <span class="style8">
                        <a href="<c:url value="/groupware-workbench/recommend/${recommendMgr.id}/configureMethod"/>">
                            <%-- TODO: Participarão se refere aos atributos ou aos componentes? --%>
                            Configurar atributos do componente para as recomendações
                        </a>
                    </span>
                </div>
            </form>

            <div class="barra_botoes">
                <w:voltar collabletInstance="${recommendMgr.collablet.parent}" />
            </div>
        </w:conteudoPagina>
    </body>
</html>