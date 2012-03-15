<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="album" uri="http://www.groupwareworkbench.org.br/widgets/album" %>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="comment" uri="http://www.groupwareworkbench.org.br/widgets/comment" %>
<%@ taglib prefix="friends" uri="http://www.groupwareworkbench.org.br/widgets/friends" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="profile" uri="http://www.groupwareworkbench.org.br/widgets/profile" %>
<%@ taglib prefix="role" uri="http://www.groupwareworkbench.org.br/widgets/role" %>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag" %>

<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Arquigrafia - Seu universo de imagens de arquitetura</title>
	<!--   FAVICON   -->
	<link rel="icon" href="img/arquigrafia_icon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="img/arquigrafia_icon.ico" type="image/x-icon" />
	<!--   ESTILO GERAL   -->
	<link rel="stylesheet" type="text/css" href="<c:url value="/css/style.css" />"/>
	<!--[if lt IE 8]>
	<link rel="stylesheet" type="text/css" href="css/ie7.css" />
	<![endif]-->
	<!--   JQUERY - Google Ajax API CDN (Also supports SSL via HTTPS)   -->
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js"></script>
	<script type="text/javascript" src="js/index.js"></script>

</head>

<body>
  <!--   CONTAINER   -->
	<div id="container">
  
  <!--   CABEÇALHO   -->
	<div id="header">
	  	<!--   LOGO   -->
		<a href="index.html" id="logo"></a>
	  	<div id="first_menu">
	      	<!--   MENU INSTITUCIONAL   -->
    		<ul id="top_menu_items">
          		<li><a href="#" id="project">O PROJETO</a></li>
          		<li><a href="#" id="help">AJUDA</a></li>
          		<li><a href="#" id="contact">FALE CONOSCO</a></li>
      		</ul>
      
      		<!--<div id="arrow_sidebar_left" class="arrow_sidebar_left"></div>-->
      
      		<!--   MENU DE BUSCA   -->
      
        	<!--   ÁREA DOS BOTÕES DE BUSCA   -->
        	<form action="" method="get" id="search_buttons_area">
          
          	<!--   BARRA DE BUSCA   -->
          		<input type="text" class="search_bar" name="search_bar_text" />
          		<!--   BOTÃO DA BARRA DE BUSCA   -->
          		<input type="submit" class="search_bar_button" value="" name="submit_search_button" />
          
          		<a href="#" id="complete_search"></a>
        	</form>
		</div>
	  
		<!--   ÁREA DE LOGIN / CADASTRO   -->
		<div id="loggin_area">
        
			<!--   BOTÃO DE LOGIN   -->
        	<a href="index_logged.html" name="modal-" id="login_button"></a>
        
        	<!--   BOTÃO DE CADASTRO   -->
        	<a href="#form_window" name="modal" id="registration_button"></a>
      
      	</div>
      	<!--   SETA DA DIREITA   -->
      
      	<!--
      		<div id="arrow_sidebar_right" class="arrow_sidebar_right"></div>
      	-->
      
	</div>
	<!--   MEIO DO SITE - ÁREA DE NAVEGAÇÃO   -->
	<div id="content">
		<!--   BARRA LATERAL - ESQUERDA   -->
		<div id="left_sidebar">
                
			<c:choose>
				<c:when test="${empty userLogin.photoURL}">
					<img name="Homer" id="profile_photo" src="<c:url value="/img/avatar.jpg" />" />
				</c:when>
				<c:otherwise>
					<img name="Homer" id="profile_photo" src="${userLogin.photoURL}" />
				</c:otherwise>
			</c:choose>
        
			<a href="#" id="small">Trocar fotografia</a>
				<friends:friendsRequests style="width: 475px;"
                       user="${userLogin}"
                       friendsMgr="${friendsMgr}"
                       afterRejectFunction="refreshFriendsPage"
                       afterAcceptFunction="refreshFriendsPage"
                       friendsHeader="friends_header" />
        	<!--   EVENTOS   -->
        	<h3>Eventos</h3>
        	<!--   BOX - EVENTOS   -->
        	<div id="invitation">
          		<p>Nenhum evento no momento.</p>
        	</div>
        	<!--   ENVIAR CONVITE   -->
        	<h3>Convites</h3>
        	<p>Envie um e-mail para seus amigos e convide-os para participarem do Arquigrafia.</p>
        	<input type="email" id="invite_email" name="invite_email" value="exemplo@email.com.br" />
        	<br />
        	<a href="#" id="right_alignment">Enviar</a>
		</div>
		<!--   CONTEÚDO   -->
		<div id="middle_content">
		<form id="form1" class="cmxform" name="dados" method="POST" action="<c:url value="/groupware-workbench/users/${userMgr.id}/saveWithUrl" />" accept-charset="UTF-8" autocomplete="off">
            <input type="hidden" name="user.id" value="<c:out value="${user.id}" />" />
            <input type="hidden" id="url" name="url" value="${url}" />
            <div>
            <h3>Dados do usuário</h3>
            	<ul>
          			<li><strong>LOGIN:&nbsp;</strong>
          				<input type="text" class="required" name="user.login" value="<c:out value="${user.login}" />" style="width:194px; height:16px; color:#7B7D7F; background:transparent; border:solid 1px #7B7D7F; font-size:11px; line-height:20px; padding:2px; margin:5px 0 0 0;" /></li>
          			<li><strong>PASSWORD:&nbsp;</strong>
          				<input type="password" class="required" name="user.password" value="<c:out value="${user.password}" />" id="password" style="width:194px; height:16px; color:#7B7D7F; background:transparent; border:solid 1px #7B7D7F; font-size:11px; line-height:20px; padding:2px; margin:5px 0 0 0;" /></li>
          			<li><strong>E-MAIL:&nbsp;</strong>
          				<input type="text" class="required email" name="user.email" value="<c:out value="${user.email}" />" id="email" style="width:194px; height:16px; color:#7B7D7F; background:transparent; border:solid 1px #7B7D7F; font-size:11px; line-height:20px; padding:2px; margin:5px 0 0 0;" /></li>
          			<li><strong>NOME:&nbsp;</strong>
          				<input type="text" class="required" name="user.name" value="<c:out value="${user.name}" />"  id="name" style="width:194px; height:16px; color:#7B7D7F; background:transparent; border:solid 1px #7B7D7F; font-size:11px; line-height:20px; padding:2px; margin:5px 0 0 0;" /></li>
          			<li><strong>ENDEREÇO DA SUA FOTO:&nbsp;</strong>
          				<input type="text" name="user.photoURL" value="<c:out value="${user.photoURL}" />"  id="photoURL" style="width:194px; height:16px; color:#7B7D7F; background:transparent; border:solid 1px #7B7D7F; font-size:11px; line-height:20px; padding:2px; margin:5px 0 0 0;" /></li>
        		</ul>
			</div>
            <c:if test="${profileMgr.collablet.enabled}">
                <profile:edit_profile profileMgr="${profileMgr}" user="${user}" />
            </c:if>
            <div>
               <input type="submit" value="Salvar" />
            </div>
	        <div class="voltar" align="center">
	        	<button onclick="javascript:history.back(1);">Voltar</button>
	        </div>
        </form>
		</div>
        <div id="edit_user"> 
      	<!-- ÁREA DE LOGIN - JANELA MODAL --> 
      		<a class="close" href="#" title="FECHAR"></a>
      		<form id="registration" name="registration" action="">
      		</form>
    	</div>
      
		<!--   BARRA LATERAL - DIREITA   -->
		<div id="right_sidebar">
        
	        <friends:listFriends
	            user="${userLogin}"
	            friendsMgr="${friendsMgr}" friendsHeader="friends_header"
	            style="width: 400px;" />
	            
	        <h2 id="profile_block_title">Comunidades</h2>
	        <a href="#" id="small" class="profile_block_link">Ver todas</a>
			<div id="profile_box">
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
	        
 			<album:listGalery albumMgr="${albumMgr}" user="${user}"/>

		</div>
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
		<!--   BARRA DE IMAGENS - (RODAPÉ)   -->
		<div class="footer_images">
	    	<!--   LINHA DE IMAGENS - (RODAPÉ)   -->
			<div class="images_line">  
		  		<!--   SETAS DE NAVEGAÇÃO DAS FOTOS (RODAPÉ)-->
		  		<a href="#" id="arrow-left" class="arrows">&laquo;</a>
		  		<a href="#" id="arrow-right" class="arrows">&raquo;</a>
		  		<!--   IMAGENS - (RODAPÉ)   -->
		  		<a href="#" id="f_01" class="footer_image"><img src="img/photos/52926.jpg" width="105" height="72" alt="Foto 1"/></a>
		  		<a href="#" id="f_02" class="footer_image"><img src="img/photos/45044.jpg" width="105" height="72" alt="Foto 2"/></a>
		  		<a href="#" id="f_03" class="footer_image"><img src="img/photos/69363.jpg" width="105" height="72" alt="Foto 3"/></a>
		  		<a href="#" id="f_04" class="footer_image"><img src="img/photos/74618.jpg" width="105" height="72" alt="Foto 4"/></a>
		  		<a href="#" id="f_05" class="footer_image"><img src="img/photos/56665.jpg" width="105" height="72" alt="Foto 5"/></a>
		  		<a href="#" id="f_06" class="footer_image"><img src="img/photos/8806.jpg" width="105" height="72" alt="Foto 6"/></a>
		  		<a href="#" id="f_07" class="footer_image"><img src="img/photos/80213.jpg" width="105" height="72" alt="Foto 7"/></a>
		  		<a href="#" id="f_08" class="footer_image"><img src="img/photos/16777.jpg" width="105" height="72" alt="Foto 8"/></a>		  
	    	</div>
	  	</div>
	  	<!--   CRÉDITOS - LOGOS   -->
	  	<div id="credits">
			<ul>
          		<li><a href="#" title="" id="usp"></a></li>
		  		<li><a href="#" title="" id="fapesp"></a></li>
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
	    	<p id="copyright"><small>Arquigrafia - 20011 © All rights reserved</small></p>
	  	</div>
	</div>
