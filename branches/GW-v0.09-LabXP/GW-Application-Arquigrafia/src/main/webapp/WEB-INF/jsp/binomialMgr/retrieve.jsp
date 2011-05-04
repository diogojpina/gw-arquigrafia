<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Bin&ocirc;mios</tiles:putAttribute>

	<tiles:putAttribute name="body">
		<w:conteudoPagina titulo="Bin&ocirc;mios">
			<form method="post"
				action="<c:url value="/groupware-workbench/binomials/${binomialMgr.id}" />"
				accept-charset="UTF-8">
				<input type="hidden" name="binomial.id"
					value="<c:out value="${binomial.id}" />" />

				<div class="form_1">
					<div>
						<ul class="field_line_f1">
							<li class="label_f1"><span>1&ordm; Bin&ocirc;mio:</span>
							</li>
							<li class="input_f1"><input type="text"
								name="binomial.firstName"
								value="<c:out value="${binomial.firstName}" />" />
							</li>
						</ul>
					</div>
					<div>
						<ul class="field_line_f1">
							<li class="label_f1"><span>Descri&ccedil;&atilde;o:</span>
							</li>
							<li class="input_f1"><input type="text"
								name="binomial.firstDescription"
								value="<c:out value="${binomial.firstDescription}" />" />
							</li>
						</ul>
					</div>
					<div>
						<ul class="field_line_f1">
							<li class="label_f1"><span>Link:</span>
							</li>
							<li class="input_f1"><input type="text"
								name="binomial.firstLink"
								value="<c:out value="${binomial.firstLink}" />" />
							</li>
						</ul>
					</div>
					<div>
						<ul class="field_line_f1">
							<li class="label_f1"><span>2&ordm; Bin&ocirc;mio:</span>
							</li>
							<li class="input_f1"><input type="text"
								name="binomial.secondName"
								value="<c:out value="${binomial.secondName}" />" />
							</li>
						</ul>
					</div>
					<div>
						<ul class="field_line_f1">
							<li class="label_f1"><span>Descri&ccedil;&atilde;o:</span>
							</li>
							<li class="input_f1"><input type="text"
								name="binomial.secondDescription"
								value="<c:out value="${binomial.secondDescription}" />" />
							</li>
						</ul>
					</div>
					<div>
						<ul class="field_line_f1">
							<li class="label_f1"><span>Link:</span>
							</li>
							<li class="input_f1"><input type="text"
								name="binomial.secondLink"
								value="<c:out value="${binomial.secondLink}" />" />
							</li>
						</ul>
					</div>
					<div>
						<ul class="field_line_f1">
							<li class="label_f1"><span>Valor padr&atilde;o:</span>
							</li>
							<li class="input_f1"><input type="text"
								name="binomial.defaultValue"
								value="<c:out value="${binomial.defaultValue}" />" />
							</li>
						</ul>
					</div>
					<div>
						<ul class="bt_line_f1">
							<li class="bt_cell_submit"><input type="submit"
								class="botao" value="Ok" /></li>
						</ul>
					</div>
				</div>
			</form>
			<div class="barra_botoes">
				<w:voltar collabletInstance="${binomialMgr.collablet}" />
			</div>
			<div>
				<div style="height: 30px; background-color: #fff"></div>
			</div>
		</w:conteudoPagina>
	</tiles:putAttribute>
</tiles:insertTemplate>