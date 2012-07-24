<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="arquigrafia" uri="http://www.groupwareworkbench.org.br/widgets/arquigrafia"%>
<%@ taglib prefix="album" uri="http://www.groupwareworkbench.org.br/widgets/album"%>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager"%>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag"%>
<%@ taglib prefix="comment" uri="http://www.groupwareworkbench.org.br/widgets/comment"%>
<%@ taglib prefix="counter" uri="http://www.groupwareworkbench.org.br/widgets/counter" %>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Arquigrafia - Recurso não encontrado"/></title>
<arquigrafia:includes arquigrafiaInstance="${arquigrafiaMgr}" />
<album:buttonAdd-script />
</head>

<body>
	<!--   CONTAINER   -->
	<div id="container">

		<!--   CABEZALHO   -->
		<arquigrafia:header arquigrafiaInstance="${arquigrafiaMgr}" />
		<!--   MEIO DO SITE - ÃREA DE NAVEGAÃÃO   -->
		<div id="content">
    		<center><h1>O recurso solicitado não foi encontrado. Ele não existe ou foi removido!</h1></center>
		</div>
		<!--   FUNDO DO SITE   -->
		<div id="footer">
			<!--   BARRA DE ABAS   -->
			<arquigrafia:tabs arquigrafiaInstance="${arquigrafiaMgr}" />
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
