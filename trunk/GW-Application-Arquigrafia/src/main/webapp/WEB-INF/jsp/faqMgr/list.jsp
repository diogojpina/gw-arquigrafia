<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="coll" uri="http://www.groupwareworkbench.org.br/widgets/collections" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Perguntas frequentes</title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/page_content.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <w:tabela baseUrl="/groupware-workbench/faq"
                  msgAdd="Adicionar nova pergunta"
                  msgDelete="Tem certeza que deseja excluir a pergunta?"
                  msgVazio="Não há perguntas no FAQ."
                  target="tabela-perguntas"
                  titles="${coll:asList1('Pergunta')}"
                  columns="${coll:asList1('pergunta')}"
                  elements="${faqList}" />
    </head>
    <body>
        <w:topo collabletInstance="${faqMgr}" />

        <w:conteudoPagina titulo="Faq">

            <div id="subtitle_1">
                <span class="subTitulo">Configura&ccedil;&atilde;o</span>
                <w:configuracao collabletInstance="${faqMgr}" />
            </div>

            <div id="subtitle_2">
                <span class="subTitulo">Lista de perguntas e respostas frequentes</span>
                <div id="tabela-perguntas"></div>
            </div>

            <div id="subtitle_3">
                <span class="subTitulo">Collablets</span>
                <w:menuFerramentas collabletInstance="${faqMgr.collablet}" />
            </div>

            <div class="barra_botoes">
                <w:voltar collabletInstance="${faqMgr.parent}" />
            </div>
        </w:conteudoPagina>
    </body>
</html>