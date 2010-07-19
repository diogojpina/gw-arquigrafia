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
        <title>Arquigrafia Brasil</title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/arq-common.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/know_more.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/forms.css"  />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/plugins/sds/css/smoothDivScroll.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/bay.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/footer.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/jquery.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/tagcloud.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/image_wall.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/boxy.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/scroll.js"></script>
        <script type="text/javascript">
            $(function() {
                $("div#makeMeScrollable").smoothDivScroll({
                    scrollingSpeed: 12,
                    mouseDownSpeedBooster: 3,
                    visibleHotSpots: "always",
                    startAtElementId: "startAtMe"
                });
            });
        </script>
        <script src="${pageContext.request.contextPath}/js/chili-1.7.pack.js" type="text/javascript" ></script>
        <script src="${pageContext.request.contextPath}/js/jquery.easing.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.dimensions.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.accordion.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/bay.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.boxy.js" type="text/javascript"></script>
    </head>
    <body>
        <div id="wrap">
            <arq:header2 photoInstance="${PhotoRegister}" siteInstance="${siteInstance}" />

            <div id="main_section">
                <div id="makeMeScrollable" style="border-style: solid; border-width: thin; border-color: #666; padding-left: 0px; height: 500px;">
                    <div class="scrollingHotSpotLeft" style=" height: 500px;"></div>
                    <div class="scrollingHotSpotRight" style="height: 500px;"></div>
                    <div class="scrollWrapper" id="images_scrollable">
                        <div class="scrollableArea">
                            <div class="wallBackground">
                                <c:if test="${PhotoRegister != null}">
                                    <c:forEach begin="0" end="21" var="indice">
                                        <photo:listPage linkClass="" photoInstance="${PhotoRegister}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="${indice}" wrapClass="imageColumn" />
                                    </c:forEach>
                                </c:if>
                                <div class="image_placeholder" id="1">
                                    <img src="${pageContext.request.contextPath}/images/ajax-loader.gif" alt="loading" />
                                </div>
                            </div>
                            <div class="image_line">
                                <div class="image_placeholder" id="2">
                                    <img src="${pageContext.request.contextPath}/images/ajax-loader.gif" alt="loading" />
                                </div>
                            </div>
                            <div class="image_line">
                                <div class="image_placeholder" id="3">
                                    <img src="${pageContext.request.contextPath}/images/ajax-loader.gif" alt="loading" />
                                </div>
                            </div>
                            <div class="image_line">
                                <div class="image_placeholder" id="4">
                                    <img src="${pageContext.request.contextPath}/images/ajax-loader.gif" alt="loading" />
                                </div>
                            </div>
                            <div class="image_line">
                                <div class="image_placeholder" id="5">
                                    <img src="${pageContext.request.contextPath}/images/ajax-loader.gif" alt="loading" />
                                </div>
                            </div>
                            <script type="text/javascript" src="plugins/visual_lightbox/engine/js/visuallightbox.js" ></script>
                        </div>
                    </div>
                </div>
            </div>
            <arq:know_more />
            <div style="height: 30px; background-color: #fff"></div>
            <arq:footer photoInstance="${PhotoRegister}" siteInstance="${siteInstance}" />
        </div>
    </body>
</html>