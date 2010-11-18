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
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/plugins/sds/css/smoothDivScroll.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/bay.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/tagcloud.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/footer.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/jquery.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/boxy.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/compiled/arquigrafia-default.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/scroll.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.boxy.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/toolTips.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $('label[rel=tooltip]').tooltip();
            });
        </script>
        <script type="text/javascript">
            $(function() {
                $("div#makeMeScrollable").smoothDivScroll({scrollingSpeed: 12, mouseDownSpeedBooster: 3, visibleHotSpots: "always", startAtElementId: "startAtMe"});
            });
        </script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/show.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                basicAndEvents();
            });
        </script>
        <binomial:scriptBinomial />
        <tag:scriptTags />
        <script type="text/javascript" src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAbf6eUcfIXSm07sEX-Hds_RRENaz91t6R4aLs0JFjRYJDtYpxpRTiOp0ddxtDlMNsckRtLrwfJnhCLg&sensor=false"></script>
        <script type="text/javascript">
            $(function() {
                var map = null;

                // Inicializador do Google Maps.
                if (GBrowserIsCompatible()) {
                    map = new GMap2($("#map_canvas").get(0), { size: new GSize(400, 300) });
                    map.enableContinuousZoom();
                    map.enableScrollWheelZoom();
                }

                // Destrutor do Google Maps.
                $("body").unload(GUnload);

                if (map == null) {
                    alert("Error! The map is null!");
                }
                map.setCenter(new GLatLng(-14.235004, -43.92528), 4);
            });
        </script>
    </head>
    <body onload="initializeMap()">
        <arq:header2 photoInstance="${photoInstance}" />
        <form name="tags" method="post" enctype="multipart/form-data" action="<c:url value="/groupware-workbench/photo/${photo.id}" />">
        <div id="photoRel">
            <c:if test="${binomialMgr.collablet.enabled}">
                <div id="binomialsTitle" class="big_white_title">Medidores</div>
                <div id="binLink">
                    <a id="myLink">
                        <img alt="Medidores do usu&aacute;rio" src="${pageContext.request.contextPath}/images/bin_user.png" />
                    </a>
                    &nbsp;&nbsp;
                    <a id="avgLink">
                        <img src="${pageContext.request.contextPath}/images/bin_avg.png" alt="M&eacute;dia" />
                    </a>
                </div>
                <div id="binomialsWrap">
                    <div id="binomialsUser">
                        <binomial:userAverage entity="${photo}" manager="${binomialMgr}" user="${sessionScope.userLogin}" name="userBin"
                                labelClass="binLabelClass" valueClass="binValueClass" wrapClass="binWrapClass" />
                        <div id="binomialSubmit">
                            <input type="submit" name="saveBinomial" value="Salvar" />
                        </div>
                    </div>
                    <div id="binomialsAvg">
                        <binomial:generalAverage entity="${photo}" manager="${binomialMgr}" name="avgBin"
                                labelClass="binLabelClass" valueClass="binValueClass" wrapClass="binWrapClass" />
                    </div>
                </div>
            </c:if>
        </div>
        <div id="photoWrap">
            <div id="photoTitle">
                <span class="big_white_title"><c:out value="${photo.nome}" /></span>
                <div id="photoTitle_tab_3" class="photoTitle_tab">
                    <a href="${pageContext.request.contextPath}/groupware-workbench/photo/img-original/${photo.id}"> 
                        <img src="${pageContext.request.contextPath}/images/photo_download.png" alt="Baixar a foto" />
                        &nbsp;
                        <span class="mid_white_text">Download</span>
                    </a>
                </div>
                <div id="photoTitle_tab_2" class="photoTitle_tab">
                    <img src="${pageContext.request.contextPath}/images/photo_view.png" alt="Visualizar a foto" />
                    &nbsp;
                    <span class="mid_white_text">Foto</span>
                </div>
                <div id="photoTitle_tab_1" class="photoTitle_tab">
                    <img src="${pageContext.request.contextPath}/images/photo_details.png" alt="Detalhes da foto" />
                    &nbsp;
                    <span class="mid_white_text">Detalhes</span>
                </div>
            </div>
            <div id="photo" class="resizeblePhoto1">
                <photo:show foto="${photo}" photoInstance="${photoInstance}" />
            </div>
            <div id="map_canvas" style="width: 100%; height: 100%"></div>
            <c:if test="${tagMgr.collablet.enabled}">
            <div id="tagsAndEval">
                <div id="evalAndAdd">
                    <div id="eval">
                    </div>
                    <div id="add">
                        <a><img src="${pageContext.request.contextPath}/images/add_tag.png" alt="adicionar ou remover tag" /></a>
                    </div>
                    <div id="add2">
                        <a><img src="${pageContext.request.contextPath}/images/add_tag2.png" alt="adicionar ou remover tag" /></a>
                    </div>
                </div>
                <div id="tags">
                    <div id="tags_left">
                    </div>
                    <div id="tags_content">
                        <tag:getTags tagMgr="${tagMgr}" entity="${photo}" />
                    </div>
                    <div id="tags_right">
                    </div>
                    <%--div>
                        <album:addPhoto albumMgr="${albumMgr}" user="${sessionScope.userLogin}" album="${null}" photo="${photo}" albumDefault="true" />
                    </div--%>
                </div>
            </div>
            <div id="tagsAdd">
                <tag:selectTags tagMgr="${tagMgr}" />
                <tag:setTags tagMgr="${tagMgr}" entity="${photo}" tagsEditorClass="mid_black_text" />
                <input type="submit" name="adicionar" value="Adicionar" />
            </div>
            </c:if>
            <div style="clear:both"></div>
            <div id="photoRelSub">
                <div id="caracteristicsWrap">
                    <div id="caracteristicsTitle" style="background-color: #B8C7CF">Caracter&iacute;sticas</div>
                    <c:if test="${not empty photo.dataCriacaoFormatada}">
                        <div style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; color: #6A8A9A; padding-left: 20px; margin-top: 5px;">
                            Tirada em: <c:out value="${photo.dataCriacaoFormatada}" />
                        </div>
                    </c:if>
                    <%--<c:if test="${not empty photo.resolution}">
                        <div style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; color: #6A8A9A; padding-left: 20px; margin-top: 5px;">
                            Resolu&ccedil;&atilde;o: <c:out value="${photo.resolution}" />
                        </div>
                    </c:if>--%>
                    <c:if test="${not empty photo.lugar}">
                        <div style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; color: #6A8A9A; padding-left: 20px; margin-top: 5px;">
                            Local: <c:out value="${photo.lugar}" />
                        </div>
                    </c:if>
                </div>
                <c:if test="${not empty photo.descricao}">
                    <div id="descriptionWrap">
                        <div id="descriptionTitle" style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #6A8A9A; margin-top: 15px; background-color: #B8C7CF">Descri&ccedil;&atilde;o</div>
                        <p style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; color: #6A8A9A; padding-left: 20px; margin-top: 5px;"><c:out value="${photo.descricao}" /></p>
                    </div>
                </c:if>
                <%--c:if test="${recommendMgr.collablet.enabled}">
                    <div>
                        <div style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #6A8A9A; margin-top: 15px; background-color: #B8C7CF">Relacionadas</div>
                        <p style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; color: #6A8A9A; padding-left: 20px; margin-top: 5px;">
                            <recommend:simpleListImage entity="${photo}" recommendMgr="${recommendMgr}" />
                        </p>
                    </div>
                </c:if--%>
            </div>
        </div>
        <div id="photoBackground"></div>
        <div style="height: 5px; width: 100%; clear:both"></div>
            <c:if test="${commentMgr.collablet.enabled}">
                <div id="comments_bar">
                    <div id="comments_bar_bg">
                        <div id="comments_bar_title" class="big_blue_title2">Coment&aacute;rios</div>
                        <div id="comments_bar_link" class="comments_link"><a class="white_link"><img src="${pageContext.request.contextPath}/images/add_comment.png" alt="Adicionar Coment&aacute;rio" /></a></div>
                        <div id="comments_bar_link2" class="comments_link"><a class="white_link"><img src="${pageContext.request.contextPath}/images/add_comment2.png" alt="Adicionar Coment&aacute;rio" /></a></div>
                    </div>
                </div>
                <div id="comments_create" style="height: 130px;">
                    <comment:addComment commentMgr="${commentMgr}" idObject="${photo.id}" user="${sessionScope.userLogin}" editorClass="editorClass" wrapClass="comments_create_internal" />
                    <input name="commentAdd" value="Adicionar" type="submit" />
                </div>
                <div id="comments_show">
                    <comment:getComments commentMgr="${commentMgr}" entity="${photo}" wrapClass="comments_show_internal" />
                </div>
                <script type="text/javascript">
                    $("#comments_create").hide();
                    $("#comments_bar_link2").hide();
                    $("#comments_bar_link").click(function() {
                        $("#comments_create").slideDown();
                        $("#comments_bar_link").hide();
                        $("#comments_bar_link2").show();
                    });
                    $("#comments_bar_link2").click(function() {
                        $("#comments_create").slideUp();
                        $("#comments_bar_link2").hide();
                        $("#comments_bar_link").show();
                    });
                </script>
            </c:if>
            <div style="height: 30px; width: 100%; clear: both"></div>
        </form>
        <arq:footer photoInstance="${photoInstance}" />
    </body>
</html>