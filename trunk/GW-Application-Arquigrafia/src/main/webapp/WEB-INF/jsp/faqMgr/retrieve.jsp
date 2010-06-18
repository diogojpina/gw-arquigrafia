<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag" %>
<%@ taglib prefix="binomial" uri="http://www.groupwareworkbench.org.br/widgets/binomial" %>
<%@ taglib prefix="category" uri="http://www.groupwareworkbench.org.br/widgets/category" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Faq</title>
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <tag:scriptTags />
        <binomial:scriptBinomial />
    </head>
    <body>
        <w:topo collabletInstance="${faqMgr}" />
        <w:conteudoPagina titulo="Faq:">
            <br />
            <h1><span class="style1">Cadastro</span></h1>
            <br />
            <form name="dados" method="post" action="<c:url value="/groupware-workbench/${faqMgr.id}/faq" />">
                <input type="hidden" name="faq.id" value="<c:out value="${faq.id}" />" />
                <%-- TODO: Tableless! --%>
                <table cellpadding="3">
                    <c:if test="${categoryMgr != null}">
                        <tr>
                            <td>Categoria</td>
                            <td>
                                <category:simpleDropDownBox genericEntity="${faq}" categoryMgr="${categoryMgr}" />
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td>Pergunta</td>
                        <td><input size="60" type="text" name="faq.pergunta" value="<c:out value="${faq.pergunta}" />" /></td>
                    </tr>
                    <tr>
                        <td>Resposta</td>
                        <td><textarea rows="4" cols="60" name="faq.resposta"><c:out value="${faq.resposta}" /></textarea></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <c:if test="${tagMgr != null}">
                                Tags clique em uma das tags abaixo para adicion&aacute;-la ao FAQ.
                                <br />
                                <tag:selectTags tagMgr="${tagMgr}" />
                                <tag:setTags tagMgr="${tagMgr}" idObject="${faq.id}" />
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${binomialMgr != null}">
                                <binomial:setBinomial binomialMgr="${binomialMgr}" idObject="${faq.id}" user="${sessionScope.userLogin}" />
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="submit" class="botao" value="Ok" />
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <br />
            </form>
            <div class="barra_botoes">
                <w:voltar collabletInstance="${faqMgr}" />
            </div>
        </w:conteudoPagina>
    </body>
</html>
