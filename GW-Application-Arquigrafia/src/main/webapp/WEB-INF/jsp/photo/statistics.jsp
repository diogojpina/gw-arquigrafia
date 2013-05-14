<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="arquigrafia"
	uri="http://www.groupwareworkbench.org.br/widgets/arquigrafia"%>
<%@ taglib prefix="s"
	uri="http://www.groupwareworkbench.org.br/widgets/security"%>
<%@ taglib prefix="p"
	uri="http://www.groupwareworkbench.org.br/widgets/photomanager"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">


<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Arquigrafia - Seu universo de imagens de arquitetura</title>
<arquigrafia:includes arquigrafiaInstance="${arquigrafiaMgr}" />
</head>

<body onload="load(<c:out value="${firstTime}" />)">
	<div id="container">

		<!--   CABEÇALHO   -->
		<arquigrafia:header arquigrafiaInstance="${arquigrafiaMgr}" />

		<arquigrafia:statistics photoMgr="${photoMgr}"
			commentMgr="${commentMgr}" tagMgr="${tagMgr}" userMgr="{$userMgr}"
			albumMgr="{albumMgr}" binomialMgr="{binomialMgr}" />

		<div id="footer">
			<!--   BARRA DE ABAS   -->
			<!--   FIM - BARRA DE IMAGENS - (RODAPÉ)   -->


			<!--   CRÉDITOS - LOGOS   -->
			<arquigrafia:footer arquigrafiaInstance="${arquigrafiaMgr}" />
		</div>
		<!--   FIM - FUNDO DO SITE   -->
		<!--   MODAL   -->
		<div id="mask"></div>
		<div id="form_window">
			<!-- ÁREA DE LOGIN - JANELA MODAL -->
			<a class="close" href="#" title="FECHAR"></a>
			<div id="registration"></div>
		</div>
		<!--   FIM - MODAL   -->
	</div>
	<!--   FIM - CONTAINER   -->
</body>
</html>
