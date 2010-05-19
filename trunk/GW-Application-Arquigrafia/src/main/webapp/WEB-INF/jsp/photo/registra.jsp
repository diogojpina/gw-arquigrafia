<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/photomanager" prefix="photo" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/binomial" prefix="binomialMgr" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag" prefix="TagMgr" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Arquigrafia - Ver foto</title>
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/arq-common.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/forms.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/sds/css/smoothDivScroll.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bay.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tagcloud.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.css" type="text/css" media="screen" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.custom.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/scroll.js"></script>
        <script type="text/javascript">
            $(function() {
                $("div#makeMeScrollable").smoothDivScroll({scrollingSpeed: 12, mouseDownSpeedBooster: 3, visibleHotSpots: "always", startAtElementId: "startAtMe"});
            });
        </script>
        <script src="${pageContext.request.contextPath}/scripts/chili-1.7.pack.js" type="text/javascript" ></script>
        <script src="${pageContext.request.contextPath}/scripts/jquery.easing.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/jquery.dimensions.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/jquery.accordion.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/bay.js" type="text/javascript"></script></head>
    </head>
    <body>
        <%@ include file="../site/header2.jsp" %>
        <Widgets:ConteudoPagina titulo="Registrar foto">
            <div style="margin-left: 30px; background-color: #fff;">
                <form name="photoRegisterForm" method="post" enctype="multipart/form-data" action="<c:url value="/groupware-workbench/${photoInstance.id}/photo/registra" />">
                    <photo:save photoRegister="${photoRegister}" photoInstance="${photoInstance}" tagMgr="${tagMgr}"
                        formClass="form1" formLineClass="field_line_f1" formLabelClass="label_f1" formInputClass="input_f1"
                        formLineBtClass="bt_line_f1" formSubmitBtClass="bt_cell_submit" />
                </form>
            </div>
            <br />
            <c:forEach var="error" items="${errors}">
                <c:out value="${error.category}" /> - <c:out value="${error.message}" />
                <br />
            </c:forEach>

            <div class="barra_botoes">
                <Widgets:Voltar collabletInstance="${photoInstance}" />
            </div>
        </Widgets:ConteudoPagina>
        <div style="height: 30px; width: 100%"></div>
        <%@ include file="../site/footer.jsp" %>
    </body>
</html>