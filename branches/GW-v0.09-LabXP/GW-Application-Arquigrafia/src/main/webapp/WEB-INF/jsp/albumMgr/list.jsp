<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Arquigrafia Brasil - Meu Arquigrafia</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<w:conteudoPagina titulo="&Aacute;lbuns: ">
			<br />
			<h1>
				<span class="style1">Lista de &Aacute;lbuns</span>
			</h1>
			<br />
			<album:list albumMgr="${albumMgr}" albuns="${albumList}"
				showEdit="true" showNumber="true" />
		</w:conteudoPagina>
	</tiles:putAttribute>
</tiles:insertTemplate>