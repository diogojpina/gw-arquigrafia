<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Arquigrafia Brasil</tiles:putAttribute>

	<tiles:putAttribute name="body">
		<div class="default_div">
			<h1>Componentes do Reposit&oacute;rio</h1>
			<a
				href="<c:url value="/groupware-workbench/repository/${componentRepository.id}/new" />">Cadastrar
				novo componente</a>
			<table border="1">
				<tr>
					<th>Nome</th>
					<th>Descri&ccedil;&atilde;o</th>
					<th>Vers&atilde;o</th>
					<th>MD5</th>
					<th>Tamanho</th>
					<th>Data</th>
					<th>Deletar</th>
					<th>Baixar</th>
				</tr>
				<c:if test="${!empty componentList}">
					<c:forEach var="cmp" items="${componentList}">
						<tr>
							<td><c:out value="${cmp.name}" /></td>
							<td><c:out value="${cmp.description}" /></td>
							<td><c:out value="${cmp.version}" /></td>
							<td><c:out value="${cmp.md5hash}" /></td>
							<td><c:out value="${cmp.size}" /></td>
							<td><c:out value="${cmp.insertionDate}" /></td>
							<td>
								<form method="post"
									action="<c:url value="/groupware-workbench/repository/${componentRepository.id}/${cmp.id}" />">
									<input type="hidden" name="_method" value="DELETE" /> <input
										type="submit" value="Deletar" />
								</form>
							</td>
							<td>
								<form method="get"
									action="<c:url value="/groupware-workbench/repository/${componentRepository.id}/${cmp.id}/download" />">
									<input type="submit" value="Baixar" />
								</form>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty componentList}">
					<tr>
						<td colspan="8">Nenhum componente cadastrado.</td>
					</tr>
				</c:if>
			</table>
		</div>
	</tiles:putAttribute>
</tiles:insertTemplate>