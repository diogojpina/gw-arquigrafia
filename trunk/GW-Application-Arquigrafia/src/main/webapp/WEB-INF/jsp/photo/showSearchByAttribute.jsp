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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="http://www.groupwareworkbench.org.br/widgets/util"%>


<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">


<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Arquigrafia - Seu universo de imagens de arquitetura</title>
<arquigrafia:includes arquigrafiaInstance="${arquigrafiaMgr}" />

<script type="text/javascript" src="<c:url value="/js/pagination.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/searchByAttribute.js" />"></script>

</head>

<body>
	<!--   CONTAINER   -->
	<div id="container">

		<!--   CABEÇALHO   -->
		<arquigrafia:header arquigrafiaInstance="${arquigrafiaMgr}" />

		<!--   MEIO DO SITE - ÁREA DE NAVEGAÇÃO   -->
		<div id="content">
			<!--   PAINEL DE IMAGENS - GALERIA - CARROSSEL   -->


			<div id="search_statistics">
				<c:if test="${empty photos}">
					<span id="resultTerm">Nenhuma imagem encontrada </span>
					<br />
				</c:if>
			</div>
			<br />
			<div id="search_scroll">
				<input id="context_path" type="hidden"
					value="${pageContext.request.contextPath}" /> <input id="search"
					type="hidden" value="${q}" /> <input id="term" type="hidden"
					value="${term}" />
				<c:if test="${not empty photos}">
					<div class="list_photos">
						<fmt:message key="${term}"/> ${searchTerm}
						<a id="${term}"
							href="<c:url value="/photos/${photoMgr.id}/search/term?q=${util:encode(searchTerm)}&term=${term}&perPage=32"/>"
							class="load_photos" data-count="0" data-page="2"></a>
							
						<hr />

						<c:forEach var="photo" items="${photos}">
							<c:if test="${!photo.deleted}">

								<div class="${lineClass}" style="float: left">
									<a class="search_image" rel="linkimage"
										href="<c:url value="/photo/${photo.id}"/>"> <img
										alt="${photo.name}"
										src="<c:url value="/photo/img-thumb/${photo.id}"/>?_log=no" />
									</a>
								</div>

							</c:if>
						</c:forEach>
						<br />
						<br />
					</div>
					<br />
					<br />
				</c:if>

			</div>




		</div>
			<!--   FIM - MEIO DO SITE   -->
			<!--   FUNDO DO SITE   -->
			<div id="footer">
				<!--   BARRA DE ABAS   -->
				<arquigrafia:tabs counterMgr="${counterMgr}" photoMgr="${photoMgr}"
					commentMgr="${commentMgr}" arquigrafiaInstance="${arquigrafiaMgr}" />
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