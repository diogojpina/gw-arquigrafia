<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Arquigrafia Brasil - Resultado da busca</tiles:putAttribute>

	<tiles:putAttribute name="body">
		<div id="search_statistics">
			<span id="resultTerm">Voc&ecirc; buscou: <c:out
					value="${searchTerm}" />
			</span>
			<c:set var="qtdFotos" value="${fn:length(fotos)}" />
			<span id="resultCount"> <c:choose>
					<c:when test="${qtdFotos == 0}">(nenhum resultado)</c:when>
					<c:when test="${qtdFotos == 1}">(1 resultado)</c:when>
					<c:otherwise>(<c:out value="${qtdFotos}" /> resultados)</c:otherwise>
				</c:choose> </span> <br />
			<c:forEach var="error" items="${errors}">
				<c:out value="${error.category}" /> - <c:out
					value="${error.message}" />
				<br />
			</c:forEach>
		</div>
		<br />
		<div id="search_refinement">
			<img src="${pageContext.request.contextPath}/images/filtragem.png"
				alt="Filtragem" />
		</div>
		<div id="search_scroll">
			<photo:list photos="${fotos}" photoInstance="${photoInstance}"
				showName="true" showLocation="false" lineClass="search_line" />
		</div>
	</tiles:putAttribute>
</tiles:insertTemplate>