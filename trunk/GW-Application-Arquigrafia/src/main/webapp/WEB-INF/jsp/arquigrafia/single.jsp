<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="arquigrafia" uri="http://www.groupwareworkbench.org.br/widgets/arquigrafia" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Arquigrafia - Seu universo de imagens de arquitetura</title>
<!--   FAVICON   -->
<link rel="icon" href="<c:url value="/img/arquigrafia_icon.ico" />" type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value="/img/arquigrafia_icon.ico" />" type="image/x-icon" />
<!--   ESTILO GERAL   -->
<link rel="stylesheet" type="text/css" href="<c:url value="/css/style.css" />" />
<!--[if lt IE 8]>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ie7.css" />" />
<![endif]-->
<link rel="stylesheet" type="text/css" media="print" href="<c:url value="/css/print.css" />"/>

<!--   JQUERY - Google Ajax API CDN (Also supports SSL via HTTPS)   -->
<script type="text/javascript" src="<c:url value="/js/jquery-1.7.1.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery-ui-1.8.17.custom.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/index.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/field_clear.js" />"></script>
</head>

<body>
  <!--   CONTAINER   -->
  <div id="container">
  
  <!--   CABEZALHO   -->
    <div id="header">
	
	  <!--   LOGO   -->
      <a href="index.html" id="logo"></a>
      <!--   MENU SUPERIOR   -->
	  <div id="first_menu">
        <!--   MENU INSTITUCIONAL   -->
        <ul id="top_menu_items">
          <li><a href="#" id="project">O PROJETO</a></li>
          <li><a href="#" id="help">AJUDA</a></li>
          <li><a href="#" id="contact">FALE CONOSCO</a></li>
        </ul>
        <!--   FIM - MENU INSTITUCIONAL   -->
            
        <!--   MENU DE BUSCA   -->
        <form action="" method="get" id="search_buttons_area">
          
          <!--   BARRA DE BUSCA   -->
          <input type="text" class="search_bar" name="search_bar_text" />
          <!--   BOTÃO DA BARRA DE BUSCA   -->
          <input type="submit" class="search_bar_button cursor" value="" name="submit_search_button" />
          <!--   BOTÃO DE BUSCA AVANÃADA   -->
          <a href="#" id="complete_search"></a>
        </form>
        <!--   FIM - MENU DE BUSCA   -->
      </div>
	  <!--   FIM - MENU SUPERIOR   -->
      <!--   ÃREA DE LOGIN / CADASTRO   -->
      <div id="loggin_area" class="right">
        
        <!--   BOTÃO DE LOGIN   -->
        <a href="index_logged.html" name="modal-" id="login_button"></a>
        
        <!--   BOTÃO DE CADASTRO   -->
        <a href="#form_window" name="modal" id="registration_button"></a>
      
      </div>
      <!--   FIM - ÃREA DE LOGIN / CADASTRO   -->
            
    </div>
    <!--   FIM - CABEÃALHO   -->
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
          <img src="img/photos/8806.jpg" class="single_view_image" width="600" height="410" alt="" title="" />
	      <hr />
        </div>
        <!--   BOX DE BOTÃES DA IMAGEM   -->
        <div id="single_view_buttons_box">
          <ul id="single_view_image_buttons">
            <li><a href="#" title="Adicione aos seus favoritos" id="add_favourite"></a></li>
            <li><a href="#" title="Adicione ao seu album" id="plus"></a></li>
            <li><a href="#" title="Avalie a foto" id="eyedroppper"></a></li>
            <li><a href="#" title="Denuncie esta foto" id="denounce"></a></li>
            <li><a href="#" title="FaÃ§a o download" id="download"></a></li>
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
            <img src="img/avatar.jpg" width="50" height="50" name="Homer" class="user_thumbnail" />
            <a href="#" id="name">Homer Simpson</a>&nbsp;<span class="comment_time">(3 dias atrÃ¡s)</span>
            <span class="comment_text">
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla laoreet purus et neque sagittis et pretium turpis euismod. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>
            </span>
          </div>
          <div class="single_comment_block">
            <img src="img/avatar.jpg" name="Homer" class="user_thumbnail"  />
            <a href="#" id="name">Homer Simpson</a>&nbsp;<span class="comment_time">(4 dias atrÃ¡s)</span>
            <span class="comment_text">
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </span>
          </div>
        <!--   BOX DE COMENTÃRIO   -->
		<div class="single_comment_block">
          <form id="space_to_comment" method="post" action="#">
            <img src="img/avatar.jpg" name="Homer" class="user_thumbnail"  />
            <a href="#" id="name">Homer Simpson</a><br />
            <textarea type="text" id="comment_field" onclick="clickclear(this, 'default text')" onblur="clickrecall(this,'default text')">Escreva o seu comentÃ¡rio aqui...</textarea>
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
	     <img src="img/avatar.jpg" name="Homer" id="single_view_user_thumbnail" />
		 <span id="single_view_owner_name">Por: <a href="#" id="name">Homer Simpson</a></span><br />
		 <a href="#" id="single_view_contact_add">+ Adicionar contato</a><br />
		</div>
        <!--   FIM - USUÃRIO   -->
        <h3>Equipamento:</h3>
        <p>Lorem ipsum dolor sit amet</p>
        <h3>DescriÃ§Ã£o:</h3>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla laoreet purus et neque sagittis et pretium turpis euismod. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Curabitur blandit mollis eros, a dictum mauris laoreet in. Curabitur ultricies aliquet ante, ac iaculis orci consectetur vel. In eu ipsum metus. Pellentesque accumsan nisl nec eros cursus vehicula.</p>
        <h3>LocalizaÃ§Ã£o:</h3>
		<p>
			<iframe width="300" height="100" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com.br/maps?f=q&amp;source=s_q&amp;hl=pt-BR&amp;geocode=&amp;q=sp&amp;aq=&amp;sll=-18.124971,-45.878906&amp;sspn=11.093912,19.621582&amp;ie=UTF8&amp;hq=&amp;hnear=S%C3%A3o+Paulo&amp;t=m&amp;ll=-21.912471,-49.361572&amp;spn=1.019251,3.284912&amp;z=7&amp;iwloc=A&amp;output=embed"></iframe>
			<a href="http://maps.google.com.br/maps?f=q&amp;source=embed&amp;hl=pt-BR&amp;geocode=&amp;q=sp&amp;aq=&amp;sll=-18.124971,-45.878906&amp;sspn=11.093912,19.621582&amp;ie=UTF8&amp;hq=&amp;hnear=S%C3%A3o+Paulo&amp;t=m&amp;ll=-21.912471,-49.361572&amp;spn=1.019251,3.284912&amp;z=7&amp;iwloc=A" style="text-align:center; display:block; width:auto; font-size:10px;">Exibir mapa ampliado</a>
		</p>
        <h3>Tags:</h3>
        <p>Lorem ipsum dolor sit amet</p>
        <h3>LicenÃ§a:</h3>
        <p>Lorem ipsum dolor sit amet</p>
        <h3>AvaliaÃ§Ã£o:</h3>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla laoreet purus et neque sagittis et pretium turpis euismod. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>
        <a href="#" title="Avalie a foto" id="evaluate_button"></a>
        <a href="#" title="MÃ©dia das avaliaÃ§Ãµes da foto" id="evaluation_average"></a>
      </div>
      <!--   FIM - SIDEBAR   -->
    </div>
    <!--   FUNDO DO SITE   -->
    <div id="footer">
	  <!--   BARRA DE ABAS   -->
	  <ul class="tabs">
        <!--   ABAS   -->
        <li class="selected_tab">
	      <a href="#" class="selected_tab_link">NOVAS IMAGENS</a>
		</li>
		<li class="tab_not_selected">
		  <a href="#" class="tab_link">POPULARES</a>
		</li>
		<li class="tab_not_selected">
		  <a href="#" class="tab_link">CONTROVERSAS</a>
		</li>
		<li class="tab_not_selected">
		  <a href="#" class="tab_link">AVALIADAS</a>
		</li>
		<li class="tab_not_selected">
		  <a href="#" class="tab_link">COMENTADAS</a>
		</li>
      </ul>
	  <!--   BARRA DE IMAGENS - (RODAPÃ)   -->
	  <div class="footer_images">
	    <!--   LINHA DE IMAGENS - (RODAPÃ)   -->
		<div class="images_line">  
		  <!--   SETAS DE NAVEGAÃÃO DAS FOTOS (RODAPÃ)-->
		  <a href="#" id="arrow-left" class="arrows">&laquo;</a>
		  <a href="#" id="arrow-right" class="arrows">&raquo;</a>
		  <!--   IMAGENS - (RODAPÃ)   -->
		  <a href="#" id="f_01" class="footer_image"><img src="img/photos/52926.jpg" width="105" height="72" alt="Foto 1"/></a>
		  <a href="#" id="f_02" class="footer_image"><img src="img/photos/45044.jpg" width="105" height="72" alt="Foto 2"/></a>
		  <a href="#" id="f_03" class="footer_image"><img src="img/photos/69363.jpg" width="105" height="72" alt="Foto 3"/></a>
		  <a href="#" id="f_04" class="footer_image"><img src="img/photos/74618.jpg" width="105" height="72" alt="Foto 4"/></a>
		  <a href="#" id="f_05" class="footer_image"><img src="img/photos/56665.jpg" width="105" height="72" alt="Foto 5"/></a>
		  <a href="#" id="f_06" class="footer_image"><img src="img/photos/8806.jpg" width="105" height="72" alt="Foto 6"/></a>
		  <a href="#" id="f_07" class="footer_image"><img src="img/photos/80213.jpg" width="105" height="72" alt="Foto 7"/></a>
		  <a href="#" id="f_08" class="footer_image"><img src="img/photos/16777.jpg" width="105" height="72" alt="Foto 8"/></a>		
	    </div>
        <!--   FIM - LINHA DE IMAGENS - (RODAPÃ)   -->
	  </div>
	  <!--   FIM - BARRA DE IMAGENS - (RODAPÃ)   -->
	  <!--   CRÃDITOS - LOGOS   -->
	  <div id="credits">
        <!--   LOGOS   -->
		<ul>
          <li><a href="#" title="USP" id="usp"></a></li>
		  <li><a href="#" title="FAPESP" id="fapesp"></a></li>
		  <li><a href="#" title="" id="rnp"></a></li>
		  <li><a href="#" title="" id="cnpq"></a></li>
		  <li><a href="#" title="" id="fau"></a></li>
		  <li><a href="#" title="" id="ime"></a></li>
		  <li><a href="#" title="" id="eca"></a></li>
		  <li><a href="#" title="" id="ccsl"></a></li>
		  <li><a href="#" title="" id="vitruvius"></a></li>
		  <li><a href="#" title="" id="benchmark"></a></li>
		  <li><a href="#" title="" id="brz"></a></li>	
        </ul>
		<!--   COPYRIGHT   -->
	    <p id="copyright"><small>Arquigrafia - 20011 Â© All rights reserved</small></p>
	  </div>
      <!--   FIM - CRÃDITOS - LOGOS   -->
    </div>
    <!--   FIM - FUNDO DO SITE   -->
    <!--   MODAL   -->
    <div id="mask"></div>
    <div id="form_window"> 
      <!-- ÃREA DE LOGIN - JANELA MODAL --> 
      <a class="close" href="#" title="FECHAR"></a>
      <form id="registration" name="registration" action="">
      </form>
    </div>
    <!--   FIM - MODAL   -->
  </div>
  <!--   FIM - CONTAINER   -->
</body>
</html>
