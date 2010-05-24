<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/collections" prefix="coll" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bin&ocirc;mios</title>
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <Widgets:Tabela baseUrl="/groupware-workbench/${param.collablet}/binomialMgr/${param.binomialMgr}"
                        msgAdd="Adicionar novo binômio"
                        msgDelete="Tem certeza que deseja remover o binômio?"
                        target="tabela-binomials"
                        titles="${coll:asList3('Primeiro Bin&ocirc;mio', 'Segundo Bin&ocirc;mio', 'Valor')}"
                        columns="${coll:asList3('firstBinomial', 'secondBinomial', 'value')}"
                        elements="${binomialList}" />
    </head>
    <body>
        <Widgets:Topo collabletInstance="${collabletInstance}" />
        <Widgets:ConteudoPagina titulo="Bin&ocirc;mios">
            <div id="tabela-binomials"></div>
            <div class="barra_botoes">
                <Widgets:Voltar collabletInstance="${collabletInstance}" />
            </div>
        </Widgets:ConteudoPagina>
    </body>
</html>
