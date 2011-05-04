<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Bin&ocirc;mios</tiles:putAttribute>

	<tiles:putAttribute name="head">
		<w:tabela baseUrl="/groupware-workbench/binomials"
			createUrl="/groupware-workbench/binomials/${binomialMgr.id}/create"
			msgAdd="Adicionar novo binômio"
			msgDelete="Tem certeza que deseja remover o binômio?"
			target="tabela-binomials"
			titles="${coll:asList3('Primeiro Bin&ocirc;mio', 'Segundo Bin&ocirc;mio', 'Valor')}"
			columns="${coll:asList3('firstName', 'secondName', 'defaultValue')}"
			elements="${binomialList}" />
	</tiles:putAttribute>

	<tiles:putAttribute name="body">
		<w:conteudoPagina titulo="Bin&ocirc;mios">
			<div id="tabela-binomials"></div>
			<div class="barra_botoes">
				<w:voltar collabletInstance="${binomialMgr.collablet.parent}" />
			</div>
		</w:conteudoPagina>
	</tiles:putAttribute>
</tiles:insertTemplate>