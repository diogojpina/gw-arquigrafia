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
        <title>Arquigrafia Brasil - Admin</title>
        <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/images/favicon.ico" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/jquery-ui-1.8.custom.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/page_content.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/js/fancybox/jquery.fancybox-1.3.1.css" media="screen" />"/>
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
        <script type="text/javascript" src="<c:url value="/js/listagem.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery-ui.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/fancybox/jquery.mousewheel-3.0.2.pack.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/fancybox/jquery.fancybox-1.3.1.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/scroll.js"/>"></script>
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
        <script type="text/javascript">
	        var _gaq = _gaq || [];
	        _gaq.push(['_setAccount', 'UA-20571872-1']);
	        _gaq.push(['_trackPageview']);
	        
	        (function() {
	        	var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	        	ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	        	var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	        })();
        </script>
    </head>
    <body>
        <arq:header2 photoMgr="${photoMgr}" />
        <w:conteudoPagina titulo="Busca Fotos">
            <span class="subTitulo">Collablets</span>
            <br />
            <br />
            <w:menuFerramentas collabletInstance="${photoMgr.collablet}" />
            <br />
            <br />
            <br />
            <a href="<c:url value="/photo/${photoMgr.id}/registra"/>">Registrar uma nova foto</a>
            <br />
            <br />
            <div>
                <h1>Busca de Fotos</h1>
                <photo:search photoMgr="${photoMgr}" />
            </div>
            <div>
                <photo:list photos="${fotos}" photoMgr="${photoMgr}" showName="true" showLocation="true" />
            </div>
            <div>
                <h1>Lista Fotos</h1>
                <photo:listAll photoMgr="${photoMgr}" keepRatio="true" />
            </div>

            <c:forEach var="error" items="${errors}">
                <c:out value="${error.category}" /> - <c:out value="${error.message}" />
                <br />
            </c:forEach>

            <div class="barra_botoes">
                <w:voltar collabletInstance="${photoMgr.collablet}" />
            </div>
        </w:conteudoPagina>
        <div>
            <div style="height: 30px; background-color: #fff"></div>
            <arq:footer photoMgr="${photoMgr}" />
        </div>
    </body>
</html>