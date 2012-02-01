<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">

	<tiles:putAttribute name="title">Denuncias</tiles:putAttribute>

	<tiles:putAttribute name="body">
		<div id="corpo" class="default_div">
				<c:if test="${flagMgr.collablet.enabled}">
				
						<%-- 
						<a class="linkVermelho collablets"
				href="<c:url value="${theInstance.formattedURL}" />"> <c:out
						value="${theInstance.description}" /> </a>
						--%>  
						
						<w:tabela
							baseUrl="/groupware-workbench/flags" target="${flagMgr.collablet.name}"
							titles="${coll:asList4('Entity', 'First flagged', 'Most recently flagged', 'Total')}"
							columns="${coll:asList4('entity', 'firstFlagged', 'lastFlagged', 'count')}"
							elements="${flagSummaryMap}" />

						<div id="info" class="default_info">
							<w:conteudoPagina titulo="${flagMgr.collablet.description}">
								<div id="${flagMgr.collablet.name}"></div>
							</w:conteudoPagina>
						</div>
				</c:if>
			
<%--
			<w:tabela baseUrl="/groupware-workbench/flags"
				target="flagsummary-table"
				titles="${coll:asList4('Entity', 'First flagged', 'Most recently flagged', 'Total')}"
				columns="${coll:asList4('entity', 'firstFlagged', 'lastFlagged', 'count')}"
				elements="${flagSummaryMap}" />

			<div id="info" class="default_info">
				<w:conteudoPagina titulo="Denuncias">
					<div id="flagsummary-table"></div>
				</w:conteudoPagina>
			</div>
 

			<w:tabela baseUrl="/groupware-workbench/flags" target="tabela-flags"
				titles="${coll:asList3('Id', 'Entity', 'Data')}"
				columns="${coll:asList3('id', 'target', 'flagDate')}"
				elements="${flagList}" />

			<div id="info" class="default_info">
				<w:conteudoPagina titulo="Denuncias">
					<div id="tabela-flags"></div>
					<div class="barra_botoes" align="center">
						<w:voltar collabletInstance="${flagMgr.collablet.parent}" />
					</div>
				</w:conteudoPagina>
			</div>
			 --%>
		</div>
	</tiles:putAttribute>
</tiles:insertTemplate>