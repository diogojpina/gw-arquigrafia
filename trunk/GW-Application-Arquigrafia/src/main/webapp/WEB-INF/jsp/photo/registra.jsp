<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag" prefix="TagMgr" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/photomanager" prefix="photo" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/novo.css" rel="stylesheet" type="text/css" />
<link type="text/css"
	href="${pageContext.request.contextPath}/css/jquery-ui-1.8.custom.css"
	rel="Stylesheet" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-ui-1.8.custom.min.js"></script>
</head>


<body>
<Widgets:Topo collabletInstance="${photoInstance}" />
<Widgets:ConteudoPagina titulo="Registrar foto">
<form name="photoRegisterForm" method="post"
	enctype="multipart/form-data"
	action="<c:url value="/groupware-workbench/${photoInstance.id}/photo/registra"/>" />
	<photo:save photoRegister="${photoRegister}" photoInstance="${photoInstance}" tagMgr="${tagMgr}"/>		
</form>	
<br/>
<c:forEach var="error" items="${errors}">
	${error.category} - ${error.message} <br />
</c:forEach>


<Widgets:Voltar collabletInstance="${photoInstance}" />
</Widgets:ConteudoPagina>
</body>



</html>