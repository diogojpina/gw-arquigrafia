<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">

	<tiles:putAttribute name="title">Sugest&otilde;es e Reportar Problemas</tiles:putAttribute>
	
	<tiles:putAttribute name="body">
		<div id="corpo" class="default_div">
			<div id="info" class="default_info">
				<span class="input_f1" style="padding: 10px;">A sua mensagem
					foi encaminhada com &ecirc;xito. Obrigado por a sua
					colabora&ccedil;&atilde;o.</span>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertTemplate>
