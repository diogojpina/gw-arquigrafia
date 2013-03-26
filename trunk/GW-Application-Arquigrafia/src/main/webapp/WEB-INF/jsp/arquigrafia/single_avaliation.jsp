<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="arquigrafia" uri="http://www.groupwareworkbench.org.br/widgets/arquigrafia" %>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>
<%@ taglib prefix="p" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="binomial" uri="http://www.groupwareworkbench.org.br/widgets/binomial" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ taglib prefix="counter" uri="http://www.groupwareworkbench.org.br/widgets/counter" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">


<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Arquigrafia - Seu universo de imagens de arquitetura</title>
	<arquigrafia:includes arquigrafiaInstance="${arquigrafiaMgr}" />
</head>

  <binomial:scriptBinomial />

<body onload="load(<c:out value="${firstTime}" />)">
  <!--   CONTAINER   -->
  <div id="container">
  
  <!--   CABEÇALHO   -->
    <arquigrafia:header arquigrafiaInstance="${arquigrafiaMgr}" />

    <!--   MEIO DO SITE - ÁREA DE NAVEGAÇÃO   -->
    <div id="content">
      <!--   COLUNA ESQUERDA   -->
      
       <div id="sub_content_avaliation">
       
       <div id="text_Over">
       <h2 class="common_title">Avaliação</h2>
        <p>Como você avaliaria esta arquitetura apresentada na imagem ao lado? <br /> 
       </p>
		</div>
		
		
		<!--   BOX DE AVALIAÃÃO   -->
		<div id="avaliation_box">
	      
          <!--   FORMULÃRIO DE AVALIAÃÃO   -->
          <form name="tags" method="post" enctype="multipart/form-data"
			action="<c:url value="/${arquigrafiaMgr.id}/photo/${photo.id}/avaliation" />">
          <%--
            <input type="reset" id="clean" class="cursor" value="" />
            <input type="submit" id="avaliate" class="cursor" value="" />

        	<!--   PAINEL DE AVALIAÃÃO   -->
			<ul id="avaliation_list">
				<li>
					<span class="left">Interno</span>
						<div id="slider_1"></div>
					<span class="right">Externo</span>
				</li>
				<li>
					<span class="left">Distante</span>
						<div id="slider_2"></div>
					<span class="right">PrÃ³ximo</span>
				</li>
				<li>
					<span class="left">Vertical</span>
						<div id="slider_3"></div>
					<span class="right">Horizontal</span>
				</li>
				<li>
					<span class="left">Opaco</span>
						<div id="slider_4"></div>
					<span class="right">Transparente</span>
				</li>
				<li>
					<span class="left">Claro</span>
						<div id="slider_5"></div>
					<span class="right">Escuro</span>
				</li>
				<li>
					<span class="left">Aberto</span>
						<div id="slider_6"></div>
					<span class="right">Fechado</span>
				</li>
			</ul>
			--%>

						<div id="binomialsWrap">
                            <div id="binomialsUser">
                                <binomial:userAverage entity="${photo}" manager="${binomialMgr}" user="${sessionScope.userLogin}" name="userBin"
                                        labelClass="binLabelClass" valueClass="binValueClass" wrapClass="binWrapClass" />
                                     
                                     
                            </div>
                             
                        </div>
                        <div id="text_Under">
                                <p>Ao terminar clique no botão Salvar.<br /> </p>
                                </div>
                           
                           	<div id="binomialSubmit">
                                   <input type="submit" name="saveBinomial" value="" />
                          	</div>    
                </div>
                       
         </form>
         <!--   FIM - FORMULÃRIO DE AVALIAÃÃO   -->
			
		 <!--   SCRIPT DO SLIDER DE AVALIAÃÃO   -->
	     <%--
	     <script>
			$("#slider_1").slider({ value:50, min: 0, max: 100, step: 10 });
			$("#slider_2").slider({ value:50, min: 0, max: 100, step: 10 });
			$("#slider_3").slider({ value:50, min: 0, max: 100, step: 10 });
			$("#slider_4").slider({ value:50, min: 0, max: 100, step: 10 });
			$("#slider_5").slider({ value:50, min: 0, max: 100, step: 10 });
			$("#slider_6").slider({ value:50, min: 0, max: 100, step: 10 });
		 </script>
		 --%>
		 
								
                        
       <!--   FIM - BOX DE AVALIAÃÃO   -->

			<br />
			<h3>Compare as avaliações:</h3>
			<p>Compare sua avaliação com as do outros usuários.</p>
			<a href="<c:url value="/18/photo_avaliation_avarage/${photo.id}" />" title="Média das avaliações da foto" id="evaluation_average"></a>
	     <!--<p>Nós te preparamos um vídeo que mostra o passo a passo da avaliação. Clique no botão abaixo para assistí­-lo:</p>
	     <a href="#" id="watch_button"></a> -->
	                        
		
      </div>
      
      
      <!--   FIM - COLUNA ESQUERDA   -->
      
      <!--   COLUNA LATERAL - DIREITA   -->
      
      <div id="sidebar_avaliation">
        <!--   PAINEL DE VISUALIZAÃÃO - SINGLE   -->
				<div id="single_view_block">
					<!--   NOME / STATUS DA FOTO   -->
					<div id="single_view_header">
						<h1><a href="<c:url value="/photo/${photo.id}" />" id="name">
						<c:out value="${photo.name}"/></a>    	</h1>
						<ul id="single_view_image_rating" class="right">
							<li id="graph" ></li>
							<li><small><counter:showCounter
												manager="${counterMgr}" entity="${photo}"
												viewer="${sessionScope.userLogin}" increment="true"
												wrapClass="counter_show" /> e <binomial:count binomialMgr="${binomialMgr}" entity="${photo}"/>
									</small></li>
						</ul>
					</div>
					<!--   FIM - NOME / STATUS DA FOTO   -->
					<!--   FOTO   -->
					<%--img src="img/photos/8806.jpg" class="single_view_image" width="600" height="410" alt="" title="" /--%>
					<p:show clazz="single_view_image"
						 foto="${photo}"
						photoMgr="${photoMgr}" />

				</div>
		
      </div>
      
     
      <!--   FIM - COLUNA LATERAL - DIREITA   -->
    </div>
    <!--   FIM - MEIO DO SITE   -->
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

