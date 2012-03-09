<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>

<%@ attribute name="arquigrafiaInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.main.ArquigrafiaMgrInstance" %>


 <!--   CABEÇALHO   -->
    <div id="header">
	
	  <!--   LOGO   -->
      <a href="<c:url value="/${arquigrafiaInstance.id}/" />" id="logo"></a>
      <!--   MENU SUPERIOR   -->
	  <div id="first_menu">
        <!--   MENU INSTITUCIONAL   -->
        <ul id="top_menu_items">
          <li><a href="<c:url value="/${arquigrafiaInstance.id}/project" />" id="project">O PROJETO</a></li>
          <li><a href="<c:url value="/${arquigrafiaInstance.id}/help" />" id="help">AJUDA</a></li>
          <li><a href="#" id="contact">FALE CONOSCO</a></li>
        </ul>
        <!--   FIM - MENU INSTITUCIONAL   -->
            
        <!--   MENU DE BUSCA   -->
        <form action="" method="get" id="search_buttons_area">
          
          <!--   BARRA DE BUSCA   -->
          <input type="text" class="search_bar" name="search_bar_text" />
          <!--   BOTÃO DA BARRA DE BUSCA   -->
          <input type="submit" class="search_bar_button cursor" value="" name="submit_search_button" />
          <!--   BOTÃO DE BUSCA AVANÇADA   -->
          <a href="#" id="complete_search"></a>
        </form>
        <!--   FIM - MENU DE BUSCA   -->
      </div>
	  <!--   FIM - MENU SUPERIOR   -->

      <s:n-check name="X-X-usuario">
          <!--   ÁREA DE LOGIN / CADASTRO   -->
          <div id="loggin_area" class="right">
            
            <!--   BOTÃO DE LOGIN   -->
            <a href="#form_window" name="modal-" id="login_button"></a>
        
            <!--   BOTÃO DE CADASTRO   -->
            <a href="#form_window" name="modal" id="registration_button"></a>
          
          </div>
          <!--   FIM - ÁREA DE LOGIN / CADASTRO   -->
      </s:n-check>

      <s:check name="X-X-usuario">
        <!--   ÁREA DO USUARIO   -->
        <div id="loggin_area">
        <img src="<c:url value="/img/avatar.jpg" />" width="50" height="50" class="user_photo_thumbnail" />
        <a href="<c:url value="/users/${userMgr.id}/logout" />" id="logout">Sair</a><br />
		 <ul id="logged_menu">
        	   <li><a href="#" id="messages" title="Você tem 19 mensagens">11</a></li>
			   <li><a href="#" id="users" title="Usuários">&nbsp;</a></li>
			   <li><a href="#" id="comunities" title="Comunidades">&nbsp;</a></li>
			   <li><a href="#form_window" name="modal" id="upload" title="Subir uma imagem">&nbsp;</a></li>
      	  </ul>
          <a href="#" id="user_name">Homer J. Simpson</a>
        </div>
        <!--   FIM - ÁREA DO USUARIO   -->      
      </s:check>         
    </div>
    <!--   FIM - CABEÇALHO   -->

