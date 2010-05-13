<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/photomanager" prefix="photo" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/binomial" prefix="binomialMgr" %>
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css" type="text/css" media="screen" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"/></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.custom.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/scroll.js"></script>
        <script type="text/javascript">
            $(function() {
                $("div#makeMeScrollable").smoothDivScroll({scrollingSpeed: 12, mouseDownSpeedBooster: 3, visibleHotSpots: "always", startAtElementId: "startAtMe"});
            });
        </script>
        <script src="${pageContext.request.contextPath}/scripts/chili-1.7.pack.js" type="text/javascript" ></script>
        <script src="${pageContext.request.contextPath}/scripts/jquery.easing.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/jquery.dimensions.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/jquery.accordion.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/scripts/bay.js" type="text/javascript"></script>
        <binomialMgr:ScriptBinomial/>
    </head>
    <body>
    	<%@ include file="../site/header2.jsp" %>
    	<div id="photoTitle">${photoTitle}</div>
        <div id="photoAndBin">
        	<div id="photoArea">
                    <photo:show idPhoto="${idPhoto}"  photoInstance="${photoInstance}" />
			</div>
			<div id="binArea">
					<div id="internalBinArea">
						<span id="binTitle">Medidores</span>
						<br />
	                    <c:if test="${binomialMgr!=null}">
	                        <binomialMgr:SetBinomial idObject="${idPhoto}" binomialMgr="${binomialMgr}" user="${sessionScope.userLogin}"
	                        		binLabelClass="binLabelClass" binValueClass="binValueClass" binWrapClass="binWrapClass"/>
	                    </c:if>
                    </div>
                    <div id="caracteristics">
                    	<h3>Características</h3>
                    	<c:if test="${photoDate != null}">
                    		<div>Tirada em: ${photoDate}</div>
                    	</c:if>
                    	<c:if test="${photoResolution != null}">
                    		<div>Resolução: ${photoResolution}</div>
                    	</c:if>
                    	<c:if test="${photoLocation != null}">
                    		<div>Local: ${photoLocation}</div>
                    	</c:if>
                    	<c:if test="${photoDescription != null}">
                    		<div>
                    			<h4>Descrição</h4>
                    			<p>
                    				${photoDescription}
                    			</p>
                    		</div>
                    	</c:if>
                    </div>
			</div>
		</div>
		<div id="tagsAndEval">
			<div id="evalAndAdd">
				<div id="eval">
					<img src="${pageContext.request.contextPath}/images/evaluation_mock.png" alt="" />
				</div>
				<div id="add">
					<a href="#"><img src="${pageContext.request.contextPath}/images/add_tag.png" alt="" /></a>
				</div>
			</div>
			<div id="tags">
				<div id="tags_left">
				</div>
				<div id="tags_content">
					kjlj
				</div>
				<div id="tags_right">
				</div>
			</div>
		</div>
        <div style="height: 30px; width: 100%"></div>
       	<%@ include file="../site/footer.jsp" %>
    </body>
</html>