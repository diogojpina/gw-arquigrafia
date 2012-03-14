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
      <arquigrafia:wall arquigrafiaInstance="${arquigrafiaMgr}" />
      <!--   FIM - PAINEL DE IMAGENS  -->

      <!--   ÁREA DE TAGS   -->
      <arquigrafia:tagcloud arquigrafiaInstance="${arquigrafiaMgr}" />    
      <!--   FIM - ÁREA DE TAGS   -->
    </div>
    <!--   FIM - MEIO DO SITE   -->
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
