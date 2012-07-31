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
      <div id="sub_content">
        <!--   PAINEL DE VISUALIZAÃÃO - SINGLE   -->
				<div id="single_view_block">
					<!--   NOME / STATUS DA FOTO   -->
					<div id="single_view_header">
						<h1><c:out value="${photo.name}"/>    	</h1>
						<ul id="single_view_image_rating" class="right">
							<li id="graph" ></li>
							<li><small><counter:showCounter
												manager="${counterMgr}" entity="${photo}"
												viewer="${sessionScope.userLogin}" increment="true"
												wrapClass="counter_show" />
									</small></li>
						</ul>
					</div>
					<!--   FIM - NOME / STATUS DA FOTO   -->
					<!--   FOTO   -->
					<%--img src="img/photos/8806.jpg" class="single_view_image" width="600" height="410" alt="" title="" /--%>
					<p:show clazz="single_view_image"
						 foto="${photo}"
						photoMgr="${photoMgr}" />

					<hr />
				</div>
		<!--   BOX DE AVALIAÃÃO   -->
		<div id="avaliation_box">
	      <p>Avalie a imagem conforme os pares de qualidades opostas abaixo e ao terminar clique no botão Salvar para registrar a sua interpretação e ver a avaliação de outros usuários. </p>
          <!--   FORMULÃRIO DE AVALIAÃÃO   -->
          <form name="tags" method="post" enctype="multipart/form-data"
			action="<c:url value="/photo/${photo.id}" />">
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
                                <binomial:generalAverage entity="${photo}" manager="${binomialMgr}" name="userBin"
                                        labelClass="binLabelClass" valueClass="binValueClass" wrapClass="binWrapClass" />
                                <!-- <div id="binomialSubmit">
                                    <input type="submit" name="saveBinomial" value="" />
                                </div>  -->
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
	   </div>
       <!--   FIM - BOX DE AVALIAÃÃO   -->
      </div>
      <!--   FIM - COLUNA ESQUERDA   -->
      <!--   COLUNA LATERAL - DIREITA   -->
      <div id="sidebar">
        <h2 class="common_title">Avaliação</h2>
        <p>Como você avaliaria a arquitetura apresentada na imagem ao lado? </p>
		<p>Há um predomínio de elementos horizontais ou verticais, e em que proporção?</p>
		<p>Experimente posicionar os marcadores(controle deslizante) em um ponto que corresponda à sua avaliação da arquitetura visível na imagem para cada par de qualidades opostas.</p>
		<p>Salve a sua resposta e, se tiver curiosidade, veja como outros usuários avaliaram esta mesma imagem.</p>
        <h3>Como faço para avaliar?</h3><br />
        <p>Deslize os marcadores até encontrar a posição ou os percentuais que correspondam à sua interpretação da arquitetura visível na imagem para cada par de qualidades.</p>
        <!--<p>Nós te preparamos um vídeo que mostra o passo a passo da avaliação. Clique no botão abaixo para assistí­-lo:</p>
        <a href="#" id="watch_button"></a> -->
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

