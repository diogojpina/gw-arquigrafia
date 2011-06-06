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
        <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/images/favicon.ico" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/reset.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/arq-common.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/header.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/know_more.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/forms.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/plugins/sds/css/smoothDivScroll.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/bay.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/footer.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/jquery.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/tagcloud.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/image_wall.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/boxy.css" />"/>
        <script type="text/javascript" src="<c:url value="/js/jquery.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery-ui.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/scroll.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/chili-1.7.pack.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.easing.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.dimensions.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.accordion.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/bay.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.boxy.js"/>"></script>
        <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
        <script type="text/javascript">
            $(function() {
                var myLatlng = new google.maps.LatLng(<c:out value="${trackRequest.latitude}" />, <c:out value="${trackRequest.longitude}" />);
                var myOptions = {
                    zoom: 13,
                    center: myLatlng,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };

                var map = new google.maps.Map(document.getElementById("mapa"), myOptions);
                <c:forEach items="${trackingInfoList}" var="ti">
		    new google.maps.Marker({
		    	position: new google.maps.LatLng(<c:out value="${ti.latitude}" />, <c:out value="${ti.longitude}" />),
		    	map: map,
		    	title: "<c:out value="${ti.user.name}" />"
		    });
                </c:forEach>
            });
        </script>
        <style type="text/css">
            #mapa {
                width: 500px;
                height: 400px;
            }
        </style>
    </head>
    <body>
        <div id="wrap">
            <arq:header2 photoInstance="${photoMgr}" />
			<div class="default_div">
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
			                    <td><c:out value="${ti.user.id}" /></td>
			                    <td><c:out value="${ti.accuracy}" /></td>
			                    <td><c:out value="${ti.latitude}" /></td>
			                    <td><c:out value="${ti.longitude}" /></td>
			                    <td><c:out value="${ti.dateUpdate}" /></td>
			                </tr>
			            </c:forEach>
			        </c:if>
			        <c:if test="${empty trackingInfoList}">
			            <tr>
			                <td colspan="5">Nenhum TrackingInfo cadastrado nas proximidades.</td>
			            </tr>
			        </c:if>
			    </table>
			    <div id="mapa"></div>
			</div>
            <div style="height: 30px; background-color: #fff;">&nbsp;</div>
            <arq:footer photoInstance="${photoMgr}" />
        </div>
    </body>
</html>