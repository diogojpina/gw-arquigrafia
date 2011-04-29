<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Arquigrafia Brasil - Meu Arquigrafia</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<arq:header2 photoInstance="${photoMgr}" />
		
		<w:conteudoPagina titulo="&Aacute;lbuns: ">
			<br />
			<h1>
				<span class="style1">Lista de &Aacute;lbuns</span>
			</h1>
			<br />
			<album:list albumMgr="${albumMgr}" albuns="${albumList}"
				showEdit="true" showNumber="true" />
		</w:conteudoPagina>
		<div>
			<div style="height: 30px; background-color: #fff"></div>
			<arq:footer photoInstance="${photoMgr}" />
		</div>
	</tiles:putAttribute>
</tiles:insertTemplate>