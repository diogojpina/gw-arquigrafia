<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="binomial" uri="http://www.groupwareworkbench.org.br/widgets/binomial" %>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag" %>
<%@ taglib prefix="recommend" uri="http://www.groupwareworkbench.org.br/widgets/recommend" %>
<%@ taglib prefix="comment" uri="http://www.groupwareworkbench.org.br/widgets/comment" %>
<%@ taglib prefix="gmaps" uri="http://www.groupwareworkbench.org.br/widgets/googlemapsmarker" %>
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
        <script src="${pageContext.request.contextPath}/js/jquery.boxy.js" type="text/javascript"></script>
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
        <script type="text/javascript"
            src="http://maps.google.com/maps/api/js?sensor=false">
        </script>
        <script type="text/javascript">
            function initializeMap() {
                var latlng = new google.maps.LatLng(-34.397, 150.644);
                var myOptions = {
                    zoom : 8,
                    center : latlng,
                    mapTypeId : google.maps.MapTypeId.ROADMAP
                };
                var map = new google.maps.Map(document.getElementById("map_canvas"),
                        myOptions);
            }
        </script>
    </head>
    <body onload="initializeMap()">
        <arq:header2 photoInstance="${photoInstance}" siteInstance="${ArquigrafiaBrasil}" />
        <form name="tags" method="post" enctype="multipart/form-data" action="<c:url value="/groupware-workbench/${photoInstance.id}/photo/show/${idPhoto}" />">
        <div id="photoRel">
                <c:if test="${binomialMgr != null}">
                    <div id="binomialsTitle" class="big_white_title">Medidores</div>
                    <div id="binLink"><a id="myLink"><img alt="Medidores do usu&aacute;rio" src="${pageContext.request.contextPath}/images/bin_user.png" /></a>&nbsp;&nbsp;<a id="avgLink"><img src="${pageContext.request.contextPath}/images/bin_avg.png" alt="M&eacute;dia" /></a></div>
                    <div id="binomialsWrap">
                        <div id="binomialsUser">
                            <binomial:getAndSetByUser entity="${photo}" manager="${binomialMgr}" user="${sessionScope.userLogin}" name="userBin"
                                binLabelClass="binLabelClass" binValueClass="binValueClass" binWrapClass="binWrapClass" />
                            <div id="binomialSubmit">
                                <input type="submit" name="saveBinomial" value="Salvar" />
                            </div>
                        </div>
                        <div id="binomialsAvg">
                            <binomial:getAverage entity="${photo}" manager="${binomialMgr}" name="avgBin"
                                binLabelClass="binLabelClass" binValueClass="binValueClass" binWrapClass="binWrapClass" />
                        </div>
                    </div>
                </c:if>
           </div>
            <div id="photoWrap">
                <c:if test="${photoInstance != null}">
                    <div id="photoTitle">
                        <span  class="big_white_title"><c:out value="${photoTitle}" /></span>
                        <div id="photoTitle_tab_3" class="photoTitle_tab"><img src="${pageContext.request.contextPath}/images/photo_download.png" alt="Baixar a foto" />&nbsp;<span class="mid_white_text">Download</span></div>
                        <div id="photoTitle_tab_2" class="photoTitle_tab"><img src="${pageContext.request.contextPath}/images/photo_view.png" alt="Visualizar a foto" />&nbsp;<span class="mid_white_text">Foto</span></div>
                        <div id="photoTitle_tab_1" class="photoTitle_tab"><img src="${pageContext.request.contextPath}/images/photo_details.png" alt="Detalhes da foto" />&nbsp;<span class="mid_white_text">Detalhes</span></div>
                    </div>
                    <div id="photo" class="resizeblePhoto1">
                        <photo:show idPhoto="${idPhoto}" photoInstance="${photoInstance}" />
                    </div>
                    <div id="map_canvas" style="width: 100%; height: 100%"></div>
                </c:if>
                <div id="tagsAndEval">
                    <div id="evalAndAdd">
                        <div id="eval">
                            <img src="${pageContext.request.contextPath}/images/evaluation_mock.png" alt="" />
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
                            <tag:getTags tagMgr="${tagMgr}" idObject="${idPhoto}" />
                        </div>
                        <div id="tags_right">
                        </div>
                    </div>
                </div>
                <div id="tagsAdd">
                    <tag:selectTags tagMgr="${tagMgr}" />
                    <tag:setTags tagMgr="${tagMgr}" idObject="${idPhoto}" tagsEditorClass="mid_black_text" />
                    <input type="submit" name="adicionar" value="Adicionar" />
                </div>
                <div style="clear:both"></div>
                <div id="photoRelSub">
                    <div id="caracteristicsWrap">
                            <div id="caracteristicsTitle" style="background-color: #B8C7CF" >Caracter&iacute;sticas</div>
                            <c:if test="${photoDate != null}">
                                <div style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; color: #6A8A9A; padding-left: 20px; margin-top: 5px;">Tirada em: <c:out value="${photoDate}" /></div>
                            </c:if>
                            <c:if test="${photoResolution != null}">
                                <div style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; color: #6A8A9A; padding-left: 20px; margin-top: 5px;">Resolu&ccedil;&atilde;o: <c:out value="${photoResolution}" /></div>
                            </c:if>
                            <c:if test="${photoLocation != null}">
                                <div style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; color: #6A8A9A; padding-left: 20px; margin-top: 5px;">Local: <c:out value="${photoLocation}" /></div>
                            </c:if>
                    </div>
                    <c:if test="${photoDescription != null}">
                            <div id="descriptionWrap">
                                <div id="descriptionTitle" style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #6A8A9A; margin-top: 15px; background-color: #B8C7CF" >Descri&ccedil;&atilde;o</div>
                                <p style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; color: #6A8A9A; padding-left: 20px; margin-top: 5px;"><c:out value="${photoDescription}" /></p>
                            </div>
                    </c:if>
                     <c:if test="${recommendMgr != null}">
                           <div id="descriptionWrap">                      
                            <div id="descriptionTitle"  style="font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #6A8A9A; margin-top: 15px; background-color: #B8C7CF" >Relacionadas</div>
                            <p  style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight; color: #6A8A9A; padding-left: 20px; margin-top: 5px;" >
                                <recommend:simpleListImage genericEntity="${photo}" recommendMgr="${recommendMgr}" />
                            </p>
                        </div>
                    </c:if>    
                    </div>
            </div>
           <div id="photoBackground"></div>
           <div style="height: 5px; width: 100%; clear:both"></div>
            <c:if test="${commentMgr != null}">
                <div id="comments_bar">
                    <div id="comments_bar_bg">
                        <div id="comments_bar_title" class="big_blue_title2">Coment&aacute;rios</div>
                        <div id="comments_bar_link" class="comments_link"><a class="white_link"><img src="${pageContext.request.contextPath}/images/add_comment.png" alt="Adicionar Coment&aacute;rio" /></a></div>
                        <div id="comments_bar_link2" class="comments_link"><a class="white_link"><img src="${pageContext.request.contextPath}/images/add_comment2.png" alt="Adicionar Coment&aacute;rio" /></a></div>
                    </div>
                </div>
                <div id="comments_create" style="height: 130px;">
                    <comment:addComment commentMgr="${commentMgr}" idObject="${idPhoto}" user="${sessionScope.userLogin}" editorClass="editorClass" wrapClass="comments_create_internal" />
                    <input name="commentAdd" value="Adicionar" type="submit" />
                </div>
                <div id="comments_show">
                    <comment:getComments commentMgr="${commentMgr}" idObject="${idPhoto}" wrapClass="comments_show_internal" />
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
        <arq:footer photoInstance="${photoInstance}" siteInstance="${ArquigrafiaBrasil}" />
    </body>
</html>