</body>
</html>

<%--<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Usu&aacute;rio</title>       
        <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/images/favicon.ico" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/reset.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/arq-common.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/header.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/know_more.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/forms.css"  />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/plugins/sds/css/smoothDivScroll.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/bay.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/footer.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/jquery.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/tagcloud.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/image_wall.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/boxy.css" />"/>
        <script type="text/javascript" src="<c:url value="/js/jquery.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery-ui-1.8.custom.min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/scroll.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.boxy.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.maskedinput.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.validate.js"/>"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $("div#makeMeScrollable").smoothDivScroll({
                    scrollingSpeed: 12,
                    mouseDownSpeedBooster: 3,
                    visibleHotSpots: "always",
                    startAtElementId: "startAtMe"
                });

                $("div#makeMeScrollable2").smoothDivScroll({
                    scrollingSpeed: 12,
                    mouseDownSpeedBooster: 3,
                    visibleHotSpots: "always",
                    startAtElementId: "startAtMe"
                });
            });
        </script>

        <script type="text/javascript">
            $(document).ready(function() {
                $("#form1").validate();
            });
        </script>

        <script type="text/javascript">
            function setFocus() {
                var loginForm = document.getElementById("form1");
                if (loginForm) {
                    loginForm["user.login"].focus();
                }
            }
        </script>

        <profile:scriptProfile />
    </head>
    <body onload="setFocus();">
        <arq:header2 photoInstance="${photoMgr}" />
        <div id="corpo" class="default_div">
            <div id="info" style="display: block;width: 500px; margin-left: auto; margin-right: auto; margin-top: 10px;background: transparent;">
        	<w:conteudoPagina titulo="Perfil de Usu&aacute;rio">
                    <br />
                    <ul>
                        <c:forEach var="error" items="${errors}">
                        <li><c:out value="${error.message}" /> - <c:out value="${error.category}" /></li>
                        </c:forEach>
                    </ul>

                    <form id="form1" class="cmxform" name="dados" method="POST" action="<c:url value="/groupware-workbench/users/${userMgr.id}/saveWithUrl" />" accept-charset="UTF-8" autocomplete="off">
                        <input type="hidden" name="user.id" value="<c:out value="${user.id}" />" />
                        <input type="hidden" id="url" name="url" value="${url}" />
                        <div class="form_1" id="user_retrieve_form">
                            <ul class="field_line_f1">
                                <li class="label_f1"><span>Login:</span></li>
                                <li class="input_f1"><input type="text" class="required" name="user.login" value="<c:out value="${user.login}" />" /></li>
                            </ul>
                            <ul class="field_line_f1">
                                <li class="label_f1"><span>Password:</span></li>
                                <li class="input_f1"><input id="password" class="required" type="password" name="user.password" value="<c:out value="${user.password}" />" /></li>
                            </ul>
                            <ul class="field_line_f1">
                                <li class="label_f1"><span>E-mail:</span></li>
                                <li class="input_f1"><input id="email" class="required email" type="text" name="user.email" value="<c:out value="${user.email}" />" /></li>
                            </ul>
                            <ul class="field_line_f1">
                                <li class="label_f1"><span>Nome:</span></li>
                                <li class="input_f1"><input id="name" class="required" type="text" name="user.name" value="<c:out value="${user.name}" />" /></li>
                            </ul>
                            <ul class="field_line_f1">
                                <li class="label_f1"><span>Endere&ccedil;o da sua foto:</span></li>
                                <li class="input_f1"><input id="photoURL" type="text" name="user.photoURL" value="<c:out value="${user.photoURL}" />" /></li>
                            </ul>
                        </div>

                        <c:if test="${profileMgr.collablet.enabled}">
                            <profile:profile profileMgr="${profileMgr}" user="${user}" />
                        </c:if>

                        <div class="form_1">
                           <input type="submit" class="botao" value="Ok" />
                        </div>
                    </form>
                    <div class="voltar" align="center">
                       <button onclick="javascript:history.back(1);">Voltar</button>
                    </div>
                </w:conteudoPagina>
            </div>
        </div>
       
    </body>
</html>--%>