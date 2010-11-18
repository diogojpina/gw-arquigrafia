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
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.custom.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/scroll.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/chili-1.7.pack.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easing.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.dimensions.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.accordion.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/bay.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.boxy.js"></script>
        <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
		<script type="text/javascript">
		  $(function(){
		    var myLatlng = new google.maps.LatLng(${trackRequest.latitude}, ${trackRequest.longitude});
		    var myOptions = {
		      zoom: 13,
		      center: myLatlng,
		      mapTypeId: google.maps.MapTypeId.ROADMAP
		    }
		    var map = new google.maps.Map(document.getElementById("mapa"), myOptions);
		    <c:forEach items="${trackingInfoList}" var="ti">
		    new google.maps.Marker({
		    	position: new google.maps.LatLng(${ti.latitude}, ${ti.longitude}),
		    	map: map,
		    	title: "${ti.userId}"
		    });
		    </c:forEach>
		  });
		</script>
		<style type="text/css">
			#mapa{
				width: 500px;
				height: 400px;
			}
		</style>
    </head>
    <body>
        <div id="wrap">
            <arq:header2 photoInstance="${photoMgr}" />

            <div id="main_section">
	            <div style="left-padding: 300px;">
		            <h1>TrackingInfo</h1>
					<table border="1">
						<tr>
							<th>UserId</th>
							<th>Accuracy</th>
							<th>Longitude</th>
							<th>Latitude</th>
							<th>Date</th>
						</tr>
						<c:if test="${!empty trackingInfoList}">
							<c:forEach var="ti" items="${trackingInfoList}">
								<tr>
									<td>${ti.userId}</td>
									<td>${ti.accuracy}</td>
									<td>${ti.latitude}</td>
									<td>${ti.longitude}</td>
									<td>${ti.dateUpdate}</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty trackingInfoList}">
							<tr>
								<td colspan="5">Nenhum TrackingInfo cadastrado nas proximidades.</td>
							</tr>
						</c:if>
					</table>
					<div id="mapa" />
				</div>
	        </div>
	        <div style="height:30px;background-color:#fff;">&nbsp;</div>
            <arq:footer photoInstance="${photoMgr}" />
        </div>
    </body>
</html>