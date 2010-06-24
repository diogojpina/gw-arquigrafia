<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Resultado da busca</title>
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/arq-common.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/search.css" rel="stylesheet" type="text/css" />
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
        <script src="${pageContext.request.contextPath}/scripts/bay.js" type="text/javascript"></script>
     </head>
     <body>
         <arq:header2 photoInstance="${photoInstance}" siteInstance="${ArquigrafiaBrasil}" />
         <div id="search_statistics">
             <span id="resultTerm">Voc&ecirc; buscou: <c:out value="${searchTerm}" /></span>
             <span id="resultCount"> (<c:out value="${numResults}" /> resultados)</span>
             <br/>
             <c:forEach var="error" items="${errors}">
                 <c:out value="${error.category}" /> - <c:out value="${error.message}" />
                 <br />
             </c:forEach>
         </div>
         <br />
         <div id="search_refinement">
             <img src="${pageContext.request.contextPath}/images/filtragem.png" alt="Filtragem" />
         </div>
         <div id="search_scroll">
             <photo:list photos="${fotos}" photoInstance="${photoInstance}" showName="true" showLocation="false" lineClass="search_line"/>
         </div>
         <div style="height: 30px; clear: both"></div>
         <arq:footer photoInstance="${photoInstance}" siteInstance="${ArquigrafiaBrasil}" />
     </body>
</html>