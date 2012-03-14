<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>

<%@ attribute name="arquigrafiaInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.main.ArquigrafiaMgrInstance" %>


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