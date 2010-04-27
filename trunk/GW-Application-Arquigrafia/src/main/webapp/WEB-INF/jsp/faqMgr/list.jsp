<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
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
        <script type="text/javascript">
            function incluir() {
                window.location.href = "<c:url value="/groupware-workbench/${faqMgr.id}/faq/0" />";
            }

            function deletar(url) {
                $.post(url,
                    { _method: 'DELETE'},
                    function(data) {
                        window.open('<c:url value="/groupware-workbench/${faqMgr.id}/faq" />', '_self');
                        window.location.reload(true);
                        return false;
                    }
                );
            }
        </script>
    </head>
    <body>
        <Widgets:Topo collabletInstance="${faqMgr}" />

        <Widgets:ConteudoPagina titulo="Faq">
            <br />
            Lista de perguntas e respostas frequentes
            <br />
            <!-- --------- Configuração --------------  -->
            <div id="subtitle_1">
           		<Widgets:Configuracao collabletInstance="${faqMgr}" />
           	</div>

			<div id="subtitle_2">
            	<span class="subTitulo">Perguntas frequentes</span>
            </div>
            <c:choose>
                <c:when test="${empty faqList}">
                    <br />
                    N&atilde;o h&aacute; perguntas no FAQ.
                    <br />
                    <br />
                </c:when>

                <c:otherwise>
                    <script type="text/javascript">
                        var tabFaq = new Tabela('tabFaq');
                        tabFaq.addColuna('Perguntas', 'left', true);
                        tabFaq.addColuna('Opções', 'left', false);
                    </script>
                    <div>
                        <c:forEach var="faq" items="${faqList}">
                            <script type="text/javascript">
                                tabFaq.addCelula('<c:out value="${faq.pergunta}" />', '<c:out value="${faq.pergunta}" />');

                                var options =
                                    '<a href="<c:url value="/groupware-workbench/${faqMgr.id}/faq/${faq.id}" />">' +
                                        '<img src="${pageContext.request.contextPath}/images/icon/edit.gif" border="0" alt="Editar">' +
                                    '</a> | ';

                                options +=
                                    "<a href=\"#\" onclick=\"deletar('<c:url value="/groupware-workbench/${faqMgr.id}/faq/${faq.id}" />');\">" +
                                        "<img src='${pageContext.request.contextPath}/images/icon/delete.gif' border='0' alt='delete' />" +
                                    "</a>";

                                tabFaq.addCelula(options, '<c:out value="${faq.id}" />');
                            </script>
                        </c:forEach>
                        <script type="text/javascript">
                            tabFaq.mostraListagem();
                        </script>
                    </div>
                </c:otherwise>
            </c:choose>

            <div style="clear: both; padding-top: 8px;">
                <input type="button" class="botao" onclick="incluir()" value="Adicionar nova pergunta" />

                <br />
                <br />

                <!-- --------- Collablets -------------- -->
                <c:if test="${!empty faqMgr.subordinatedInstances}">
                	<div id="subtitle_3">
                    	<span class="subTitulo">Collablets</span>
                    </div>
                    <br />

                    <Widgets:MenuFerramentas collabletInstance="${faqMgr}" groups="${groups}" />
                    <br />
                    <br />
                    <br />
                </c:if>
                <Widgets:Voltar collabletInstance="${faqMgr}" />
            </div>
        </Widgets:ConteudoPagina>
    </body>
</html>