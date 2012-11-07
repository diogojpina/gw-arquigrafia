<%@ include file="/WEB-INF/jsp/imports.jsp"%>
<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">

	<tiles:putAttribute name="title">Convidar usu&aacute;rio</tiles:putAttribute>

	<tiles:putAttribute name="head">
		<script type="text/javascript">
            function aviso() {
                alert("Seu convite foi enviado.");
            }
        </script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="body">
		<div
			style="margin-top: 20px; background: white; width: 100%; height: 500px; min-height: 300px; margin-top: 0px; padding-top: 0px; overflow: auto;">
			<br /> <span class="big_black_title" style="text-align: right;">Usu&aacute;rios
				do sistema</span> <br />
			<c:if test="${userMgr.collablet.enabled}">
				<c:forEach items="${userMgr.allElements}" var="u">
					<c:if test="${u.login != userLogin.login}">
						<div style="float: left; margin: 20px auto; padding: 10px;">
							<div class="linha">
								<a
									href="${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/show/${u.id}">
									<c:choose>
										<c:when test="${empty u.photoURL}">
											<img class="imagem_user"
												src="<c:url value="/images/users/default.jpg" />" />
										</c:when>
										<c:otherwise>
											<img class="imagem_user"
												src="<c:out value="${u.photoURL}" />"
												alt="Foto do usu&aacute;rio" />
										</c:otherwise>
									</c:choose> </a> &nbsp;
								<div class="coluna">
									<div class="linha">
										<a class="blue_link"
											href="${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/show/${u.id}">
											<c:out value="${u.name}" /> </a>
									</div>
									<div class="linha">
										<friends:sendRequest friendsMgr="${friendsMgr}"
											viewer="${userLogin}" viewed="${u}"
											afterRequestFunction="aviso" />
									</div>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</c:if>
		</div>
	</tiles:putAttribute>
</tiles:insertTemplate>