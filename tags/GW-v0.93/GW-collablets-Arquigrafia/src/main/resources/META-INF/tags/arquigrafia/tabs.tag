<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>
<%@ taglib prefix="p" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>

<%@ attribute name="arquigrafiaInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.main.ArquigrafiaMgrInstance" %>

	  <!--   BARRA DE ABAS   -->
	  <ul class="tabs">
        <!--   ABAS   -->
        <li>
	      <a class="tab_link selected_tab_link" href="#images_line_1">NOVAS IMAGENS</a>
		</li>
		<li>
		  <a class="tab_link" href="#images_line_2">POPULARES</a>
		</li>
		<li>
		  <a class="tab_link" href="#images_line_3">+ COMENTADAS</a>
		</li>
		<!-- <li class="tab_not_selected">
		  <a href="#" class="tab_link">AVALIADAS</a>
		</li>
		<li class="tab_not_selected">
		  <a href="#" class="tab_link">COMENTADAS</a>
		</li>  -->
      </ul>
	  <!--   BARRA DE IMAGENS - (RODAPÉ)   -->
	  <div class="footer_images">
	    
		<!--   SETAS DE NAVEGAÇÃO DAS FOTOS (RODAPÉ)-->
		<div id="arrow-left" class="arrows">&laquo;</div>
		<div id="arrow-right" class="arrows">&raquo;</div>
		
		<!--  CONTAINER DAS IMAGENS - (RODAPÉ)  -->
		<div id="images_container">
		
			<!--   LINHA DE IMAGENS - (RODAPÉ)   -->
			<div class="images_line" id="images_line_1">  
			  
		  		<!--   IMAGENS - (RODAPÉ)   -->
		  		<p:listLastPhotos photoInstance="${photoMgr}" amount="24" />
		  				
		  	</div>
		  	
		  	<div class="images_line" id="images_line_2" style="display:none;">  
			  
		  		<!--   IMAGENS - (RODAPÉ)   -->
		  		<p:listMostViews counterMgr="${counterMgr}" amount="24" />
		  				
		  	</div>
		  	
		  	<div class="images_line" id="images_line_3" style="display:none;">  
			  
		  		<!--   IMAGENS - (RODAPÉ)   -->
		  		<p:listMoreCommented commentMgr="${commentMgr}" amount="24" />
		  				
		  	</div>
		</div>
	  </div>
	  <!--   FIM - BARRA DE IMAGENS - (RODAPÉ)   -->
	  
	   <p:countAllPhotos photoInstance="${photoMgr}" />