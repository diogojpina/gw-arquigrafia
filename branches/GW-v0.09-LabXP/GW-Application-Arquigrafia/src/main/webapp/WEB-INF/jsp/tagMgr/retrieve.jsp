<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Arquigrafia Brasil - Busca por tags</tiles:putAttribute>

	<tiles:putAttribute name="body">
		<div id="search_statistics">
			<span id="resultTerm">Voc&ecirc; buscou por objetos com a tag:
				<c:out value="${tag.name}" />
			</span>
			<span id="resultCount">
				(<c:out value="${tag.size}" /> resultados)
			</span>
			<br />
			<c:forEach var="error" items="${errors}">
				<c:out value="${error.category}" /> - <c:out value="${error.message}" />
				<br />
			</c:forEach>
		</div>
		<br />
		<div id="search_refinement">
			<img src="${pageContext.request.contextPath}/images/filtragem.png"
				alt="" />
		</div>
		<div id="search_scroll">
			<photo:searchByTag photoInstance="${photoMgr}"
				idList="${tag.taggedObjects}" showName="true" showLocation="false"
				lineClass="search_line" />
		</div>
		<div style="height: 30px; clear: both"></div>
	</tiles:putAttribute>
</tiles:insertTemplate>