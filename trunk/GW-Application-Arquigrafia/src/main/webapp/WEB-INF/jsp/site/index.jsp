<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/photomanager" prefix="photo" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/binomial" prefix="binomialMgr" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag" prefix="TagMgr" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
            <%@ include file="header2.jsp" %>

            <div id="main_section">
                <div id="makeMeScrollable" style="border-style: solid; border-width: thin; border-color: #666; padding-left: 0px; height: 500px;">
                    <div class="scrollingHotSpotLeft" style=" height: 500px;"></div>
                    <div class="scrollingHotSpotRight" style="height: 500px;"></div>
                    <div class="scrollWrapper" id="images_scrollable">
                        <div class="scrollableArea">
                            <div class="image_line">
                                <c:if test="${environment_photo != null}">
                                    <photo:listAll linkClass="" photoInstance="${environment_photo}" keepRatio="false" />
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
            <%@ include file="know_more.jsp" %>
            <div style="height: 30px;"></div>
            <%@ include file="footer.jsp" %>
        </div>
    </body>
</html>