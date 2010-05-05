<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag" prefix="TagMgr" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/binomial" prefix="BinomialMgr" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/category" prefix="CategoryMgr" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <title>Faq</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="cache-control" content="no-cache">
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <TagMgr:ScriptTags />
        <BinomialMgr:ScriptBinomial />
    </head>
    <body>
        <Widgets:Topo collabletInstance="${faqMgr}" />
        <Widgets:ConteudoPagina titulo="Faq:">
            <br />
            <h1><span class="style1">Cadastro</span></h1>
            <br />
            <form name="dados" method="post" action="<c:url value="/groupware-workbench/${faqMgr.id}/faq" />">
                <input type="hidden" name="faq.id" value="<c:out value="${faq.id}" />" />
                <table cellpadding="3">
                    <c:if test="${categoryMgr != null}">
                        <tr>
                            <td>Categoria</td>
                            <td>
                                <CategoryMgr:SimpleDropDownBox genericEntity="${faq}" categoryMgr="${categoryMgr}" ></CategoryMgr:SimpleDropDownBox>
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
                                <TagMgr:SelectTags tagMgr="${tagMgr}" />
                                <TagMgr:SetTags tagMgr="${tagMgr}" idObject="${faq.id}" />
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${binomialMgr != null}">
                                <BinomialMgr:SetBinomial binomialMgr="${binomialMgr}"  idObject="${faq.id}" user="${sessionScope.userLogin}" />
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="submit" class="botao" value="Ok" />
                            &nbsp;&nbsp;
                            <input type="button" class="botao" value="Cancela" onclick="history.back();" />
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <br />
            </form>
        </Widgets:ConteudoPagina>
    </body>
</html>
