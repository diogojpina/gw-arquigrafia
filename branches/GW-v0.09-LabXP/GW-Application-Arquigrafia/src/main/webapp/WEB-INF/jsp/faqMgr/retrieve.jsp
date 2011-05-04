<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">

	<tiles:putAttribute name="title">Faq</tiles:putAttribute>

	<tiles:putAttribute name="head">
		<tag:scriptTags />
		<binomial:scriptBinomial />
	</tiles:putAttribute>
	
	<tiles:putAttribute name="body">
		<w:conteudoPagina titulo="Faq:">
			<br />
			<h1>
				<span class="style1">Cadastro</span>
			</h1>
			<br />
			<form name="dados" method="post"
				action="<c:url value="/groupware-workbench/faq/${faqMgr.id}" />">
				<input type="hidden" name="faq.id"
					value="<c:out value="${faq.id}" />" />
				<%-- TODO: Tableless! --%>
				<table cellpadding="3">
					<c:if test="${categoryMgr.collablet.enabled}">
						<tr>
							<td>Categoria</td>
							<td><category:simpleDropDownBox entity="${faq}"
									categoryMgr="${categoryMgr}" /></td>
						</tr>
					</c:if>
					<tr>
						<td>Pergunta</td>
						<td><input size="60" type="text" name="faq.pergunta"
							value="<c:out value="${faq.pergunta}" />" />
						</td>
					</tr>
					<tr>
						<td>Resposta</td>
						<td><textarea rows="4" cols="60" name="faq.resposta">
								<c:out value="${faq.resposta}" />
							</textarea>
						</td>
					</tr>
					<tr>
						<td></td>
						<td><c:if test="${tagMgr.collablet.enabled}">
                                Tags clique em uma das tags abaixo para adicion&aacute;-la ao FAQ.
                                <br />
								<tag:selectTags tagMgr="${tagMgr}" />
								<tag:setTags tagMgr="${tagMgr}" entity="${faq}" />
							</c:if></td>
						<td><c:if test="${binomialMgr.collablet.enabled}">
								<%-- FIXME: binomial:setBinomial não existe e nem nunca existiu! --%>
								<binomial:setBinomial binomialMgr="${binomialMgr}"
									entity="${faq}" user="${sessionScope.userLogin}" />
							</c:if></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" class="botao" value="Ok" /></td>
					</tr>
				</table>
				<br /> <br /> <br />
			</form>
			<div class="barra_botoes">
				<w:voltar collabletInstance="${faqMgr.collablet}" />
			</div>
		</w:conteudoPagina>
	</tiles:putAttribute>
</tiles:insertTemplate>