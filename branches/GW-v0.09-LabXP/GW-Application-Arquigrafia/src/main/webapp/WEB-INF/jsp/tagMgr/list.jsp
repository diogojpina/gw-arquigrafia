<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Tags</tiles:putAttribute>

	<tiles:putAttribute name="head">
		<w:tabela baseUrl="/groupware-workbench/tags"
			msgDelete="Tem certeza que deseja remover a tag?"
			target="tabela-tags" titles="${coll:asList1('Nome')}"
			columns="${coll:asList2('!URL', 'name')}" elements="${tagList}"
			cellProcessFunc="criarCelulaTag" rowProcess="true" />
	</tiles:putAttribute>

	<tiles:putAttribute name="body">
		<w:conteudoPagina titulo="Tags">
			<div id="tabela-tags"></div>
			<div class="barra_botoes">
				<w:voltar collabletInstance="${tagMgr.collablet.parent}" />
			</div>
		</w:conteudoPagina>
	</tiles:putAttribute>
</tiles:insertTemplate>