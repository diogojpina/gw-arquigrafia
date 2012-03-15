<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="arquigrafia" uri="http://www.groupwareworkbench.org.br/widgets/arquigrafia" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>

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
        <!--   PAINEL DE VISUALIZAÃÃO - SINGLE   -->
        <div id="single_view_block">
          <!--   NOME / STATUS DA FOTO   -->
          <div id="single_view_header">
          <h1>Imagem de teste</h1>
            <ul id="single_view_image_rating" class="right">
              <li id="graph"></li>
              <li><small>312</small></li>
              <li id="comments"></li>
              <li><small>345</small></li>
              <li id="favourite"></li>
              <li><small>176</small></li>
            </ul>
          </div>
          <!--   FIM - NOME / STATUS DA FOTO   -->
          <!--   FOTO   -->
          <%--img src="img/photos/8806.jpg" class="single_view_image" width="600" height="410" alt="" title="" /--%>
          <photo:show clazz="single_view_image" style="width: 600px; height:410px"  foto="${photo}" photoInstance="${photoInstance}"/>
          
	      <hr />
        </div>
        <!--   BOX DE BOTÃES DA IMAGEM   -->
        <div id="single_view_buttons_box">
          <ul id="single_view_image_buttons">
            <li><a href="#" title="Adicione aos seus favoritos" id="add_favourite"></a></li>
            <li><a href="#" title="Adicione ao seu album" id="plus"></a></li>
            <li><a href="#" title="Avalie a foto" id="eyedroppper"></a></li>
            <li><a href="#" title="Denuncie esta foto" id="denounce"></a></li>
            <li><a href="<c:url value="/photo/img-original/${photo.id}" />" title="Faça o download" id="download" target="_blank"></a></li>
          </ul>
          <ul id="single_view_social_network_buttons">
            <li><a href="#" class="delicious"></a></li>
            <li><a href="#" class="google"></a></li>
            <li><a href="#" class="facebook"></a></li>
            <li><a href="#" class="twitter"></a></li>
          </ul>
        </div>
        <!--   FIM - BOX DE BOTÃES DA IMAGEM   -->
        <!--   BOX DE COMENTÃRIOS   -->
        <div id="comments_block">
          <h2>ComentÃ¡rios</h2>
          <div class="single_comment_block">
            <img src="<c:url value="/img/avatar.jpg" />" width="50" height="50" name="Homer" class="user_thumbnail" />
            <a href="#" id="name">Homer Simpson</a>&nbsp;<span class="comment_time">(3 dias atráis)</span>
            <span class="comment_text">
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla laoreet purus et neque sagittis et pretium turpis euismod. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>
            </span>
          </div>
          <div class="single_comment_block">
            <img src="<c:url value="/img/avatar.jpg" />" name="Homer" class="user_thumbnail"  />
            <a href="#" id="name">Homer Simpson</a>&nbsp;<span class="comment_time">(4 dias atrÃ¡s)</span>
            <span class="comment_text">
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </span>
          </div>
        <!--   BOX DE COMENTÃRIO   -->
		<div class="single_comment_block">
          <form id="space_to_comment" method="post" action="#">
            <img src="<c:url value="/img/avatar.jpg" />" name="Homer" class="user_thumbnail"  />
            <a href="#" id="name">${sessionScope.userLogin.name}</a><br />
            <textarea type="text" id="comment_field" onclick="clickclear(this, 'default text')" onblur="clickrecall(this,'default text')">Escreva o seu comentário aqui...</textarea>
            <input type="submit" id="comment_button" class="cursor" value="" />
          </form>
		</div>
        <!--   FIM - BOX DE COMENTÃRIO   -->
      </div>
      <!--   BOX DE COMENTÃRIOS   -->
	 </div>
     <!--   FIM - COLUNA ESQUERDA   -->
	 <!--   SIDEBAR   -->
     <div id="sidebar">
       <!--   USUÃRIO   -->
	   <div id="single_user">
	     <img src="<c:url value="/img/avatar.jpg" />" name="Homer" id="single_view_user_thumbnail" />
		 <span id="single_view_owner_name">Por: <a href="#" id="name">Homer Simpson</a></span><br />
		 <a href="#" id="single_view_contact_add">+ Adicionar contato</a><br />
		</div>
        <!--   FIM - USUÃRIO   -->
        <h3>Equipamento:</h3>
        <p>Lorem ipsum dolor sit amet</p>
        <h3>Descrição:</h3>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla laoreet purus et neque sagittis et pretium turpis euismod. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Curabitur blandit mollis eros, a dictum mauris laoreet in. Curabitur ultricies aliquet ante, ac iaculis orci consectetur vel. In eu ipsum metus. Pellentesque accumsan nisl nec eros cursus vehicula.</p>
        <h3>Localização:</h3>
		<p>
			<iframe width="300" height="100" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com.br/maps?f=q&amp;source=s_q&amp;hl=pt-BR&amp;geocode=&amp;q=sp&amp;aq=&amp;sll=-18.124971,-45.878906&amp;sspn=11.093912,19.621582&amp;ie=UTF8&amp;hq=&amp;hnear=S%C3%A3o+Paulo&amp;t=m&amp;ll=-21.912471,-49.361572&amp;spn=1.019251,3.284912&amp;z=7&amp;iwloc=A&amp;output=embed"></iframe>
			<a href="http://maps.google.com.br/maps?f=q&amp;source=embed&amp;hl=pt-BR&amp;geocode=&amp;q=sp&amp;aq=&amp;sll=-18.124971,-45.878906&amp;sspn=11.093912,19.621582&amp;ie=UTF8&amp;hq=&amp;hnear=S%C3%A3o+Paulo&amp;t=m&amp;ll=-21.912471,-49.361572&amp;spn=1.019251,3.284912&amp;z=7&amp;iwloc=A" style="text-align:center; display:block; width:auto; font-size:10px;">Exibir mapa ampliado</a>
		</p>
        <h3>Tags:</h3>
        <p>Lorem ipsum dolor sit amet</p>
        <h3>Licença:</h3>
        <p>Lorem ipsum dolor sit amet</p>
        <h3>Avaliação: ${arquigrafiaMgr.id} que coisa ${photo.id}</h3>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla laoreet purus et neque sagittis et pretium turpis euismod. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>
        <a href="<c:url value="/${arquigrafiaMgr.id}/photo_avaliation/${photo.id}" />" title="Avalie a foto" id="evaluate_button" ></a>
        <a href="#" title="MÃ©dia das avaliaÃ§Ãµes da foto" id="evaluation_average"></a>
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
      <div id="registration">
      </div>
    </div>
    <!--   FIM - MODAL   -->
  </div>
  <!--   FIM - CONTAINER   -->
</body>
</html>
