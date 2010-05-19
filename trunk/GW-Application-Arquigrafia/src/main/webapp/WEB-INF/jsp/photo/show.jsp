<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/photomanager" prefix="photo" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/binomial" prefix="binomialMgr" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag" prefix="TagMgr" %>	
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/comment" prefix="CommentMgr" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/arq-common.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/forms.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/show.css" rel="stylesheet" type="text/css" />
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
        <script src="${pageContext.request.contextPath}/scripts/chili-1.7.pack.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/jquery.easing.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/jquery.dimensions.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/jquery.accordion.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/bay.js" type="text/javascript"></script>
        <binomialMgr:ScriptBinomial/>
       	<TagMgr:ScriptTags />
    </head>
    <body>
        <%@ include file="../site/header2.jsp" %>
        <form name="tags" method="post" enctype="multipart/form-data" action="<c:url value="/groupware-workbench/${photoInstance.id}/photo/show/${idPhoto}" />">
            <div id="photoTitle"><c:out value="${photoTitle}" /></div>
            <div id="photoAndBin">
                <div id="binArea">
                    <div id="internalBinArea">
                        <span id="binTitle">Medidores</span>
                        <br />
                        <br />
                        <c:if test="${binomialMgr!=null}">
                            <binomialMgr:SetBinomial idObject="${idPhoto}" binomialMgr="${binomialMgr}" user="${sessionScope.userLogin}"
                                    binLabelClass="binLabelClass" binValueClass="binValueClass" binWrapClass="binWrapClass"/>
                        </c:if>
                    </div>
                    <div id="binomialSubmit" style="clear: both">
                        <input type="submit" name="saveBinomial" value="salvar" />
                    </div>
                    <div class="blueTextBox" id="caracteristics">
                        <h3>Caracter&iacute;sticas</h3>
                        <c:if test="${photoDate != null}">
                            <div>Tirada em: <c:out value="${photoDate}" /></div>
                        </c:if>
                        <c:if test="${photoResolution != null}">
                            <div>Resolu&ccedil;&atilde;o: <c:out value="${photoResolution}" /></div>
                        </c:if>
                        <c:if test="${photoLocation != null}">
                            <div>Local: <c:out value="${photoLocation}" /></div>
                        </c:if>
                    </div>

                    <div class="blueTextBox" id="description">
                        <c:if test="${photoDescription != null}">
                            <h4>Descri&ccedil;&atilde;o</h4>
                            <p><c:out value="${photoDescription}" /></p>
                        </c:if>
                    </div>
                </div>
                <div id="photoArea">
                    <photo:show idPhoto="${idPhoto}" photoInstance="${photoInstance}" />
                </div>
            </div>
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
                        <TagMgr:GetTags tagMgr="${tagMgr}" idObject="${idPhoto}" />
                    </div>
                    <div id="tags_right">
                    </div>
                </div>
            </div>
            <div id="tagsAdd">
                <TagMgr:SelectTags tagMgr="${tagMgr}" />
                <TagMgr:SetTags tagMgr="${tagMgr}" idObject="${idPhoto}" tagsEditorClass="mid_black_text" />
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
            <c:if test="${commentMgr != null}">
	            <div style="height: 10px; width: 100%; clear: both"></div>
	            <div id="comments_bar">
	                <div id="comments_bar_left"></div>
	                <div id="comments_bar_bg">
	                    <div id="comments_bar_title" class="big_white_title">Comentários</div>
	                    <div id="comments_bar_title2" class="big_white_title">Comentários</div>
	                    <div id="comments_bar_link" class="comments_link"><a class="white_link">adicionar comentário</a></div>
	                    <div id="comments_bar_link2" class="comments_link"><a class="white_link">adicionar comentário</a></div>
	                </div>
	                <div id="comments_bar_right"></div>
	            </div>
	            <div style="height: 10px; width: 100%; clear: both"></div>
	            <div id="comments_create" style="height: 130px;">
	                <CommentMgr:AddComment commentMgr="${commentMgr}" idObject="${idPhoto}" user="${sessionScope.userLogin}" editorClass="editorClass" wrapClass="comments_create_internal"/>
	                <input name="commentAdd" value="Adicionar" type="submit" />
	            </div>
	            <div id="comments_show">
	                <CommentMgr:GetComments commentMgr="${commentMgr}" idObject="${idPhoto}" wrapClass="comments_show_internal" />
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
            <div style="height: 30px; width: 100%"></div>
        </form>
        <%@ include file="../site/footer.jsp" %>
    </body>
</html>