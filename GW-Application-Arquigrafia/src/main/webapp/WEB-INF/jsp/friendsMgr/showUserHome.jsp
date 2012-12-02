<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="arquigrafia"
	uri="http://www.groupwareworkbench.org.br/widgets/arquigrafia"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r"
	uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ taglib prefix="s"
	uri="http://www.groupwareworkbench.org.br/widgets/security"%>
<%@ taglib prefix="p"
	uri="http://www.groupwareworkbench.org.br/widgets/photomanager"%>
<%@ taglib prefix="w"
	uri="http://www.groupwareworkbench.org.br/widgets/commons"%>
<%@ taglib prefix="friends"
	uri="http://www.groupwareworkbench.org.br/widgets/friends"%>
<%@taglib prefix="profile"
	uri="http://www.groupwareworkbench.org.br/widgets/profile"%>
<%@taglib prefix="user"
	uri="http://www.groupwareworkbench.org.br/widgets/user"%>
<%@ taglib prefix="photo"
	uri="http://www.groupwareworkbench.org.br/widgets/photomanager"%>
<%@ taglib prefix="album"
	uri="http://www.groupwareworkbench.org.br/widgets/album"%>
<%@ taglib prefix="comment"
	uri="http://www.groupwareworkbench.org.br/widgets/comment"%>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="s"
	uri="http://www.groupwareworkbench.org.br/widgets/security"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">


<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Arquigrafia - Seu universo de imagens de arquitetura</title>
<arquigrafia:includes arquigrafiaInstance="${arquigrafiaMgr}" />
<script type="text/javascript" src="<c:url value="/js/friend.js" />"></script>

</head>

