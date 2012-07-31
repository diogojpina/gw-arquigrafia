<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="album" uri="http://www.groupwareworkbench.org.br/widgets/album" %>
<%@ taglib prefix="binomial" uri="http://www.groupwareworkbench.org.br/widgets/binomial" %>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag" %>
<%@ taglib prefix="recommend" uri="http://www.groupwareworkbench.org.br/widgets/recommend" %>
<%@ taglib prefix="comment" uri="http://www.groupwareworkbench.org.br/widgets/comment" %>
<%@ taglib prefix="counter" uri="http://www.groupwareworkbench.org.br/widgets/counter" %>
<%@ taglib prefix="gmaps" uri="http://www.groupwareworkbench.org.br/widgets/georeference" %>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Arquigrafia Brasil - Visualiza&ccedil;&atilde;o de fotos</title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/arq-common.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/forms.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/show.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/album.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/plugins/sds/css/smoothDivScroll.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/bay.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/tagcloud.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/footer.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/jquery.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/boxy.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/compiled/arquigrafia-default.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/scroll.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.boxy.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/toolTips.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/ui.base.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/ui.slider.js"></script>

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
                $("#datepicker").datepicker({
                    "showOn": "button",
                    "changeMonth": true,
                    "changeYear": true,
                    "width": 15,
                    "dateFormat": "dd/mm/yy", <%-- Aten��o: De acordo com a documenta��o, yy � o ano com 4 d�gitos. --%>
                    "buttonImage": "${pageContext.request.contextPath}/images/calendar.gif",
                    "buttonImageOnly": true
                });
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function() {
                basicAndEvents();
            });
        </script>
        <tag:scriptTags />

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
    <body style="background: url(../../../../images/header_bg.jpg) no-repeat scroll 0 0 transparent;">
    	<arq:header2 photoMgr="${photoMgr}" />
        <div id="corpo" class="default_div">
        <div id="info" class="default_info">
        <form id="form1" class="cmxform" name="dados" method="POST" action="<c:url value="/photo/${photoMgr.id}/update" />" accept-charset="UTF-8" autocomplete="off">
	    <!-- <input type="hidden" name="user.id" value="<c:out value="${user.id}" />" />  -->
        <input type="hidden" name="photoRegister.id" value="<c:out value="${photoRegister.id}" />" />
        <input type="hidden" name="photoRegister.nomeArquivo" value="<c:out value="${photoRegister.nomeArquivo}" />" />
        <input type="hidden" name="userOwn.id" value="<c:out value="${userOwn.id}" />" />
        
            <div class="linha">
                <center><span class="big_black_title">Editar Foto</span></center>
            </div>
            <ul class="field_line_f2">
                <li class="label_f2"><span>Arquivo :</span></li>
                <li class="input_f1">
                    <input type="text" name="photoRegister.nomeArquivo" disabled="disabled" value="<c:out value="${photoRegister.nomeArquivo}" />" />
                </li>
            </ul>
            <ul class="field_line_f2">
                <li class="label_f2"><span>Nome:</span></li>
                <li class="input_f1">
                    <input type="text" name="photoRegister.nome" value="<c:out value="${photoRegister.nome}" />" />
                </li>
            </ul>
            
            <ul class="field_line_f2">
                <li class="label_f2">
                    <span>Descri&ccedil;&atilde;o:</span>
                </li>
                <li class="input_f1">
                    <textarea name="photoRegister.descricao" class="${formInputClass}"><c:out value="${photoRegister.descricao}" /></textarea>
                </li>
            </ul>
            <br />
             <ul class="field_line_f2">
                <li class="label_f2">
                     <span>Data da foto:</span>
                </li>
                <li class="input_f1">
                    <input type="text" id="datepicker" name="photoRegister.dataCriacao" value="<c:out value="${photoRegister.dataCriacaoFormatada}" />"/>
                </li>
            </ul>
            <br />   
            <ul class="field_line_f2">
                <li class="label_f2">
                    <span>Informa&ccedil;&otilde;es arquitetonicas:</span>
                </li>
                <li class="input_f1">
                    <textarea name="photoRegister.infArquitetonicas" >${photoRegister.infArquitetonicas}</textarea>
                </li>
            </ul>
            <br /> 
            <ul class="field_line_f2">
                <li class="label_f2">
                     <span>Cidade:</span>
                </li>
                <li class="input_f1">
                    <input type="text" name="photoRegister.cidade" value="<c:out value="${photoRegister.cidade}" />" />
                </li>
            </ul>
            <br /> 
            <ul class="field_line_f2">
                <li class="label_f2">
                     <span>Estado:</span>
                </li>
                <li class="input_f1">
                    <input type="text" name="photoRegister.estado" value="<c:out value="${photoRegister.estado}" />" />
                </li>
            </ul>
            <br />
            <ul class="field_line_f2">
                <li class="label_f2">
                     <span>Pais:</span>
                </li>
                <li class="input_f1">
                    <input type="text" name="photoRegister.pais" value="<c:out value="${photoRegister.pais}" />" />
                </li>
            </ul>
            <br />
            
            <div class="${formLineClass}">
                <ul class="field_line_f2">
                    
                    <li class="input_f1">
                    <gmaps:setGeoref geoReferenceMgr="${geoReferenceMgr}" entity="${photoRegister}" />
                    </li>
                </ul>
            </div>
            <br/>
            <c:if test="${tagMgr.collablet.enabled}">
                <ul class="field_line_f2">
                    <li class="label_f2">
                         <span>Tags:</span>
                    </li>
                    <li class="input_f1">
                        <label style="font-size: 12px; color: blue;">As tags devem ser separadas por v&iacute;rgulas</label>
                        <tag:selectTags tagMgr="${tagMgr}" />
                        <tag:setTags tagMgr="${tagMgr}" entity="${photoRegister}" />
                    </li>
                </ul>
            </c:if>
            <div class="form_1" align="center">
                <ul class="field_line_f2">
                    <li class="bt_cell_submit" >
                        <center>
                            <input type="submit" class="botao" value="Ok" />
                            <input type="button" onclick="javascript:history.back(1);" class="botao" value="Voltar" />
                        </center>
                    </li>
                </ul>
            </div>
       </form>
       </div>
       </div>
       <div>
            <div style="height: 30px; background-color: #fff"></div>
            <arq:footer photoMgr="${photoMgr}" />
        </div>
    </body>
</html>