<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="arquigrafia" uri="http://www.groupwareworkbench.org.br/widgets/arquigrafia" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>
<%@ taglib prefix="p" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="friends" uri="http://www.groupwareworkbench.org.br/widgets/friends" %>
<%@taglib  prefix="profile" uri="http://www.groupwareworkbench.org.br/widgets/profile" %>
<%@taglib  prefix="user" uri="http://www.groupwareworkbench.org.br/widgets/user" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="album" uri="http://www.groupwareworkbench.org.br/widgets/album" %>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">


<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Arquigrafia - Seu universo de imagens de arquitetura</title>
	<arquigrafia:includes arquigrafiaInstance="${arquigrafiaMgr}" />
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
					<img name="Homer" id="profile_photo" src="<c:url value="/img/avatar.jpg" />" />
				</c:when>
				<c:otherwise>
					<img name="Homer" id="profile_photo" src="${friend.photoURL}" />
				</c:otherwise>
			</c:choose>
        
			<!-- <a href="#" id="small">Trocar fotografia</a> -->
			<c:if test="${friend.id == userLogin.id}">
				<friends:friendsRequests style="width: 475px;"
                        user="${userLogin}"
                        friendsMgr="${friendsMgr}"
                        afterRejectFunction="refreshFriendsPage"
                        afterAcceptFunction="refreshFriendsPage"
                        friendsHeader="friends_header" />
            </c:if>
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
		<h1>
			<c:out value="${friend.name}" />
		</h1>
		<user:show user="${userLogin}"  editUserButtonId="edit_user_button" editUserButtonClass="user_edit" />
     	<profile:showProfile profileMgr="${profileMgr}" user="${friend}" editProfileButtonId="edit_perfil_button" editProfileButtonClass="profile_edit"/>
        
		<!--   BARRA LATERAL - DIREITA   -->
		<div id="right_sidebar">
        
	        <friends:listFriends
	            user="${friend}"
	            friendsMgr="${friendsMgr}" friendsHeader="friends_header"
	            style="width: 400px;" />
	            
	        <!-- <h2 id="profile_block_title">Comunidades</h2>
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
	         -->
 			<!-- <album:listGalery albumMgr="${albumMgr}" user="${friend}"/> -->

		</div>
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
