<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
          <li><a href="#" id="help">AJUDA</a></li>
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
      <!--   ÁREA DE LOGIN / CADASTRO   -->
      <div id="loggin_area" class="right">
        
        <!--   BOTÃO DE LOGIN   -->
        <a href="index_logged.html" name="modal-" id="login_button"></a>
        
        <!--   BOTÃO DE CADASTRO   -->
        <a href="#form_window" name="modal" id="registration_button"></a>
      
      </div>
      <!--   FIM - ÁREA DE LOGIN / CADASTRO   -->
            
    </div>
    <!--   FIM - CABEÇALHO   -->

