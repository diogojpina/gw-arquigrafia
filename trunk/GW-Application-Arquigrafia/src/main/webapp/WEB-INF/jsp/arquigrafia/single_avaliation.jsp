<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="arquigrafia" uri="http://www.groupwareworkbench.org.br/widgets/arquigrafia" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="binomial" uri="http://www.groupwareworkbench.org.br/widgets/binomial" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Arquigrafia - Seu universo de imagens de arquitetura</title>
<!--   FAVICON   -->
<link rel="icon" href="<c:url value="/img/arquigrafia_icon.ico" />" type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value="/img/arquigrafia_icon.ico" />" type="image/x-icon" />
<!--   ESTILO GERAL   -->
<link rel="stylesheet" type="text/css" href="<c:url value="/css/style.css" />"/>
<!--[if lt IE 8]>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/ie7.css" />" />
<![endif]-->
<link rel="stylesheet" type="text/css" media="print" href="<c:url value="/css/print.css" />" />




<!--   JQUERY - Google Ajax API CDN (Also supports SSL via HTTPS)   -->
<script type="text/javascript" src="<c:url value="/js/jquery-1.7.1.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery-ui-1.8.17.custom.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/index.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/field_clear.js" />"></script>
<style type="text/css">
.binWrapClass {
	float: left;
	padding: 3px 6px 3px 6px;
	margin: 0px 0px 10px 0px;
	/*background-color: #fff;*/
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
}
.binLabelClass, .binValueClass {
	float: left;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
}
.binLabelClass {
	color: #8594AF;
	padding-right: 5px;
}
.binValueClass {
	color: #8594AF;
	padding-right: 15px;
}
#binomialsTitle {
	float: left;
	position: relative;
	left: 0px;
	padding: 0px 5px 0px 5px;
	margin: 9px 0px 12px 0px;
}
#binLink {
	float: left;
	cursor: pointer;
	margin-top: 8px;
}
#binomialsWrap {
	float: right;
	padding-right: 0px;
	width: 100%;
	overflow: scroll;
	overflow-x: hidden;
	overflow-y: auto;
}
#binomialSubmit {
	clear: both;
}
#binomialSubmit input {
    width: 60px;
    height: 28px;
    background: url("../images/save_bt1.png") no-repeat scroll;
    cursor: pointer;
    border: 0;
    font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-weight: bold;
	color: #fff;
}

</style>
<binomial:scriptBinomial />
</head>

<body>
  <!--   CONTAINER   -->
  <div id="container">
  
  <!--   CABEÃALHO   -->
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
          
          
          <!-- img src="img/photos/8806.jpg" class="single_view_image" width="600" height="410" /-->
          <photo:show clazz="single_view_image" style="width: 600px; height:410px"  foto="${photo}" photoInstance="${photoInstance}"/>
          
          
          <hr />
        </div>
		<!--   BOX DE AVALIAÃÃO   -->
		<div id="avaliation_box">
	      <p>Avalie a foto segundo os atributos abaixo e após finalizar, clique no botÃ£o Avaliar ao lado para contabilizar a sua avaliação e visualizar a mídia entre as outras avaliaçoes.</p>
          <!--   FORMULÃRIO DE AVALIAÃÃO   -->
          <form action="#" method="get" id="avaliation_form">
          <%--
            <input type="reset" id="clean" class="cursor" value="" />
            <input type="submit" id="avaliate" class="cursor" value="" />

        	<!--   PAINEL DE AVALIAÃÃO   -->
			<ul id="avaliation_list">
				<li>
					<span class="left">Interno</span>
						<div id="slider_1"></div>
					<span class="right">Externo</span>
				</li>
				<li>
					<span class="left">Distante</span>
						<div id="slider_2"></div>
					<span class="right">PrÃ³ximo</span>
				</li>
				<li>
					<span class="left">Vertical</span>
						<div id="slider_3"></div>
					<span class="right">Horizontal</span>
				</li>
				<li>
					<span class="left">Opaco</span>
						<div id="slider_4"></div>
					<span class="right">Transparente</span>
				</li>
				<li>
					<span class="left">Claro</span>
						<div id="slider_5"></div>
					<span class="right">Escuro</span>
				</li>
				<li>
					<span class="left">Aberto</span>
						<div id="slider_6"></div>
					<span class="right">Fechado</span>
				</li>
			</ul>
			--%>

			<div id="binomialsUser">
                <binomial:userAverage entity="${photo}" manager="${binomialMgr}" user="${sessionScope.userLogin}" name="userBin"
                        labelClass="binLabelClass" valueClass="binValueClass" wrapClass="binWrapClass" />
                <div id="binomialSubmit">
                    <input type="submit" name="saveBinomial" value="Salvar" />
                </div>
            </div>
         </form>
         <!--   FIM - FORMULÃRIO DE AVALIAÃÃO   -->
			
		 <!--   SCRIPT DO SLIDER DE AVALIAÃÃO   -->
	     <%--
	     <script>
			$("#slider_1").slider({ value:50, min: 0, max: 100, step: 10 });
			$("#slider_2").slider({ value:50, min: 0, max: 100, step: 10 });
			$("#slider_3").slider({ value:50, min: 0, max: 100, step: 10 });
			$("#slider_4").slider({ value:50, min: 0, max: 100, step: 10 });
			$("#slider_5").slider({ value:50, min: 0, max: 100, step: 10 });
			$("#slider_6").slider({ value:50, min: 0, max: 100, step: 10 });
		 </script>
		 --%>
	   </div>
       <!--   FIM - BOX DE AVALIAÃÃO   -->
      </div>
      <!--   FIM - COLUNA ESQUERDA   -->
      <!--   COLUNA LATERAL - DIREITA   -->
      <div id="sidebar">
        <h2 class="common_title">Avaliação de binômios</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla laoreet purus et neque sagittis et pretium turpis euismod. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Curabitur blandit mollis eros, a dictum mauris laoreet in. Curabitur ultricies aliquet ante, ac iaculis orci consectetur vel. In eu ipsum metus. Pellentesque accumsan nisl nec eros cursus vehicula.</p>
        <h3>Posso avaliar mais que uma vez?</h3><br />
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla laoreet purus et neque sagittis et pretium turpis euismod.</p>
        <h3>Como faÃ§o para avaliar?</h3>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla laoreet purus et neque sagittis et pretium turpis euismod. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>
        <p>Nós te preparamos um vídeo que mostra o passo a passo da avaliação. Clique no botão abaixo para assistí­-lo:</p>
        <a href="#" id="watch_button"></a>
      </div>
      <!--   FIM - COLUNA LATERAL - DIREITA   -->
    </div>
    <!--   FIM - MEIO DO SITE   -->
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
