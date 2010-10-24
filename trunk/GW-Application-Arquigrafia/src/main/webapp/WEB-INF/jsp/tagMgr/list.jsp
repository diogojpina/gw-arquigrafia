<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="coll" uri="http://www.groupwareworkbench.org.br/widgets/collections" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Tags</title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript">
            function renderizarCelulaTag(celula, coluna, elem) {
                elem.css({"text-align": coluna.esquerda ? "left" : "right"});
                var link = $("<a></a>");
                elem.append(link);
                link.attr("href", "#");
                link.html(celula.nome);
                link.click(function(evt) {
                    window.open(celula.url, '_self');
                });
            }

            function criarCelulaTag(tabela, url, nome) {
                var celula = new CelulaCallback(renderizarCelulaTag);
                celula.nome = nome;
                celula.url = url;
                tabela.addCelulaElemento(celula);
            }
        </script>
        <w:tabela baseUrl="/groupware-workbench/tags"
                  msgDelete="Tem certeza que deseja remover a tag?"
                  target="tabela-tags"
                  titles="${coll:asList1('Nome')}"
                  columns="${coll:asList2('!URL', 'name')}"
                  elements="${tagList}"
                  cellProcessFunc="criarCelulaTag"
                  rowProcess="true" />
    </head>
    <body>
        <w:topo collabletInstance="${tagMgr.collablet}" />
        <w:conteudoPagina titulo="Tags">
            <div id="tabela-tags"></div>
            <div class="barra_botoes">
                <w:voltar collabletInstance="${tagMgr.collablet.parent}" />
            </div>
        </w:conteudoPagina>
    </body>
</html>
