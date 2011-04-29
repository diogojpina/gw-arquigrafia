<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="imports.jsp" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        
       <title><tiles:insertAttribute name="title" /></title>
       
       	<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/plugins/sds/css/smoothDivScroll.css" />
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/tagcloud.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/image_wall.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/bay.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/footer.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/jquery.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/tagcloud.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/image_wall.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/boxy.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/arq-common.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/search.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/know_more.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/forms.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/show.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/album.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jquery-ui-1.8.custom.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/page_content.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/fancybox/jquery.fancybox-1.3.1.css" media="screen" />
        
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/compiled/arquigrafia-default.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/scroll.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.boxy.js"></script>       
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/toolTips.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/ui.base.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/ui.slider.js"></script> 
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/chili-1.7.pack.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easing.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.dimensions.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.accordion.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/bay.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/fancybox/jquery.mousewheel-3.0.2.pack.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/fancybox/jquery.fancybox-1.3.1.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/show.js"></script>
        <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.maskedinput.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.js"></script>
        
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
        <script type="text/javascript">
            function renderizarCelulaTag(celula, coluna, elem) {
                elem.css({"text-align": coluna.esquerda ? "left" : "right"});
                var link = $("<a></a>");
                elem.append(link);
                link.attr("href", "#");
                link.html(celula.nome);
                link.click(function(evt) {
                    window.open(celula.url, '_self');
                });
            }

            function criarCelulaTag(tabela, url, nome) {
                var celula = new CelulaCallback(renderizarCelulaTag);
                celula.nome = nome;
                celula.url = url;
                tabela.addCelulaElemento(celula);
            }
        </script>
        
        <tiles:insertAttribute name="head" ignore="true" />
    </head>
    <body>
        <div id="wrap">
       	 	<tiles:insertTemplate template="/WEB-INF/jsp/header2.jsp" />
			<tiles:insertAttribute name="body" />
            <div style="height: 30px; background-color: #fff"></div>
            <tiles:insertTemplate template="/WEB-INF/jsp/footer.jsp" />
        </div>
    </body>
</html>