<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template_plain.jsp">

	<tiles:putAttribute name="title">Arquigrafia Brasil - Edi&ccedil;&atilde;o de &aacute;lbum</tiles:putAttribute>

	<tiles:putAttribute name="body">
		<w:topo collabletInstance="${albumMgr.collablet}" />
		<w:conteudoPagina titulo="&Aacute;lbum: ${album.title}">
			<br />
			<h1>
				<span class="style1">Editar &aacute;lbum</span>
			</h1>
			<br />
			<album:edit album="${album}" albumMgr="${albumMgr}" />
			<!-- <c:if test="${counterMgr.collablet.enabled}">
                <counter:showCounter manager="${counterMgr}" entity="${album}" increment="true" />
            </c:if>
            -->
			<div class="barra_botoes">
				<w:voltar collabletInstance="${albumMgr.collablet}" />
			</div>
		</w:conteudoPagina>
	</tiles:putAttribute>
</tiles:insertTemplate>
