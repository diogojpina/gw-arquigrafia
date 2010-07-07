<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="binomial" uri="http://www.groupwareworkbench.org.br/widgets/binomial" %>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag" %>
<%@ taglib prefix="recommend" uri="http://www.groupwareworkbench.org.br/widgets/recommend" %>
<%@ taglib prefix="comment" uri="http://www.groupwareworkbench.org.br/widgets/comment" %>
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
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.custom.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/scroll.js"></script>
        <script type="text/javascript">
            $(function() {
                $("div#makeMeScrollable").smoothDivScroll({scrollingSpeed: 12, mouseDownSpeedBooster: 3, visibleHotSpots: "always", startAtElementId: "startAtMe"});
            });
        </script>
        <script src="${pageContext.request.contextPath}/scripts/chili-1.7.pack.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/jquery.easing.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/jquery.dimensions.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/jquery.accordion.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/bay.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/curvycorners.src.js" type="text/javascript"></script>
        <script type="text/javascript">
        $(document).ready(function() {

            function pageResize() {
                var maxWidth = $(window).width() - 325; // Max width for the image
                var maxHeight = 600;       // Max height for the image
                $('.resizeblePhoto1 img').css("width", "auto").css("height", "auto"); // Remove existing CSS
                $("#photoWrap").css("margin-left", "auto");
                $('.resizeblePhoto1 img').removeAttr("width").removeAttr("height"); // Remove HTML attributes
                var width = $('.resizeblePhoto1 img').width();    // Current image width
                var height = $('.resizeblePhoto1 img').height();  // Current image height

                if (width > height) {
                    // Check if the current width is larger than the max
                    if (width > maxWidth) {
                        var ratio = maxWidth / width;   // get ratio for scaling image
                        $('.resizeblePhoto1 img').css("width", maxWidth); // Set new width
                        $('.resizeblePhoto1 img').css("height", height * ratio);  // Scale height based on ratio
                        height = height * ratio;        // Reset height to match scaled image
                    } else {
                        $("#photoWrap").css("margin-left", (maxWidth - width) / 2);
                    }

                // Check if current height is larger than max
                } else if (height > maxHeight) {
                    var ratio = maxHeight / height; // get ratio for scaling image
                    $('.resizeblePhoto1 img').css("height", maxHeight);   // Set new height
                    $('.resizeblePhoto1 img').css("width", width * ratio);    // Scale width based on ratio
                    width = width * ratio;  // Reset width to match scaled image
                }
                $("#photoBackground").css("height", height + 62);
                $("#binomialsWrap").css("max-height", height - 30);
                $("#comments_bar_bg").css("width", maxWidth - 20);
                $("#comments_create").css("width", maxWidth - 20);
               	$("#comments_show").css("width", maxWidth - 10);
            }

            $('.resizeblePhoto1 img').load(function() {
            	pageResize();//Triggers when document first loads
            });      

            $(window).bind("resize", function() { //Adjusts image when browser resized
            	pageResize();  
            });  
        });
        </script>
        <binomial:scriptBinomial />
        <tag:scriptTags />
    </head>
    <body>
        <arq:header2 photoInstance="${photoInstance}" siteInstance="${ArquigrafiaBrasil}" />
        <form name="tags" method="post" enctype="multipart/form-data" action="<c:url value="/groupware-workbench/${photoInstance.id}/photo/show/${idPhoto}" />">
            <div id="photoWrap">
                <c:if test="${photoInstance != null}">
                    <div id="photoTitle"><c:out value="${photoTitle}" /></div>
                    <div id="photo" class="resizeblePhoto1">
                        <photo:show idPhoto="${idPhoto}" photoInstance="${photoInstance}" />
                    </div>
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
                <script type="text/javascript">
                    $("#add2").hide();
                    $("#tagsAdd").hide();
                    $("#add").click(function() {
                        $("#add2").show();
                        $("#add").hide();
                        $("#tagsAdd").show();
                    });
                    $("#add2").click(function() {
                        $("#add").show();
                        $("#add2").hide();
                        $("#tagsAdd").hide();
                    });
                </script>
            </div>
            <div id="photoRel">
                <div id="binomialsWrap">
                    <c:if test="${binomialMgr != null}">
                        <div id="binomialsTitle">Medidores</div>
                        <binomial:setBinomial idObject="${idPhoto}" binomialMgr="${binomialMgr}" user="${sessionScope.userLogin}"
                                binLabelClass="binLabelClass" binValueClass="binValueClass" binWrapClass="binWrapClass" />
                        <div id="binomialSubmit" style="clear: both">
                            <input type="submit" name="saveBinomial" value="salvar" />
                        </div>
                    </c:if>
                </div>
           </div>
           <div id="photoBackground"></div>
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
            <c:if test="${commentMgr != null}">
                <div id="comments_bar">
                    <div id="comments_bar_left"></div>
                    <div id="comments_bar_bg">
                        <div id="comments_bar_title" class="big_white_title">Coment&aacute;rios</div>
                        <div id="comments_bar_title2" class="big_white_title">Coment&aacute;rios</div>
                        <div id="comments_bar_link" class="comments_link"><a class="white_link">adicionar coment&aacute;rio</a></div>
                        <div id="comments_bar_link2" class="comments_link"><a class="white_link">adicionar coment&aacute;rio</a></div>
                    </div>
                    <div id="comments_bar_right"></div>
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
                    $("#comments_bar_title2").hide();
                    $("#comments_bar_link").click(function() {
                        $("#comments_create").show();
                        $("#comments_bar_link").hide();
                        $("#comments_bar_link2").show();
                    });
                    $("#comments_bar_link2").click(function() {
                        $("#comments_create").hide();
                        $("#comments_bar_link2").hide();
                        $("#comments_bar_link").show();
                    });
                    $("#comments_bar_title").click(function() {
                        $("#comments_bar_title").hide();
                        $("#comments_bar_title2").show();
                        $("#comments_show").hide();
                    });
                    $("#comments_bar_title2").click(function() {
                        $("#comments_bar_title2").hide();
                        $("#comments_bar_title").show();
                        $("#comments_show").show();
                    });
                </script>
            </c:if>
            <div style="height: 30px; width: 100%; clear: both"></div>
        </form>
        <arq:footer photoInstance="${photoInstance}" siteInstance="${ArquigrafiaBrasil}" />
    </body>
</html>