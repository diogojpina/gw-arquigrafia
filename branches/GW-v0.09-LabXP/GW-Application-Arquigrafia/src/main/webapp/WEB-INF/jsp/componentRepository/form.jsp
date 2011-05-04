<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Arquigrafia Brasil</tiles:putAttribute>

	<tiles:putAttribute name="body">
		<div class="default_div">
			<h1>Cadastre um novo componente no Reposit&oacute;rio</h1>
			<c:if test="${!empty errors}">
				<c:forEach var="error" items="${errors}">
					<p>
						<c:out value="${error.category}" />
						:
						<c:out value="${error.message}" />
					</p>
				</c:forEach>
			</c:if>
			<form method="post"
				action="<c:url value="/groupware-workbench/repository/${componentRepository.id}/new" />"
				enctype="multipart/form-data">
				<ul>
					<li>Nome:<br />
					<input type="text" name="component.name"
						value="<c:out value="${component.name}" />" />
					</li>
					<li>Descri&ccedil;&atilde;o:<br />
					<textarea name="component.description">
							<c:out value="${component.description}" />
						</textarea>
					</li>
					<li>Pacote:<br />
					<input type="text" name="component.packageName"
						value="<c:out value="${component.packageName}" />" />
					</li>
					<li>A&ccedil;&atilde;o:<br />
					<input type="text" name="component.action"
						value="<c:out value="${component.action}" />" />
					</li>
					<li>Vers&atilde;o:<br />
					<input type="text" name="component.version"
						value="<c:out value="${component.version}" />" />
					</li>
					<li>Arquivo APK:<br />
					<input type="file" name="componentUploadedFile" />
					</li>
					<li><input type="submit" value="Cadastrar" />
					</li>
				</ul>
			</form>
		</div>
	</tiles:putAttribute>
</tiles:insertTemplate>