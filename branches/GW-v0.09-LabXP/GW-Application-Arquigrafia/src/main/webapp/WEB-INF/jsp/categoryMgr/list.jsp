<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Categorias</tiles:putAttribute>

	<tiles:putAttribute name="head">
		<w:tabela baseUrl="/groupware-workbench/categories"
			createUrl="/groupware-workbench/categories/${categoryMgr.id}/create"
			msgAdd="Adicionar nova categoria"
			msgDelete="Tem certeza que deseja remover a categoria?"
			target="tabela-categoria" titles="${coll:asList1('Nome')}"
			columns="${coll:asList1('name')}" elements="${categoryList}" />
	</tiles:putAttribute>
	
	<tiles:putAttribute name="body">
		<w:conteudoPagina titulo="Categorias">
			<div id="tabela-categoria"></div>
			<div class="barra_botoes">
				<w:voltar collabletInstance="${categoryMgr.collablet.parent}" />
			</div>
		</w:conteudoPagina>
	</tiles:putAttribute>
</tiles:insertTemplate>