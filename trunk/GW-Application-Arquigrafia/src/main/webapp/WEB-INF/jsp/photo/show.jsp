<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib	uri="http://www.groupwareworkbench.org.br/widgets/photomanager" prefix="photo"%>	
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/binomial" prefix="binomialMgr"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<binomialMgr:ScriptBinomial/>
		
		<link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/css/page_content.css" rel="stylesheet" type="text/css" />
		
		<link type="text/css" href="${pageContext.request.contextPath}/css/jquery-ui-1.8.custom.css" rel="Stylesheet" />
		<!--script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"/-->
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.custom.min.js"></script>		
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/fancybox/jquery.mousewheel-3.0.2.pack.js"></script>		
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/fancybox/jquery.fancybox-1.3.1.js"></script>				
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/fancybox/jquery.fancybox-1.3.1.css" media="screen" />
					
	</head>
	<body>
	
	<table>
	<tr style="vertical-align: top">
	 	<td>
	 		<photo:show idPhoto="${idPhoto}"  photoInstance="${photoInstance}"/>
	 	</td>
	 	<td>
	 		<c:if test="${binomialMgr!=null}">	 			
				<binomialMgr:SetBinomial idObject="${idPhoto}" binomialMgr="${binomialMgr}" user="${sessionScope.userLogin}"/> 
			</c:if>	 	
	 	</td>	 	
	</tr>	
	</table>	
	</body>
</html>