<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">

	<tiles:putAttribute name="title">Perguntas frequentes</tiles:putAttribute>

	<tiles:putAttribute name="head">
		<w:tabela baseUrl="/groupware-workbench/faq"
			createUrl="/groupware-workbench/faq/${faqMgr.id}/create"
			msgAdd="Adicionar nova pergunta"
			msgDelete="Tem certeza que deseja excluir a pergunta?"
			msgVazio="Não há perguntas no FAQ." target="tabela-perguntas"
			titles="${coll:asList1('Pergunta')}"
			columns="${coll:asList1('pergunta')}" elements="${faqList}" />
	</tiles:putAttribute>
	
	<tiles:putAttribute name="body">
		<w:conteudoPagina titulo="Faq">
			<div class="page_element">
				<span class="subTitulo">Lista de perguntas e respostas
					frequentes</span>
				<div id="tabela-perguntas"></div>
			</div>

			<div class="page_element">
				<span class="subTitulo">Collablets</span>
				<w:menuFerramentas collabletInstance="${faqMgr.collablet}" />
			</div>

			<div class="barra_botoes">
				<w:voltar collabletInstance="${faqMgr.collablet.parent}" />
			</div>
		</w:conteudoPagina>
	</tiles:putAttribute>
</tiles:insertTemplate>