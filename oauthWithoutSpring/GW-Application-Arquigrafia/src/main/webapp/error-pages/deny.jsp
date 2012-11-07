<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons"%>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-cache">
<title>Login</title>
<link rel="shortcut icon" type="image/x-icon" href="<c:url value="/images/favicon.ico" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/reset.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/login.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/know_more.css" />" />
<script type="text/javascript" src="<c:url value="/js/jquery.js"/>"></script>
</head>
<body>
<div style="width: 200px; margin-left: auto; margin-right: auto; margin-top: 200px; margin-bottom: 200px;">
<h1>Deny Access</h1>
<div style="margin-top: 20px;">
<a href="<c:url value="/j_spring_security_logout" />">Sair</a> <a href="javascript:history.back(1)">Voltar</a>
</div>
</div>
<arq:know_more />
</body>
</html>
