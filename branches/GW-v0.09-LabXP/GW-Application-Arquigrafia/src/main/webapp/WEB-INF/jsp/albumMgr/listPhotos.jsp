<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Arquigrafia Brasil - &Aacute;lbuns</tiles:putAttribute>

	<tiles:putAttribute name="body">
		<album:listPhotos album="${album}" classe="main-lista-fotos" />
	</tiles:putAttribute>
</tiles:insertTemplate>


