<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">

	<tiles:putAttribute name="title">Usu&aacuterio</tiles:putAttribute>

	<tiles:putAttribute name="head">
		<script type="text/javascript">
            $(document).ready(function() {
                $("#form1").validate();
            });
        </script>

		<profile:scriptProfile />
	</tiles:putAttribute>
	
	<tiles:putAttribute name="body">
		<div id="corpo" class="default_div">
			<%-- <div id="info" class="default_info"> --%>
			<div id="info"
				style="display: block; width: 500px; margin-left: auto; margin-right: auto; margin-top: 10px; background: transparent;">
				<w:conteudoPagina titulo="Usu&aacute;rio">
					<br />
					<ul>
						<c:forEach var="error" items="${errors}">
							<li><c:out value="${error.message}" /> - <c:out
									value="${error.category}" />
							</li>
						</c:forEach>
					</ul>

					<form id="form1" class="cmxform" name="dados" method="POST"
						action="<c:url value="/groupware-workbench/users/${userMgr.id}" />"
						accept-charset="UTF-8" autocomplete="off">
						<input type="hidden" name="user.id"
							value="<c:out value="${user.id}" />" />
						<div class="form_1" id="user_retrieve_form">
							<ul class="field_line_f1">
								<li class="label_f1"><span>Login:</span>
								</li>
								<li class="input_f1"><input type="text" class="required"
									name="user.login" value="<c:out value="${user.login}" />" />
								</li>
							</ul>
							<ul class="field_line_f1">
								<li class="label_f1"><span>Password:</span>
								</li>
								<li class="input_f1"><input id="password" class="required"
									type="password" name="user.password"
									value="<c:out value="${user.password}" />" />
								</li>
							</ul>
							<ul class="field_line_f1">
								<li class="label_f1"><span>E-mail:</span>
								</li>
								<li class="input_f1"><input id="email"
									class="required email" type="text" name="user.email"
									value="<c:out value="${user.email}" />" />
								</li>
							</ul>
							<ul class="field_line_f1">
								<li class="label_f1"><span>Nome:</span>
								</li>
								<li class="input_f1"><input id="name" class="required"
									type="text" name="user.name"
									value="<c:out value="${user.name}" />" />
								</li>
							</ul>
							<ul class="field_line_f1">
								<li class="label_f1"><span>URL da sua foto:</span>
								</li>
								<li class="input_f1"><input id="photoURL" type="text"
									name="user.photoURL" value="<c:out value="${user.photoURL}" />" />
								</li>
							</ul>
						</div>

						<c:if test="${profileMgr.collablet.enabled}">
							<profile:profile profileMgr="${profileMgr}" user="${user}" />
						</c:if>

						<c:if test="${roleMgr.collablet.enabled}">
							<div class="subsection_f1">
								<fieldset>
									<legend>
										<span class="subtitle_f1">Atribuir pap&eacute;is:</span>
									</legend>
									<role:selectRole roleMgr="${roleMgr}" user="${user}" />
								</fieldset>
							</div>
						</c:if>

						<div class="form_1">
							<ul class="bt_line_f1">
								<li class="bt_cell_submit"><input type="submit"
									class="botao" value="Ok" /></li>
							</ul>
						</div>
					</form>
					<div class="barra_botoes" align="center">
						<w:voltar collabletInstance="${userMgr.collablet}" />
					</div>
				</w:conteudoPagina>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertTemplate>