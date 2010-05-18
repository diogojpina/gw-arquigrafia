<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/collections" prefix="coll"%>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Categorias</title>
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <Widgets:Tabela baseUrl="/groupware-workbench/${param.collablet}/categoryMgr/${param.categoryMgr}"
                        msgAdd="Adicionar nova categoria"
                        msgDelete="Tem certeza que deseja remover a categoria?"
                        target="tabela-categoria"
                        titles="${coll:asList1('Nome')}"
                        columns="${coll:asList1('name')}"
                        elements="${categoryList}" />
    </head>
    <body>
        <Widgets:Topo collabletInstance="${collabletInstance}" />
        <Widgets:ConteudoPagina titulo="Categorias">
            <div id="tabela-categoria"></div>
            <div class="barra_botoes">
                <Widgets:Voltar collabletInstance="${collabletInstance}" />
            </div>
        </Widgets:ConteudoPagina>
    </body>
</html>