<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="arquigrafia" uri="http://www.groupwareworkbench.org.br/widgets/arquigrafia" %>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>
<%@ taglib prefix="p" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Arquigrafia - Seu universo de imagens de arquitetura</title>
<arquigrafia:includes arquigrafiaInstance="${arquigrafiaMgr}" />

<script type="text/javascript" src="<c:url value="/js/pagination.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/module.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/search.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/analytics.js" />"></script>

</head>

<body>
  <!--   CONTAINER   -->
  <div id="container">
  
  <!--   CABEÇALHO   -->
    <arquigrafia:header arquigrafiaInstance="${arquigrafiaMgr}" />

    <!--   MEIO DO SITE - ÁREA DE NAVEGAÇÃO   -->
    <div id="content">
      <!--   PAINEL DE IMAGENS - GALERIA - CARROSSEL   -->
      
      
         <div id="search_statistics">
             <!-- <span id="resultTerm">Voc&ecirc; buscou: <c:out value="${searchTerm}" />. </span> -->
<%--              <c:set var="qtdFotos" value="${fn:length(fotos)}" />
             <span id="resultCount">
                 <c:choose>
                     <c:when test="${qtdFotos == 0}">(nenhum resultado)</c:when>
                     <c:when test="${qtdFotos == 1}">(1 resultado)</c:when>
                     <c:otherwise>(<c:out value="${qtdFotos}" /> resultados)</c:otherwise>
                 </c:choose>
             </span>
             <br />
 --%>         
  							<c:if test="${empty tags and empty people and results eq false and empty messageForStopword}">
		             <span id="resultTerm">Nenhuma imagem encontrada </span>
		             <br />             
	             </c:if>

  							<c:if test="${not empty messageForStopword}">
		             <span id="resultTerm">${messageForStopword }</span>
		             <br />             
  	           </c:if>
	
          </div>
         <br />
         <div id="search_scroll">
         		<input id="context_path" type="hidden" value="${pageContext.request.contextPath}"/>	
             <p:listSearch photos="${photos}" photoInstance="${photoMgr}" lineClass="search_line"/>
         </div>



             <!--   FIM - MEIO DO SITE   -->
    <!--   FUNDO DO SITE   -->
    
    </div>
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
	<script type="text/html" id="analytics">
		${searchTerm}
	</script>  
</body>
</html>