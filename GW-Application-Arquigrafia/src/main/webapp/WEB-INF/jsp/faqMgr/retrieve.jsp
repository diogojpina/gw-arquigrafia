<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag" %>
<%@ taglib prefix="binomial" uri="http://www.groupwareworkbench.org.br/widgets/binomial" %>
<%@ taglib prefix="category" uri="http://www.groupwareworkbench.org.br/widgets/category" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Faq</title>
        <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/images/favicon.ico" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/reset.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/arq-common.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/header.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/know_more.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/forms.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/plugins/sds/css/smoothDivScroll.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/bay.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/footer.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/jquery.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/tagcloud.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/image_wall.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/boxy.css" />"/>
        <script type="text/javascript" src="<c:url value="/js/jquery.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery-ui.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/listagem.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/scroll.js"/>"></script>
        <script  type="text/javascript" src="<c:url value="/js/jquery.boxy.js"/>"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $("div#makeMeScrollable").smoothDivScroll({
                    scrollingSpeed: 12,
                    mouseDownSpeedBooster: 3,
                    visibleHotSpots: "always",
                    startAtElementId: "startAtMe"
                });

                $("div#makeMeScrollable2").smoothDivScroll({
                    scrollingSpeed: 12,
                    mouseDownSpeedBooster: 3,
                    visibleHotSpots: "always",
                    startAtElementId: "startAtMe"
                });
            });
        </script>
        
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
    </head>
    <body>
            <br />
            <h1><span class="style1">Cadastro</span></h1>
            <br />
            <form name="dados" method="post" action="<c:url value="/faq/${faqMgr.id}" />">
                <input type="hidden" name="faq.id" value="<c:out value="${faq.id}" />" />
                <%-- TODO: Tableless! --%>
                <table cellpadding="3">
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
                        </td>
                        <td>
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
                <w:voltar collabletInstance="${faqMgr.collablet}" />
            </div>
        <div>
        </div>
    </body>
</html>
