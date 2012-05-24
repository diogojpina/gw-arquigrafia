<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="arquigrafia" uri="http://www.groupwareworkbench.org.br/widgets/arquigrafia" %>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>
<%@ taglib prefix="p" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="binomial" uri="http://www.groupwareworkbench.org.br/widgets/binomial" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

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
            <h1>Imagem de teste</h1>
            <ul id="single_view_image_rating" class="right">
              <li id="graph"></li>
              <li><small>312</small></li>
              <li id="comments"></li>
              <li><small>345</small></li>
              <li id="favourite"></li>
              <li><small>176</small></li>
            </ul>
          </div>
          <!--   FIM - NOME / STATUS DA FOTO   -->
          <!--   FOTO   -->
          
          
          <!-- img src="img/photos/8806.jpg" class="single_view_image" width="600" height="410" /-->
          <p:show clazz="single_view_image" style="width: 600px; height:410px"  foto="${photo}" photoInstance="${photoInstance}"/>
          
          
          <hr />
        </div>
		<!--   BOX DE AVALIAÃÃO   -->
		<div id="avaliation_box">
	      <p>Avalie a foto segundo os atributos abaixo e após finalizar, clique no botão Avaliar ao lado para contabilizar a sua avaliação e visualizar a mídia entre as outras avaliaçoes.</p>
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
                                <binomial:userAverage entity="${photo}" manager="${binomialMgr}" user="${sessionScope.userLogin}" name="userBin"
                                        labelClass="binLabelClass" valueClass="binValueClass" wrapClass="binWrapClass" />
                                <div id="binomialSubmit">
                                    <input type="submit" name="saveBinomial" value="" />
                                </div>
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
        <h2 class="common_title">Avaliação de binômios</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla laoreet purus et neque sagittis et pretium turpis euismod. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Curabitur blandit mollis eros, a dictum mauris laoreet in. Curabitur ultricies aliquet ante, ac iaculis orci consectetur vel. In eu ipsum metus. Pellentesque accumsan nisl nec eros cursus vehicula.</p>
        <h3>Posso avaliar mais que uma vez?</h3><br />
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla laoreet purus et neque sagittis et pretium turpis euismod.</p>
        <h3>Como faço para avaliar?</h3>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla laoreet purus et neque sagittis et pretium turpis euismod. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>
        <p>Nós te preparamos um vídeo que mostra o passo a passo da avaliação. Clique no botão abaixo para assistí­-lo:</p>
        <a href="#" id="watch_button"></a>
      </div>
      <!--   FIM - COLUNA LATERAL - DIREITA   -->
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
</body>
</html>

