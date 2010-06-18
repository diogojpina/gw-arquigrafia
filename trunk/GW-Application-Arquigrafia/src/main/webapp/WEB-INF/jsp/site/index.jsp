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
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/arq-common.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/know_more.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/forms.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/sds/css/smoothDivScroll.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bay.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tagcloud.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/image_wall.css" type="text/css" media="screen" />
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
        <script src="${pageContext.request.contextPath}/scripts/chili-1.7.pack.js" type="text/javascript" ></script>
        <script src="${pageContext.request.contextPath}/scripts/jquery.easing.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/jquery.dimensions.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/jquery.accordion.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/bay.js" type="text/javascript"></script>
    </head>
    <body>
        <div id="wrap">
            <arq:header2 photoInstance="${environment_photo}" siteInstance="${siteInstance}" />

            <div id="main_section">
                <div id="makeMeScrollable" style="border-style: solid; border-width: thin; border-color: #666; padding-left: 0px; height: 500px;">
                    <div class="scrollingHotSpotLeft" style=" height: 500px;"></div>
                    <div class="scrollingHotSpotRight" style="height: 500px;"></div>
                    <div class="scrollWrapper" id="images_scrollable">
                        <div class="scrollableArea">
                            <div class="wallBackground">
                                <c:if test="${environment_photo != null}">                                	
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="0" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="1" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="2" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="3" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="4" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="5" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="6" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="7" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="8" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="9" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="10" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="11" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="12" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="13" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="14" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="15" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="16" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="17" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="18" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="19" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="20" wrapClass="imageColumn"/>
                               	    <photo:listPage linkClass="" photoInstance="${environment_photo}" keepRatio="false" showInDiv="true" divClass="wallImage" pageSize="5" pageNumber="21" wrapClass="imageColumn"/>
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
            <div style="height: 30px;"></div>
            <arq:footer photoInstance="${environment_photo}" siteInstance="${siteInstance}" />
        </div>
    </body>
</html>