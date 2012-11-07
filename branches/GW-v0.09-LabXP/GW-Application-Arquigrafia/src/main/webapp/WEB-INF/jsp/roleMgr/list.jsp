<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Pap&eacute;is</tiles:putAttribute>

	<tiles:putAttribute name="head">
		<w:tabela baseUrl="/groupware-workbench/roles"
			createUrl="/groupware-workbench/roles/${roleMgr.id}/create"
			msgAdd="Adicionar Papel"
			msgDelete="Tem certeza que deseja remover este papel?"
			target="tabela-roles" titles="${coll:asList1('Papel')}"
			columns="${coll:asList1('name')}" elements="${roleList}" />
	</tiles:putAttribute>

	<tiles:putAttribute name="body">
		<w:conteudoPagina titulo="Pap&eacute;is">
			<div id="tabela-roles"></div>
			<div class="barra_botoes">
				<w:voltar collabletInstance="${roleMgr.collablet.parent}" />
			</div>
		</w:conteudoPagina>
	</tiles:putAttribute>
</tiles:insertTemplate>