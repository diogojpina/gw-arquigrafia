<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="arquigrafia" uri="http://www.groupwareworkbench.org.br/widgets/arquigrafia"%>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager"%>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag"%>
<%@ taglib prefix="comment" uri="http://www.groupwareworkbench.org.br/widgets/comment"%>
<%@ taglib prefix="counter" uri="http://www.groupwareworkbench.org.br/widgets/counter" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Arquigrafia - Seu universo de imagens de arquitetura</title>
<arquigrafia:includes arquigrafiaInstance="${arquigrafiaMgr}" />
</head>

<body>
	<!--   CONTAINER   -->
	<div id="container">

		<!--   CABEZALHO   -->
		<arquigrafia:header arquigrafiaInstance="${arquigrafiaMgr}" />
		<!--   MEIO DO SITE - ÃREA DE NAVEGAÃÃO   -->
		<div id="content">
			<!--   COLUNA ESQUERDA   -->
			<div id="sub_content">
				<!--   PAINEL DE VISUALIZACAO - SINGLE   -->
				<div id="single_view_block">
					<!--   NOME / STATUS DA FOTO   -->
					<div id="single_view_header">
						<h1><c:out value="${photo.name}"/>    	</h1>
						<ul id="single_view_image_rating" class="right">
							<li id="graph"></li>
							<li><small><counter:showCounter
												manager="${counterMgr}" entity="${photo}"
												viewer="${sessionScope.userLogin}" increment="true"
												wrapClass="counter_show" />
									</small></li>
						</ul>
					</div>
					<!--   FIM - NOME / STATUS DA FOTO   -->
					<!--   FOTO   -->
					<%--img src="img/photos/8806.jpg" class="single_view_image" width="600" height="410" alt="" title="" /--%>
					<photo:show clazz="single_view_image"
						style="width: 600px; height:410px" foto="${photo}"
						photoInstance="${photoInstance}" />

					<hr />
				</div>
				<!--   BOX DE BOTOES DA IMAGEM   -->
				<div id="single_view_buttons_box">
					<ul id="single_view_image_buttons">
						<!-- <li><a href="#" title="Adicione aos seus favoritos" id="add_favourite"></a></li>
						<li><a href="#" title="Denuncie esta foto" id="denounce"></a></li>
						<li><a href="#" title="Adicione ao seu album" id="plus"></a></li>  
						<li><a href="<c:url value="/18/photo_avaliation/${photo.id}" />" title="Avalie a foto" id="eyedroppper"></a></li>-->
						<li><a href="<c:url value="/photo/img-original/${photo.id}" />" title="Faça o download" id="download" target="_blank"></a></li>
					</ul>
					<ul id="single_view_social_network_buttons">
						<li><a href="#" class="delicious"></a></li>
						<li><a href="#" class="google"></a></li>
						<li><a href="#" class="facebook"></a></li>
						<li><a href="#" class="twitter"></a></li>
					</ul>
				</div>
				<!--   FIM - BOX DE BOTOEES DA IMAGEM   -->
				<!--   BOX DE COMENTARIOS   -->
				<div id="comments_block">
					<h2>Comentários</h2>
					<comment:getComments commentMgr="${commentMgr}" entity="${photo}" />
					<comment:addComment commentMgr="${commentMgr}"	idObject="${photo.id}" user="${sessionScope.userLogin}" />
				</div>
				<!--   BOX DE COMENTARIOS   -->
			</div>
			<!--   FIM - COLUNA ESQUERDA   -->
			<!--   SIDEBAR   -->
			<div id="sidebar">
				<!--   USUARIO   -->
				<div id="single_user">
				<c:forEach items="${photo.users}" var="user">
					<img src="<c:url value="/img/avatar.jpg" />" name="Homer"
						id="single_view_user_thumbnail" /> <span
						id="single_view_owner_name">Por: <a href="<c:url value="/groupware-workbench/friends/11/show/${user.id}" />" id="name">
						${user.name}
						</a></span>
						<br /> 
						<!-- <s:check name="X-X-usuario"> 
							<a href="<c:url value="/groupware-workbench/friends/11/sendRequest/${user.id}" />" id="single_view_contact_add">+ Adicionar contato</a><br />
						</s:check>  -->
				</c:forEach>
				</div>
				<!--   FIM - USUARIO   -->
				<!-- <h3>Equipamento:</h3>
				<p>Lorem ipsum dolor sit amet</p> -->
				<h3>Descrição:</h3>
				<p><c:out value="${photo.description}"/></p>
				<h3>Localização:</h3>
				<p>
					<iframe width="300" height="100" frameborder="0" scrolling="no"
						marginheight="0" marginwidth="0"
						src="http://maps.google.com.br/maps?f=q&amp;source=s_q&amp;hl=pt-BR&amp;geocode=&amp;q=sp&amp;aq=&amp;sll=-18.124971,-45.878906&amp;sspn=11.093912,19.621582&amp;ie=UTF8&amp;hq=&amp;hnear=S%C3%A3o+Paulo&amp;t=m&amp;ll=-21.912471,-49.361572&amp;spn=1.019251,3.284912&amp;z=7&amp;iwloc=A&amp;output=embed"></iframe>
					<a
						href="http://maps.google.com.br/maps?f=q&amp;source=embed&amp;hl=pt-BR&amp;geocode=&amp;q=sp&amp;aq=&amp;sll=-18.124971,-45.878906&amp;sspn=11.093912,19.621582&amp;ie=UTF8&amp;hq=&amp;hnear=S%C3%A3o+Paulo&amp;t=m&amp;ll=-21.912471,-49.361572&amp;spn=1.019251,3.284912&amp;z=7&amp;iwloc=A"
						style="text-align: center; display: block; width: auto; font-size: 10px;">Exibir
						mapa ampliado</a>
				</p>
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
				<!-- <h3>Avaliação:</h3>
				<p>Avalie esta imagem de acordo com seus aspectos, compare também sua avaliação com as do outros usuários.</p>
				<a
					href="<c:url value="/18/photo_avaliation/${photo.id}" />"
					title="Avalie a foto" id="evaluate_button"></a> <a href="#"
					title="MÃ©dia das avaliaÃ§Ãµes da foto" id="evaluation_average"></a> -->
			</div>
			<!--   FIM - SIDEBAR   -->
		</div>
		<!--   FUNDO DO SITE   -->
		<div id="footer">
			<!--   BARRA DE ABAS   -->
			<arquigrafia:tabs arquigrafiaInstance="${arquigrafiaMgr}" />
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
