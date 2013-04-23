<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="arquigrafia" uri="http://www.groupwareworkbench.org.br/widgets/arquigrafia"%>
<%@ taglib prefix="album" uri="http://www.groupwareworkbench.org.br/widgets/album"%>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager"%>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag"%>
<%@ taglib prefix="comment" uri="http://www.groupwareworkbench.org.br/widgets/comment"%>
<%@ taglib prefix="counter" uri="http://www.groupwareworkbench.org.br/widgets/counter" %>
<%@ taglib prefix="friends" uri="http://www.groupwareworkbench.org.br/widgets/friends" %>
<%@ taglib prefix="binomial" uri="http://www.groupwareworkbench.org.br/widgets/binomial" %>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>
<%@ taglib prefix="util" uri="http://www.groupwareworkbench.org.br/widgets/util"%>


<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Arquigrafia - <c:out value="${photo.name}"/></title>
<arquigrafia:includes arquigrafiaInstance="${arquigrafiaMgr}" />
<link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/jquery.fancybox.css" />" />

<script type="text/javascript" src="<c:url value="/js/friend.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.fancybox.pack.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/photo.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/album.js" />"></script>

</head>

<body>
	<!--   CONTAINER   -->
	<div id="container">

		<!--   CABEZALHO   -->
		<arquigrafia:header arquigrafiaInstance="${arquigrafiaMgr}" />
		<!--   MEIO DO SITE - ÁREA DE NAVEGAÇ?Ã?O   -->
		<div id="content">
			<!--   COLUNA ESQUERDA   -->
			<div id="sub_content">
				<!--   PAINEL DE VISUALIZACAO - SINGLE   -->
				<div id="single_view_block">
					<!--   NOME / STATUS DA FOTO   -->
					<div id="single_view_header">
						<h1><c:out value="${photo.name}"/></h1>
						<ul id="single_view_image_rating" class="right">
							<li id="graph" ></li>
							<li><small><counter:showCounter
												manager="${counterMgr}" entity="${photo}"
												viewer="${sessionScope.userLogin}" increment="true"
												wrapClass="counter_show" /> e <binomial:count binomialMgr="${binomialMgr}" entity="${photo}"/>
									</small></li>
              <li id="comments"></li>
              <li>
              	<small>
              		<comment:count commentMgr="${commentMgr}" entity="${photo}"/>
								</small>
							</li>
						</ul>
					</div>
					<!--   FIM - NOME / STATUS DA FOTO   -->
					<!--   FOTO   -->
					<%--img src="img/photos/8806.jpg" class="single_view_image" width="600" height="410" alt="" title="" /--%>
					<photo:show clazz="single_view_image"
						 foto="${photo}"
						photoMgr="${photoMgr}" />

					<hr />
				</div>				
				
				<!--   BOX DE BOTOES DA IMAGEM   -->
				<div id="single_view_buttons_box">
					<s:n-check name="X-X-usuario">
				        <h3> <a href="#" id="comment_login_link" > Faça o login para fazer o download e comentar as imagens. </a></h3>
					</s:n-check>
					<s:check name="X-X-usuario">
						<ul id="single_view_image_buttons">
							<!-- <li><a href="#" title="Adicione aos seus favoritos" id="add_favourite"></a></li>
							<li><a href="#" title="Denuncie esta foto" id="denounce"></a></li>-->
						    <c:forEach items="${photo.users}" var="user">
								<s:owner userName="${user.login}">
							    	<li><a href="<c:url value="/photo/${photoMgr.id}/edit/${photo.id}" />" title="Editar informações" id="eyedroppper"></a></li>						
								</s:owner>
							</c:forEach>
							<li><a href="<c:url value="/18/photo_avaliation/${photo.id}" />" title="Avalie a foto" id="eyedroppper"></a></li>
							<li><a href="<c:url value="/album/${albumMgr.id}/add/${photo.id}" />" title="Adicione a sua galeria" id="plus"></a></li>  
							<li><a href="<c:url value="/photo/img-original/${photo.id}" />" title="Faça o download" id="download" target="_blank"></a></li>
							<c:forEach items="${photo.users}" var="user">
								<s:owner userName="${user.login}">
								<li><a href="<c:url value="/photo/delete/${photo.id}" />" title="Remover foto" id="delete"></a></li>
								</s:owner>
							</c:forEach>
						</ul>
						<ul id="single_view_social_network_buttons">
						<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=xa-4fdf62121c50304d"></script>
							<!-- <li><a href="#" class="delicious"></a></li> -->
							<li><a href="#" class="more_sare_buttons addthis_button_compact"><span class="more_sare_buttons">+ outros</span></a></li>
							<li><a href="#" class="google addthis_button_google_plusone_share"><span class="google"></span></a></li>
							<li><a href="#" class="facebook addthis_button_facebook"><span class="facebook"></span></a></li>
							<li><a href="#" class="twitter addthis_button_twitter"><span class="twitter"></span></a></li>
						</ul>
					</s:check>
				</div>
				<!--   FIM - BOX DE BOTOEES DA IMAGEM   -->
				<!--   BOX DE COMENTARIOS   -->
				<div id="comments_block">
					<h2>Comentários</h2>
					<comment:getComments commentMgr="${commentMgr}" entity="${photo}" />
					<comment:addComment commentMgr="${commentMgr}"	uri="/photo/${photo.id}" idObject="${photo.id}" user="${sessionScope.userLogin}" />
				</div>
				<!--   BOX DE COMENTARIOS   -->
			</div>
			<!--   FIM - COLUNA ESQUERDA   -->
			<!--   SIDEBAR   -->
			<div id="sidebar">
				<!--   USUARIO   -->
				<div id="single_user">
				<c:forEach items="${photo.users}" var="user">
					
		        	<c:choose>
						<c:when test="${empty user.photoURL}">
							<img id="single_view_user_thumbnail" src="<c:url value="/img/avatar.jpg" />" />
						</c:when>
						<c:otherwise>
							<img id="single_view_user_thumbnail"  src="<c:url value="${user.photoURL}" />" />
						</c:otherwise>
					</c:choose>
					
					<span id="single_view_owner_name"><a href="<c:url value="/friends/11/show/${user.id}" />" id="name">
						${user.name}
						</a></span>
						<br /> 
						<!-- <s:check name="X-X-usuario"> 
							<a href="<c:url value="/friends/11/sendRequest/${user.id}" />" id="single_view_contact_add">+ Adicionar contato</a><br />
						</s:check>  -->
						<br />
						<s:check name="X-X-usuario">
							<friends:sendRequest friendsMgr="${friendsMgr}" viewer="${userLogin}" viewed="${user}" />
						</s:check> 
				</c:forEach>
				</div>
				<!--   FIM - USUARIO   -->
				<!-- <h3>Equipamento:</h3>
				<p>Lorem ipsum dolor sit amet</p> -->
				<c:if test="${not empty photo.description}">
					<h3>Descrição:</h3>
					<p><c:out value="${photo.description}"/></p>
				</c:if>
				<c:if test="${not empty photo.collection}">
					<h3>Coleção:</h3>
					<p><c:out value="${photo.collection}"/></p>
				</c:if>
				<c:if test="${not empty photo.imageAuthor}">
					<h3>Autor da Imagem:</h3>
					<p>
						<a href="<c:url value="/photos/${photoMgr.id}/show/search/term?q=${util:encode(photo.imageAuthor)}&term=imageAuthor&page=1&perPage=8"/>">
							<c:out value="${photo.imageAuthor}"/>
						</a>
					</p>
					
				</c:if>
				<c:if test="${not empty photo.dataCriacaoFormatada}">
					<h3>Data da Imagem:</h3>
					<p><c:out value="${photo.dataCriacaoFormatada}"/></p>
				</c:if>
						
				<c:if test="${not empty photo.workAuthor}">
					<h3>Autor da Obra:</h3>
					<p>
						<a href="<c:url value="/photos/${photoMgr.id}/show/search/term?q=${util:encode(photo.workAuthor)}&term=workAuthor&page=1&perPage=8"/>">
							<c:out value="${photo.workAuthor}"/>
						</a>
					</p>
				</c:if>
						
				<c:if test="${not empty photo.formattedWorkdate}">
					<h3>Data da Obra:</h3>
					<p><c:out value="${photo.formattedWorkdate}"/></p>
				</c:if>										
				<c:if test="${not empty photo.formattedCataloguingTime}">
					<h3>Data de Catalogação:</h3>
					<p><c:out value="${photo.formattedCataloguingTime}"/></p>
				</c:if>		
				<c:if test="${not empty photo.aditionalImageComments}">
					<h3>Observações:</h3>
					<p><c:out value="${photo.aditionalImageComments}"/></p>
				</c:if>				
				<h3>Endereço:</h3>
					<p>
						<c:if test="${not empty photo.street}">
							<a href="<c:url value="/photos/${photoMgr.id}/show/search/term?q=${util:encode(photo.street)}&term=street&page=1&perPage=8"/>">
								<c:out value="${photo.street}"/>, 
							</a>
						
						</c:if>
						<c:if test="${not empty photo.district}">
							<a href="<c:url value="/photos/${photoMgr.id}/show/search/term?q=${util:encode(photo.district)}&term=district&page=1&perPage=8"/>">
								<c:out value="${photo.district}"/>
							</a>
						
						<br />
						</c:if>
						<c:if test="${not empty photo.city}">
						<a href="<c:url value="/photos/${photoMgr.id}/show/search/term?q=${util:encode(photo.city)}&term=city&page=1&perPage=8"/>">
							<c:out value="${photo.city}"/> - 
						</a>
						
						</c:if>	
						<c:if test="${not empty photo.state}">
							<c:out value="${photo.state}"/> , 
						</c:if>
						<c:if test="${not empty photo.country}">
							<c:out value="${photo.country}"/>
						</c:if> 
					</p>
				<h3>Localização:</h3>
					<div id="map_canvas" class="single_view_map" style="width:300px; height:200px;"></div>
				<s:check name="X-X-usuario">			
			        <h3>Avaliação:</h3>
					<p>Avalie a arquitetura apresentada nesta imagem de acordo com seus aspectos, compare também sua avaliação com as dos outros usuários.</p>
					<a href="<c:url value="/18/photo_avaliation/${photo.id}" />" title="Avalie a foto" id="evaluate_button"></a> 
					<a href="<c:url value="/18/photo_avaliation_avarage/${photo.id}" />" title="Média das avaliações da foto" id="evaluation_average"></a>
					<br />
				</s:check>
				<h3>Tags:</h3>
				<p>
					<tag:getTags tagMgr="${tagMgr}" entity="${photo}" />
				</p>
				<h3>Licença:</h3>
                <p>
					<a href="http://creativecommons.org/licenses/by
							<c:out value="${photo.allowCommercialUses.abrev}"/>
							<c:out value="${photo.allowModifications.abrev}"/>
						/3.0/deed.pt_BR" target="_blank" >
						<img src="<c:url value="/img/ccIcons/by"/>
							<c:out value="${photo.allowCommercialUses.abrev}"/>
							<c:out value="${photo.allowModifications.abrev}"/>
						88x31.png" id="ccicons" alt="license" />
					</a>
				</p>	
			</div>
			<!--   FIM - SIDEBAR   -->
		</div>
		<!--   FUNDO DO SITE   -->
		<div id="footer">
			<!--   BARRA DE ABAS   -->
			<arquigrafia:tabs counterMgr="${counterMgr}" photoMgr="${photoMgr}" commentMgr="${commentMgr}" arquigrafiaInstance="${arquigrafiaMgr}" />
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