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
      <!--   COLUNA ESQUERDA   -->
      <div id="sub_content">
        <!--   CONTEÚDO SOBRE O PROJETO   -->
        <h1>Ajuda -  Perguntas e respostas frequentes</h1>
        <a href="#"  id="printer_icon"></a>
        <!--   TEXTO DO PROJETO   -->
        <div id="project_text">
        <br />
        <c:forEach items="${faqList}" var="faq">
           <h2> <c:out value="${faq.pergunta}"></c:out> <s:check name="X-X-admin"> <a href="<c:url value="/faq/${faq.id}/create" />"> Excluir </a>  <a href="<c:url value="/faq/${faq.id}" />"> Editar </a> </s:check></h2>
           <c:out value="${faq.resposta}"></c:out>
           <br />
           <br />
        </c:forEach>
        <s:check name="X-X-admin">
           <a href="<c:url value="/faq/${faqMgr.id}/create" />"> Adicione uma nova pergunta ao FAQ.</a>
        </s:check>
        <br />
 </div>
        <!--   FIM - TEXTO DO PROJETO   -->
      </div>
      <!--   FIM - COLUNA ESQUERDA   -->
      <!--   COLUNA DIREITA   -->
      <div id="sidebar">
        <h2>Lorem ipsum</h2>
		<h3>Dolor sit</h3>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras pulvinar elementum accumsan. Cras non convallis nunc. Donec at purus eget lacus rutrum lacinia vel rhoncus velit. Nam sollicitudin, odio ut ultricies cursus, felis leo lacinia mi, quis rhoncus magna urna eu nibh. Nam quis erat nibh. Mauris viverra urna neque. Sed ut lobortis risus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed sed neque tellus. Nunc tempor ornare dignissim. Vivamus luctus nisi in lorem tempus faucibus. Sed sed mauris id mi faucibus dignissim ac nec ipsum.</p>
      </div>
      <!--   FIM - COLUNA DIREITA   -->
    </div>
    <!--   FIM - MEIO DO SITE-->
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