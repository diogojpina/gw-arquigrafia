<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Recados</tiles:putAttribute>

	<tiles:putAttribute name="head">
		<style>
			body {
				background: url(../../../../images/header_bg.jpg) no-repeat scroll 0 0
					transparent;
			}
		</style>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="body">
		<div id="corpo" class="default_div">
			<div id="info" class="default_info">
				<br />
				<div class="linha">
					<c:if test="${friend.id == userLogin.id}">
						<c:if test="${not empty pending}">
							<h4
								style="color: #DF4C32; font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold;">
								voc&ecirc; tem ${pending} convite(s) de amizade pendente(s),
								clique <a class="blue_link"
									href="<c:url value="/groupware-workbench/friends/${friendsMgr.id}/edit" />">aqui</a>
								para visualiz&aacute;-las ou no link Editar Amigos.
							</h4>
							<br />
						</c:if>
					</c:if>
				</div>
				<div class="linha">
					<div class="coluna" style="float: left;">
						<c:choose>
							<c:when test="${empty friend.photoURL}">
								<img class="imagem_user"
									src="<c:url value="/images/users/default.jpg" />" />
							</c:when>
							<c:otherwise>
								<img class="imagem_user" src="${friend.photoURL}" />
							</c:otherwise>
						</c:choose>
					</div>
					<div class="coluna" style="float: left; width: 475px;">
						<div class="linha">
							<span class="big_black_title"><c:out
									value="${friend.name}" />
							</span>
						</div>
						<div class="linha">
							<c:if test="${friend.id == userLogin.id}">
								<form class="cmxform" name="edit" method="POST"
									action="<c:url value="/groupware-workbench/user/edit" />"
									accept-charset="UTF-8" autocomplete="off">
									<input type="hidden" id="idUser" name="idUser"
										value="<c:out value="${friend.id}" />" /> <input
										type="hidden" id="url" name="url"
										value="/groupware-workbench/friends/${friendsMgr.id}/show/${friend.id}" />
									<input type="submit" name="Editar" value="Editar perfil" />
								</form>
							</c:if>
							<friends:sendRequest friendsMgr="${friendsMgr}"
								viewer="${userLogin}" viewed="${friend}" />
						</div>
					</div>
					<div class="coluna" style="float: left;">
						<friends:listFriends user="${friend}" friendsMgr="${friendsMgr}"
							friendsHeader="friends_header" style="width: 400px;" />
					</div>
				</div>
				<br />
				<div id="informacao" class="linha">
					<br /> <br />
					<c:if test="${profileMgr.collablet.enabled}">
						<profile:showProfile profileMgr="${profileMgr}" user="${friend}" />
					</c:if>
				</div>
				<div class="linha">
					<c:if test="${commentMgr2.collablet.enabled}">
						<div id="comentario" style="width: 700px; float: left;">
							<form name="comments" method="post" enctype="multipart/form-data"
								action="<c:url value="/groupware-workbench/friends/${friendsMgr.id}/show/${friend.id}" />">
								<div id="comments_bar">
									<div id="comments_bar_bg">
										<div id="comments_bar_title" class="big_blue_title2">
											<p>Mensagens</p>
										</div>
										<div id="comments_bar_link" class="comments_link">
											<a class="white_link"><img
												src="${pageContext.request.contextPath}/images/add_comment.png"
												alt="Adicionar Mensagem" />
											</a>
										</div>
										<div id="comments_bar_link2" class="comments_link">
											<a class="white_link"><img
												src="${pageContext.request.contextPath}/images/add_comment2.png"
												alt="Adicionar Mensagem" />
											</a>
										</div>
									</div>
								</div>
								<div id="comments_create" style="height: 130px;">
									<comment:addComment commentMgr="${commentMgr2}"
										idObject="${friend.id}" user="${sessionScope.userLogin}"
										editorClass="editorClass" wrapClass="comments_create_internal" />
									<input name="commentAdd" value="Adicionar" type="submit" />
								</div>
								<div id="comments_show">
									<comment:getComments commentMgr="${commentMgr2}"
										entity="${friend}" wrapClass="comments_show_internal" />
								</div>
								<script type="text/javascript">
                                    $("#comments_create").hide();
                                    $("#comments_bar_link2").hide();
                                    $("#comments_bar_link").click(function(){
                                        $("#comments_create").slideDown();
                                        $("#comments_bar_link").hide();
                                        $("#comments_bar_link2").show();
                                    });
                                    $("#comments_bar_link2").click(function(){
                                        $("#comments_create").slideUp();
                                        $("#comments_bar_link2").hide();
                                        $("#comments_bar_link").show();
                                    });
                                </script>
							</form>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertTemplate>