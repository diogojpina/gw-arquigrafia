<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="arquigrafia" uri="http://www.groupwareworkbench.org.br/widgets/arquigrafia" %>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>

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
      <!--   PAINEL DE IMAGENS - GALERIA - CARROSSEL   -->
      <div id="panel">
        <!--   COLUNA DE IMAGENS   -->
        <div class="images_column">
          <!--   IMAGENS   -->
          <a href="#" id="img_01" class="image"><img src="<c:url value="/img/photos/16777.jpg" />" width="170" height="117" alt="Foto 1"/></a>
          <a href="#" id="img_02" class="image"><img src="<c:url value="/img/photos/45044.jpg" />" width="170" height="117" alt="Foto 2"/></a>
          <a href="#" id="img_03" class="image"><img src="<c:url value="/img/photos/52926.jpg" />" width="170" height="117" alt="Foto 3"/></a>
        </div>
        <!--   FIM - COLUNA DE IMAGENS   -->
        <!--   COLUNA DE IMAGENS   -->
        <div class="images_column">
          <!--   IMAGENS   -->
          <a href="#" id="img_04" class="image"><img src="<c:url value="/img/photos/56665.jpg" />" width="170" height="117" alt="Foto 1"/></a>
          <a href="#" id="img_05" class="image"><img src="<c:url value="/img/photos/64871.jpg" />" width="170" height="117" alt="Foto 2"/></a>
          <a href="#" id="img_06" class="image"><img src="<c:url value="/img/photos/69363.jpg" />" width="170" height="117" alt="Foto 3"/></a>
        </div>
        <!--   FIM - COLUNA DE IMAGENS   -->
        <!--   COLUNA DE IMAGENS   -->
        <div class="images_column">
          <!--   IMAGENS   -->
          <a href="#" id="img_07" class="image"><img src="<c:url value="/img/photos/74561.jpg" />" width="170" height="117" alt="Foto 1"/></a>
          <a href="#" id="img_08" class="image"><img src="<c:url value="/img/photos/74618.jpg" />" width="170" height="117" alt="Foto 2"/></a>
          <a href="#" id="img_09" class="image"><img src="<c:url value="/img/photos/36345.jpg" />" width="170" height="117" alt="Foto 3"/></a>
        </div>
        <!--   FIM - COLUNA DE IMAGENS   -->
        <!--   COLUNA DE IMAGENS   -->
        <div class="images_column">
          <!--   IMAGENS   -->
          <a href="#" id="img_10" class="image"><img src="<c:url value="/img/photos/16637.jpg" />" width="170" height="117" alt="Foto 1"/></a>
          <a href="#" id="img_11" class="image"><img src="<c:url value="/img/photos/74621.jpg" />" width="170" height="117" alt="Foto 2"/></a>
          <a href="#" id="img_12" class="image"><img src="<c:url value="/img/photos/13961.jpg" />" width="170" height="117" alt="Foto 3"/></a>
        </div>
        <!--   FIM - COLUNA DE IMAGENS   -->
        <!--   COLUNA DE IMAGENS   -->
        <div class="images_column">
          <!--   IMAGENS   -->
          <a href="#" id="img_13" class="image"><img src="<c:url value="/img/photos/80213.jpg" />" width="170" height="117" alt="Foto 1"/></a>
          <a href="#" id="img_14" class="image"><img src="<c:url value="/img/photos/17784.jpg" />" width="170" height="117" alt="Foto 2"/></a>
          <a href="#" id="img_15" class="image"><img src="<c:url value="/img/photos/8806.jpg" />" width="170" height="117" alt="Foto 3"/></a>
        </div>
        <!--   FIM - COLUNA DE IMAGENS   -->
      </div>
      <!--   FIM - PAINEL DE IMAGENS  -->
      <!--   ÁREA DE TAGS   -->
      <div class="tags_cloud">
		<ul>
		  <li><a href="#" class="C">Berço</a></li>
		  <li><a href="#" class="C">Arejador</a></li>
          <li><a href="#" class="C">Aterro sanitário</a></li>
	      <li><a href="#" class="C">Taipa de Pilão</a></li>
		  <li><a href="#" class="C">Modilbão</a></li><br />
		  <li><a href="#" class="B">Aterro sanitário</a></li>
		  <li><a href="#" class="B">Coluna</a></li>
          <li><a href="#" class="B">Aterro sanitário</a></li>
		  <li><a href="#" class="B">Taipa de Pilão</a></li>
		  <li><a href="#" class="B">Imposta</a></li>
		  <li><a href="#" class="B">Parede Trombe</a></li><br />
		  <li><a href="#" class="A">Coletor Solar</a></li>
          <li><a href="#" class="A">Domo</a></li>
	      <li><a href="#" class="A">Taipa de Pilão</a></li>
		  <li><a href="#" class="A">Laminado de madeira</a></li>
		  <li><a href="#" class="A">Voluta</a></li>
		  <li><a href="#" class="A">Cúpula</a></li>
		  <li><a href="#" class="A">Hipogeu</a></li>
	    </ul>
      </div>
      <!--   FIM - ÁREA DE TAGS   -->
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
	  <!--   BARRA DE IMAGENS - (RODAPÉ)   -->
	  <div class="footer_images">
	    <!--   LINHA DE IMAGENS - (RODAPÉ)   -->
		<div class="images_line">  
		  <!--   SETAS DE NAVEGAÇÃO DAS FOTOS (RODAPÉ)-->
		  <a href="#" id="arrow-left" class="arrows">&laquo;</a>
		  <a href="#" id="arrow-right" class="arrows">&raquo;</a>
		  <!--   IMAGENS - (RODAPÉ)   -->
		  <a href="#" id="f_01" class="footer_image"><img src="<c:url value="/img/photos/52926.jpg" />" width="105" height="72" alt="Foto 1"/></a>
		  <a href="#" id="f_02" class="footer_image"><img src="<c:url value="/img/photos/45044.jpg" />" width="105" height="72" alt="Foto 2"/></a>
		  <a href="#" id="f_03" class="footer_image"><img src="<c:url value="/img/photos/69363.jpg" />" width="105" height="72" alt="Foto 3"/></a>
		  <a href="#" id="f_04" class="footer_image"><img src="<c:url value="/img/photos/74618.jpg" />" width="105" height="72" alt="Foto 4"/></a>
		  <a href="#" id="f_05" class="footer_image"><img src="<c:url value="/img/photos/56665.jpg" />" width="105" height="72" alt="Foto 5"/></a>
		  <a href="#" id="f_06" class="footer_image"><img src="<c:url value="/img/photos/8806.jpg" />" width="105" height="72" alt="Foto 6"/></a>
		  <a href="#" id="f_07" class="footer_image"><img src="<c:url value="/img/photos/80213.jpg" />" width="105" height="72" alt="Foto 7"/></a>
		  <a href="#" id="f_08" class="footer_image"><img src="<c:url value="/img/photos/16777.jpg" />" width="105" height="72" alt="Foto 8"/></a>		
	    </div>
        <!--   FIM - LINHA DE IMAGENS - (RODAPÉ)   -->
	  </div>
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
  
  <s:check name="X-X-usuario">
    <h1> Usuário ID ${sessionScope.userLogin.id} </h1> 
  </s:check>
  <s:check name="X-X-admin">
    <h1> Administrador ID ${sessionScope.userLogin.id}</h1> 
  </s:check>  
  <s:n-check name="X-X-usuario">
    <h1> Não é Usuário -  Guest ID ${sessionScope.userLogin.id}</h1> 
  </s:n-check>
  <s:n-check name="X-X-admin">
    <h1> Não é Administrador - Guest ID ${sessionScope.userLogin.id}</h1> 
  </s:n-check>
</body>
</html>
