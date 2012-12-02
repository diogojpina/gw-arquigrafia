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
           <h2> <c:out value="${faq.pergunta}"></c:out> </h2> <s:check name="X-X-admin"> <a href="<c:url value="/faq/${faq.id}/create" />"> Excluir </a>  <a href="<c:url value="/faq/${faq.id}" />"> Editar </a> </s:check>
           <c:out value="${faq.resposta}"></c:out>
           <br />
           <br />
        </c:forEach>
        <s:check name="X-X-admin">
           <a href="<c:url value="/faq/${faqMgr.id}/create" />"> Adicione uma nova pergunta ao FAQ.</a>
        </s:check>
        <br />
        
        <p> Caso ainda tenha dúvidas entre contato com nossa equipe usando o email <a href="mailto:arquigrafiabrasil@gmail.com " target="_blank">arquigrafiabrasil@gmail.com</a>.</p>
	 	</div>
        <!--   FIM - TEXTO DO PROJETO   -->
      </div>
      <!--   FIM - COLUNA ESQUERDA   -->
      <!--   COLUNA DIREITA   -->
      <div id="sidebar">
        <h2>Ainda precisando de Ajuda?</h2>
		<h3>Entre em contato com nossa equipe</h3>
        <p> Esta é uma versão beta do Arquigrafia e ainda pode conter erros. Caso tenha alguma dificuldade ou perceba problemas na navegação escreva para: <a href="mailto:arquigrafiabrasil@gmail.com " target="_blank">arquigrafiabrasil@gmail.com</a>.</p>
      </div>
      <!--   FIM - COLUNA DIREITA   -->
    </div>
    <!--   FIM - MEIO DO SITE-->
   <!--   FUNDO DO SITE   -->
    <div id="footer">
	  <!--   BARRA DE ABAS   -->
	  <arquigrafia:tabs counterMgr="${counterMgr}" photoMgr="${photoMgr}" commentMgr="${commentMgr}" arquigrafiaInstance="${arquigrafiaMgr}" />
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