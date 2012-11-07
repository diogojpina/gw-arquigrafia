<%@ include file="/WEB-INF/jsp/imports.jsp" %>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Arquigrafia Brasil - Admin</tiles:putAttribute>
	
	<tiles:putAttribute name="body">
         <w:conteudoPagina titulo="Busca Fotos">
            <span class="subTitulo">Collablets</span>
            <br />
            <br />
            <w:menuFerramentas collabletInstance="${photoInstance.collablet}" />
            <br />
            <br />
            <br />
            <a href="<c:url value="/groupware-workbench/photo/${photoInstance.id}/registra"/>">Registrar uma nova foto</a>
            <br />
            <br />
            <div>
                <h1>Busca de Fotos</h1>
                <photo:search photoInstance="${photoInstance}" />
            </div>
            <div>
                <photo:list photos="${fotos}" photoInstance="${photoInstance}" showName="true" showLocation="true" />
            </div>
            <div>
                <h1>Lista Fotos</h1>
                <photo:listAll photoInstance="${photoInstance}" keepRatio="true" />
            </div>

            <c:forEach var="error" items="${errors}">
                <c:out value="${error.category}" /> - <c:out value="${error.message}" />
                <br />
            </c:forEach>

            <div class="barra_botoes">
                <w:voltar collabletInstance="${photoInstance.collablet}" />
            </div>
        </w:conteudoPagina>
	</tiles:putAttribute>
</tiles:insertTemplate>