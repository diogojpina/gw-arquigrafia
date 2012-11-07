<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Papel</tiles:putAttribute>

	<tiles:putAttribute name="body">
		<w:conteudoPagina titulo="Papel">
			<br />
			<form name="dados" method="POST"
				action='<c:url value="/groupware-workbench/roles/${roleMgr.id}" />'
				accept-charset="UTF-8">
				<input type="hidden" name="role.id"
					value="<c:out value="${role.id}" />" /> <input type="hidden"
					name="role.idInstance" value="<c:out value="${roleMgr.id}" />" />
				<div class="form_1" id="role_retrieve_f1">
					<ul class="field_line_f1">
						<li class="label_f1"><span>Nome</span>
						</li>
						<li class="input_f1"><input type="text" name="role.name"
							value="<c:out value="${role.name}" />" />
						</li>
					</ul>
				</div>
				<div class="form_1">
					<ul class="bt_line_f1">
						<li class="bt_cell_submit"><input type="submit" class="botao"
							value="Ok" />
						</li>
					</ul>
				</div>
			</form>
			<div class="barra_botoes">
				<w:voltar collabletInstance="${roleMgr.collablet}" />
			</div>
		</w:conteudoPagina>
	</tiles:putAttribute>
</tiles:insertTemplate>
