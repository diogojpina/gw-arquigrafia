<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Sugest&otilde;es e cr&iacute;ticas</tiles:putAttribute>

	<tiles:putAttribute name="head">
		<script type="text/javascript">
            $(document).ready(function() {
            	$('span#msg').hide();
            	$('span#subjectMsg').hide();
            });

            function validaForm() {
                d = document.formulario;
            	if (d.subject.value == "") {
                    $('span#subjectMsg').show();
            	    d.subject.focus();
            	    return false;
                }
                if (d.message.value == "") {
                    $('span#msg').show();
                    d.message.focus();
                    return false;
                }
                return true;
            }
        </script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="body">
		<div id="corpo" class="default_div">
			<form id="form1" class="cmxform" name="formulario" method="POST"
				action="<c:url value="/groupware-workbench/user/${userMgr.id}/sendEmail/${userLogin.id}" />"
				accept-charset="UTF-8" onSubmit="return validaForm()"
				autocomplete="off">
				<div id="info" class="default_info">
					<span class="tituloPrincipal">Sugest&otilde;es e
						Cr&iacute;ticas:</span>
					<ul class="field_line_f1">
						<li class="label_f1"><span>Nome:</span>
						</li>
						<li class="input_f1"><c:out
								value="${sessionScope.userLogin.name}" />
						</li>
					</ul>
					<ul class="field_line_f1">
						<li class="label_f1"><span>Assunto</span>
						</li>
						<li class="input_f1"><input id="subject" type="text"
							name="subject" value="" /> <span id="subjectMsg">O campo
								Assunto tem que ser preenchido</span></li>
					</ul>
					<ul class="field_line_f1">
						<li class="label_f1"><span>Sugest&otilde;es e
								cr&iacute;ticas:</span>
						</li>
						<li class="input_f1"><input type="hidden" id="reason"
							name="reason" value="Sugest&otilde;es e cr&iacute;ticas:" /> <textarea
								rows="4" cols="60" id="message" name="message"></textarea> <span
							id="msg">O campo tem que ser preenchido </span></li>
					</ul>
					<br />
				</div>
				<div style="text-align: center;">
					<input type="submit" class="botao" value="Enviar" />
				</div>
			</form>
		</div>
	</tiles:putAttribute>
</tiles:insertTemplate>