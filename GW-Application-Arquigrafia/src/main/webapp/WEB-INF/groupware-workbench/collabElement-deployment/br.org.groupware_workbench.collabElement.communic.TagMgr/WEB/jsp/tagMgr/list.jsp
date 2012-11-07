<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/collections" prefix="coll" %>
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
        <Widgets:Tabela baseUrl="/groupware-workbench/${collabletInstance.id}/tagMgr/${param.tagMgr}"
                        msgAdd="Adicionar nova tag"
                        msgDelete="Tem certeza que deseja remover a tag?"
                        target="tabela-tags"
                        titles="${coll:asList1('Nome')}"
                        columns="${coll:asList2('!URL', 'name')}"
                        elements="${tagList}"
                        cellProcessFunc="criarCelulaTag"
                        rowProcess="true" />
    </head>
    <body>
        <Widgets:Topo collabletInstance="${collabletInstance}" />
        <Widgets:ConteudoPagina titulo="Tags">
            <div id="tabela-tags"></div>
            <div class="barra_botoes">
                <Widgets:Voltar collabletInstance="${collabletInstance}" />
            </div>
        </Widgets:ConteudoPagina>
    </body>
</html>
