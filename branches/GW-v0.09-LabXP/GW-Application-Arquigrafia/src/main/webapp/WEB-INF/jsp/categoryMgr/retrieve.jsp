<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">

	<tiles:putAttribute name="title">Categoria</tiles:putAttribute>

	<tiles:putAttribute name="body">
		<w:conteudoPagina titulo="Categoria">
			<br />
			<ul>
				<c:forEach var="error" items="${errors}">
					<li><c:out value="${error.message}" /> - <c:out
							value="${error.category}" />
					</li>
				</c:forEach>
			</ul>

			<form id="dados" class="cmxform" name="dados" method="POST"
				action="<c:url value="/groupware-workbench/categories/${categoryMgr.id}" />"
				accept-charset="UTF-8">
				<input type="hidden" name="category.id"
					value="<c:out value="${category.id}" />" /> <br /> Nome: <input
					type="text" name="category.name" value="${category.name}" /> <br />
				<input type="submit" class="botao" value="Ok" /> &nbsp; &nbsp;
				<w:voltar collabletInstance="${categoryMgr.collablet}" />
			</form>
		</w:conteudoPagina>
	</tiles:putAttribute>
</tiles:insertTemplate>