<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/collections" prefix="coll" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <title>Perguntas frequentes</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/page_content.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <Widgets:Tabela baseUrl="/groupware-workbench/${faqMgr.id}/faq"
                        msgAdd="Adicionar nova pergunta"
                        msgDelete="Tem certeza que deseja excluir a pergunta?"
                        msgVazio="Não há perguntas no FAQ."
                        target="tabela-perguntas"
                        titles="${coll:asList1('Pergunta')}"
                        columns="${coll:asList1('pergunta')}"
                        elements="${faqList}" />
    </head>
    <body>
        <Widgets:Topo collabletInstance="${faqMgr}" />

        <Widgets:ConteudoPagina titulo="Faq">

            <div id="subtitle_1">
                <span class="subTitulo">Configura&ccedil;&atilde;o</span>
                <Widgets:Configuracao collabletInstance="${faqMgr}" />
            </div>

            <div id="subtitle_2">
                <span class="subTitulo">Lista de perguntas e respostas frequentes</span>
                <div id="tabela-perguntas"></div>
            </div>

            <c:if test="${not empty faqMgr.subordinatedInstances}">
                <div id="subtitle_3">
                    <span class="subTitulo">Collablets</span>
                    <Widgets:MenuFerramentas collabletInstance="${faqMgr}" groups="${groups}" />
                </div>
            </c:if>

            <Widgets:Voltar collabletInstance="${faqMgr}" />
        </Widgets:ConteudoPagina>
    </body>
</html>