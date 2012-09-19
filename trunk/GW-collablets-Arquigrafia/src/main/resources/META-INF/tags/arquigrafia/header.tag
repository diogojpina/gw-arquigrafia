<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>

<%@ attribute name="arquigrafiaInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.main.ArquigrafiaMgrInstance" %>


 <!--   CABEÇALHO   -->
    <div id="header">
	
	  <!--   LOGO   -->
      <a href="<c:url value="/18/?firstTime=0" />" id="logo"></a>  <p id="beta">beta</p>
      <!--   MENU SUPERIOR   -->
	  <div id="first_menu">
        <!--   MENU INSTITUCIONAL   -->
        <ul id="top_menu_items">
          <li><a href="<c:url value="/18/project" />" id="project">O PROJETO</a></li>
          <li><a href="<c:url value="/faq/17/list" />" id="help">AJUDA</a></li>
          <li><a href="#" id="contact">FALE CONOSCO</a></li>
        </ul>
        <!--   FIM - MENU INSTITUCIONAL   -->
            
        <!--   MENU DE BUSCA   -->
        <form id="search_buttons_area" action="<c:url value="/photo/7/search" />" method="post" accept-charset="UTF-8">
          <!--   BARRA DE BUSCA   -->
          <input type="text" class="search_bar" name="q" />

          <input type="hidden" value="8" name="perPage" />
          <!--   BOTÃO DA BARRA DE BUSCA   -->
          <input type="submit" class="search_bar_button cursor" value="" />
          <!--   BOTÃO DE BUSCA AVANÇADA   -->
          <!--  <a href="#" id="complete_search"></a> -->
        </form>
        <!--   FIM - MENU DE BUSCA   -->
      </div>
	  <!--   FIM - MENU SUPERIOR   -->

      <s:n-check name="X-X-usuario">
          <!--   ÁREA DE LOGIN / CADASTRO   -->
          <div id="loggin_area" class="right">
            
            <!--   BOTÃO DE LOGIN   -->
            <a href="#" name="modal" id="login_button"></a>
        
            <!--   BOTÃO DE CADASTRO   -->
            <!-- <a href="#" name="modal" id="registration_button"></a> -->
          
          </div>
          <!--   FIM - ÁREA DE LOGIN / CADASTRO   -->
      </s:n-check>

      <s:check name="X-X-usuario">
        <!--   ÁREA DO USUARIO   -->
        <div id="loggin_area">
        <a href="<c:url value="/friends/11/show/${sessionScope.userLogin.id}" />" id="user_name">
        
        	<c:choose>
				<c:when test="${empty userLogin.photoURL}">
					<img name="Homer" id="profile_photo" src="<c:url value="/img/avatar.jpg" />" width="50" height="50" class="user_photo_thumbnail"/>
				</c:when>
				<c:otherwise>
					<img name="Homer" id="profile_photo" src="<c:url value="${userLogin.photoURL}" />" width="50" height="50" class="user_photo_thumbnail"/>
				</c:otherwise>
			</c:choose>
        	
        </a>
        <a href="<c:url value="/users/8/logout" />" id="logout">Sair</a><br />
		 <ul id="logged_menu">
        	   <!-- <li><a href="#" id="messages" title="Você tem 19 mensagens">11</a></li>  -->
			   <li> <a href="<c:url value="/album/15/list/${sessionScope.userLogin.id}" />" id="users" title="Meu Arquigrafia">&nbsp;</a></li>
			   <!-- <li><a href="#" id="comunities" title="Comunidades">&nbsp;</a></li> -->
			   <li><a href="#" name="modal" id="upload" title="Enviar uma imagem">&nbsp;</a></li>
      	  </ul>
          <a href="<c:url value="/friends/11/show/${sessionScope.userLogin.id}" />" id="user_name">${sessionScope.userLogin.name}</a>
        </div>
        <!--   FIM - ÁREA DO USUARIO   -->      
      </s:check>         
      
            <!--   MENSAGENS DE ENVIO / FALHA DE ENVIO   -->
	  <div id="message_delivery" class="message_delivery" >Mensagem enviada!</div>
      <div id="fail_message_delivery" class="message_delivery" >Falha no envio.</div>
      <div id="message_upload_ok" class="message_delivery" >Upload efetuado com sucesso!</div>
      <div id="message_upload_error" class="message_delivery" >Erro - Arquivo inválido!</div>
      <div id="message_login_error" class="message_delivery" >Erro - Login ou senha inválidos!</div>   
      <div id="generic_error" class="message_delivery_generic" >
	      <c:forEach var="error" items="${errors}">
	            <c:out value="${error.message}" /><br/>
	      </c:forEach>
	      <c:if test="${not empty erros}">
	      	<c:out value="${erros}" />
	      </c:if>
      </div>   
      <script type="text/javascript" src="js/message_delivery.js"></script>
      <!--   TESTE DE FUNCIONAMENTO DA FUNÇÃO   -->
      
    </div>
    <!--   FIM - CABEÇALHO   -->