<body>
	<!--   CONTAINER   -->
	<div id="container">

		<!--   CABEÇALHO   -->
		<arquigrafia:header arquigrafiaInstance="${arquigrafiaMgr}" />

		<!--   MEIO DO SITE - ÁREA DE NAVEGAÇÃO   -->
		<div id="content">
			<!--   BARRA LATERAL - ESQUERDA   -->
			<div id="left_sidebar">

				<c:choose>
					<c:when test="${empty friend.photoURL}">
						<c:choose>
							<c:when test="${friend.id == userLogin.id}">
								<a
									href="<c:url value="/profile/${profileMgr.id}/uploadphotoprofile" />">
									<img name="Homer" id="profile_photo_edit"
									class="profile_photo_edit"
									src="<c:url value="/img/avatar.jpg" />" />
								</a>
							</c:when>
							<c:otherwise>
								<img name="Homer" id="profile_photo"
									src="<c:url value="/img/avatar.jpg" />" />
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>

						<c:choose>
							<c:when test="${friend.id == userLogin.id}">
								<a
									href="<c:url value="/profile/${profileMgr.id}/uploadphotoprofile" />">
									<img name="Homer" id="profile_photo_edit"
									class="profile_photo_edit"
									src="<c:url value="${friend.photoURL}" />" />
								</a>
							</c:when>
							<c:otherwise>
								<img name="Homer" id="profile_photo_edit"
									src="<c:url value="${friend.photoURL}" />" />
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>

				<!-- <a href="#" id="small">Trocar fotografia</a> -->
				<c:if test="${friend.id == userLogin.id}">
					<friends:friendsRequests style="width: 475px;" user="${userLogin}"
						friendsMgr="${friendsMgr}"
						afterRejectFunction="refreshFriendsPage"
						afterAcceptFunction="refreshFriendsPage"
						friendsHeader="friends_header" />
				</c:if>

				<!-- rodrigo -->
				<s:check name="X-X-usuario">
					<c:if test="${friend.id == userLogin.id}">
						<form class="cmxform" name="edit" method="POST"
							action="<c:url value="/groupware-workbench/user/" />"
							accept-charset="UTF-8" autocomplete="off">
							<input type="hidden" id="idUser" name="idUser"
								value="<c:out value="${friend.id}" />" /> <input type="hidden"
								id="url" name="url"
								value="/groupware-workbench/friends/${friendsMgr.id}/show/${friend.id}" />
						</form>
					</c:if>


					<friends:sendRequest friendsMgr="${friendsMgr}"
						viewer="${userLogin}" viewed="${friend}" />
				</s:check>


				<!--   EVENTOS   -->
				<h3>Eventos</h3>
				<!--   BOX - EVENTOS   -->
				<div id="invitation">
					<p>Nenhum evento no momento.</p>
				</div>
				<!--   ENVIAR CONVITE   -->
				<!-- <h3>Convites</h3>
        	<p>Envie um e-mail para seus amigos e convide-os para participarem do Arquigrafia.</p>
        	<input type="email" id="invite_email" name="invite_email" value="exemplo@email.com.br" />
        	<br />
        	<a href="#" id="right_alignment">Enviar</a>
        	 -->
			</div>

			<!--   CONTEÚDO   -->
			<div id="middle_content">
				<user:show user="${friend}" editUserButtonId="edit_user_button"
					editUserButtonClass="profile_edit" />
				<profile:showProfile profileMgr="${profileMgr}" user="${friend}"
					editProfileButtonId="edit_perfil_button"
					editProfileButtonClass="profile_edit" />
			</div>

			<!--   BARRA LATERAL - DIREITA   -->
			<div id="right_sidebar">

				<friends:listFriends user="${friend}" friendsMgr="${friendsMgr}"
					friendsHeader="friends_header" style="width: 400px;" />

				<!-- rodrigo -->
				<%-- 									<c:choose>
                     <c:when test="${empty friend.photoURL}">
                        <img class="imagem_user" src="<c:url value="/images/users/default.jpg" />" />
                     </c:when>
                     <c:otherwise>
                         <img class="imagem_user" src="${friend.photoURL}" />
                     </c:otherwise>
                 </c:choose>
 --%>
				<!-- 		       <h2 id="profile_block_title">Comunidades</h2>
		       <a href="#" id="small" class="profile_block_link">Ver todas</a>
 -->

				<!--  					<div id="profile_box">
							<ul id="communities_list">
		            	<li><a href="#">Arquitetura moderna</a></li>
		            	<li><a href="#">Arquitetos USP</a></li>
		            	<li><a href="#">Lorem ipsum</a></li>
		            	<li><a href="#">Lorem ipsum</a></li>
		            	<li><a href="#">Lorem ipsum</a></li>
		            	<li><a href="#">Lorem ipsum</a></li>
		            	<li><a href="#">Lorem ipsum</a></li>
		            	<li><a href="#">Lorem ipsum</a></li>
	          	</ul>
	        </div> 
 -->
				<album:listGalery albumMgr="${albumMgr}" user="${friend}" />

			</div>

			<!-- FIM-BARRA LATERAL - DIREITA -->

			<!-- rodrigo -->
			<div class="linha">
				<c:if test="${commentMgr2.collablet.enabled}">
					<div id="comentario" style="width: 700px; float: left;">
						<div id="comments_bar">
							<div id="comments_bar_bg">
								<%--                                         <div id="comments_bar_title" class="big_blue_title2">
                                            <p>Mensagens</p>
                                        </div>
 --%>
								<div id="comments_bar_link" class="comments_link">
									<a id="single_view_message_open" href="#" class="white_link"
										title="Ver mensagens">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + Ver mensagens </a>
								</div>
								<div id="comments_bar_link2" class="comments_link">
									<a href="#" title="Ocultar mensagens"
										id="single_view_message_close">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + Ocultar mensagens </a>
								</div>
							</div>
						</div>
						<div id="comments_create" style="height: 130px;">
							<comment:getComments commentMgr="${commentMgr2}"
								entity="${friend}" />
							<comment:addComment commentMgr="${commentMgr2}"
								uri="/friends/${friendsMgr.id}/${friend.id}"
								idObject="${friend.id}" user="${sessionScope.userLogin}" />
							<br />
							<br />
							<br />
							<br />
						</div>
					</div>
				</c:if>
			</div>



			<div id="comments_block"></div>


			<div id="added_images_bar">
				<h3>Minhas imagens:</h3>
				<p:photosByUser photoMgr="${photoMgr}" user="${friend}" />
			</div>
		</div>
		<!--   FUNDO DO SITE   -->
		<div id="footer">
			<!--   BARRA DE ABAS   -->
			<arquigrafia:tabs arquigrafiaInstance="${arquigrafiaMgr}"
				commentMgr="${commentMgr}" photoMgr="${photoMgr}"
				counterMgr="${counterMgr}" />
			<!--   FIM - BARRA DE IMAGENS - (RODAPÉ)   -->


			<!--   CRÉDITOS - LOGOS   -->
			<arquigrafia:footer arquigrafiaInstance="${arquigrafiaMgr}" />
		</div>
		<!--   FIM - FUNDO DO SITE   -->
		<!--   MODAL   -->
		<div id="mask"></div>
		<div id="form_window">
			<!-- ÁREA DE LOGIN - JANELA MODAL -->
			<a class="close" href="#" title="FECHAR"></a>
			<div id="registration"></div>
		</div>
		<!--   FIM - MODAL   -->
	</div>
	<!--   FIM - CONTAINER   -->
</body>
</html>
