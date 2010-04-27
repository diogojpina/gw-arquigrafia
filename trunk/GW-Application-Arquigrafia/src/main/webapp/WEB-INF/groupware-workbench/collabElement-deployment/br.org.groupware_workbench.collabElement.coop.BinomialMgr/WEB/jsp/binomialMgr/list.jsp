<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usu&aacute;rio</title>
		<link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" language="JavaScript">
            function incluir() {
                window.location.href = "<c:url value="/groupware-workbench/${param.collablet}/binomialMgr/${param.binomialMgr}/0" />";
            }

            function deletar(url) {
                $.post(url,
                    { _method: 'DELETE'},
                    function(data) {
                        window.open('<c:url value="/groupware-workbench/${param.collablet}/binomialMgr/${param.binomialMgr}" />', '_self');
                        return false;
                    }
                );
            }
        </script>
    </head>
    <body>
        <Widgets:Topo collabletInstance="${collabletInstance}" />
        <Widgets:ConteudoPagina titulo="">
            <h1>Binômios</h1>

            <script type="text/javascript">
                var tabBinomials = new Tabela('tabBinomials');
                tabBinomials.addColuna('Primeiro Binômio', 'left', true);
                tabBinomials.addColuna('Segundo Binômio', 'left', true);
                tabBinomials.addColuna('Valor', 'left', true);
                tabBinomials.addColuna('Op&ccedil;&otilde;es', 'left', false);
            </script>

            <script type="text/javascript">
                function confirm2(v){
                    if (!confirm('Confirma remover binômio?')) {
                        v.href = "";
                        return false;
                    }
                    return true;
                }

                <c:forEach var="binomial" items="${binomialList}">
                    tabBinomials.addCelula('<c:out value="${binomial.firstBinomial}" />', '<c:out value="${binomial.firstBinomial}" />');
                    tabBinomials.addCelula('<c:out value="${binomial.secondBinomial}" />', '<c:out value="${binomial.secondBinomial}" />');
                    tabBinomials.addCelula('<c:out value="${binomial.value}" />', '<c:out value="${binomial.value}" />');

                    var options =
                        '<a id="a1" href="<c:url value="/groupware-workbench/${param.collablet}/binomialMgr/${param.binomialMgr}/${binomial.id}" />" >' +
                            '<img src="${pageContext.request.contextPath}/images/icon/edit.gif" border="0" alt="Editar">' +
                        '</a> | ';

                    options +=
                        "<a href=\"#\" onclick=\"deletar('<c:url value="/groupware-workbench/${param.collablet}/binomialMgr/${param.binomialMgr}/${binomial.id}" />');\" >" +
                            "<img src='${pageContext.request.contextPath}/images/icon/delete.gif' border='0' alt='delete' />" +
                        "</a>";
                    tabBinomials.addCelula(options, '<c:out value="${binomial.id}" />');
                </c:forEach>
            </script>

            <script type="text/javascript">
                tabBinomials.mostraListagem();
            </script>

            <%-- if (confirm('Confirma remover usu&aacute;rio?')) return true; return false; --%>
            <div style=" clear: both; padding-top: 8px;">
                <input type="button" class="botao" onclick="incluir()" value="Adicionar novo binômio" />
                <Widgets:Voltar collabletInstance="${collabletInstance}" isCollabElement="true" />
            </div>
        </Widgets:ConteudoPagina>
    </body>
</html>
