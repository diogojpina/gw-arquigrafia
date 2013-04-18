<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag" %>

  <style type="text/css">
  	.block { display: block; }
  	form.cmxform label.error { display: none; }	
  </style>
<script type="text/javascript" src="<c:url value="/js/upload-validation.js" />"></script>
	

<script>
    $(function() {
        
        $('#state').change(function(){
					var state = $(this).attr('value'),
							select_city = $("#city");

					$.getJSON('${pageContext.request.contextPath}/js/state/brazil.json', function(response) {
					    var cities = $.map(response['Brasil'][state], function(city) {
					        return '<option value="' + city + '">' + city + '</option>';
					    }).join('');
					    select_city.removeAttr('disabled');
					    select_city.empty().append(cities);
					});
       });
    });
</script>
<form id="upload_form" name="dados" method="POST" action="<c:url value="/photo/${photoMgr.id}/registra" />" enctype="multipart/form-data">
	<input type="hidden" name="user.id" value="${user.id}">
	<input type="hidden" name="photoRegister.id" value="">
	
	
	
	<div id="upload_bar">
	
	  <link type="text/css" href="<c:url value="/css/ui-lightness/jquery-ui-1.8.18.custom.css" />" rel="stylesheet" />	
	  
	  <script type="text/javascript" src="<c:url value="/js/jquery-1.7.1.min.js" />"></script>
	  <script type="text/javascript" src="<c:url value="/js/jquery-ui-1.8.18.custom.min.js" />"></script>
	  <!--<script type="text/javascript">
	    $(function(){
	      // Progressbar
	      $("#progressbar").progressbar({
	        value: 20 
	      });
	    });
	  </script>-->
	
	  <h2>Upload</h2><br />
	  <h3>Selecione a imagem para o upload:</h3>
	  <br />
	     <input id="imageUpload" type="file" name="foto" value="" />
	  <br />
	</div>
	<div id="upload_form" action="#" method="get">
	  <p>
	  <label class="left_form_label_column">Título:</label>
	  <input name="photoRegister.name" type="text" class="text" />
	  <label>Autor da imagem:</label>
	  <input name="photoRegister.imageAuthor" type="text" class="text" />
	  <br />

	  <label class="left_form_label_column">Estado:</label>
	  <select name="photoRegister.state" id="state" class="input_content">
	  </select>

<script>
	$(function() {			
    				var select_state = $("#state");
    				
					$.getJSON('${pageContext.request.contextPath}/js/states.json', function(response) {
					    var states = $.map(response['states'], function(states) {
					    	return '<option value="' + states.sigla + '">' + states.nome + '</option>';
					    }).join('');
					    
					    select_state.empty().append('<option selected="" value="" >Escolha o Estado</option>');
					    select_state.append(states);
					});
	});
</script>

	  <label>Data da imagem:</label>
	  <input name="photoRegister.dataCriacao" type="text" class="text" id="imagedate" />
	  <br />
	  
	  <label class="left_form_label_column" >Cidade:</label>
	  <select name="photoRegister.city" id="city" class="input_content" disabled="disabled">
	  		<option selected="" value="" >Escolha uma cidade</option>
	  </select>
	  
	  <label>País:</label>
	  <select name="photoRegister.country" class="input_content" id="countries">
	  </select>
<script>
	$(function() {
    				var select_countries = $("#countries");
    				
					$.getJSON('${pageContext.request.contextPath}/js/countries.json', function(response) {
					    var countries = $.map(response['countries'], function(countries) {
					    	if( countries == "Brasil")
					    		return '<option value="' + countries + '" selected = "selected">' + countries + '</option>';
					    	else
					    	return '<option value="' + countries + '">' + countries + '</option>';
					    }).join('');
					    select_countries.empty().append(countries);
					});
	});
</script>	  
	  <br />
	  <label class="left_form_label_column">Bairro:</label>
	  <input name="photoRegister.district" type="text" class="text" />
	  <label>Autor da obra:</label>
	  <input name="photoRegister.workAuthor" type="text" class="text" />
	  <br />
	  <label class="left_form_label_column" >Logradouro:</label>
	  <input name="photoRegister.street" type="text" class="text" />
	  <label>Data da obra:</label>
	  <input name="photoRegister.workdate" type="text" class="text" id="workdate" />
	  <br />
	  <label class="left_form_label_column">Tags:</label>
	  <!-- <textarea name="tags" class="text"></textarea> -->
	  <!-- <tag:scriptTags />
	  <tag:selectTags tagMgr="${tagMgr}" /> -->
	  <tag:setTags tagMgr="${tagMgr}" entity="${photo}" />
	  
	  <label>Descrição:</label>
	  <textarea name="photoRegister.description" class="input_content"></textarea>
	  <br />
	  </p>
	  <p> 
	  	 <input name="terms" type="checkbox" value="read" id="creative_commons_text_checkbox" /> Sou o autor da imagem ou possuo permissão expressa do autor para disponibilizá-la no Arquigrafia. 
	  	 <br />
	  	 <label for="terms" generated="true" class="error" style="display: inline-block; "></label>
	  	 <br />
	     Escolho a licença <a href="http://creativecommons.org/licenses/?lang=pt_BR" id="creative_commons" target="_blank" style="text-decoration:underline; line-height:16px;">Creative Commons</a>, para publicar minha obra, com as seguintes permissões:
	  </p>
	      <p  class="creative_commons_form" id="creative_commons_left_form">
	      Permitir o uso comercial da sua obra?
	      <br />
	      <c:forEach items="${allowCommercialUsesList}" var="allowCommercialUses"> 
	        <input type="radio" name="photoRegister.allowCommercialUses" value="${allowCommercialUses}" id="photoRegister.allowCommercialUses"  
	        <c:if test="${allowCommercialUses==allowCommercialUses.default}">checked="checked"</c:if> />
	        <label for="photoRegister.allowCommercialUses">${allowCommercialUses.name}</label>
	        <br />
	      </c:forEach>
	    </p>
	    <p class="creative_commons_form" id="creative_commons_right_form">
	      Permitir modificações em sua obra?
	      <br />
	      <c:forEach items="${allowModificationsList}" var="allowModifications">
	        <input type="radio" name="photoRegister.allowModifications" value="${allowModifications}" id="photoRegister.allowModifications"
	        <c:if test="${allowModifications==allowModifications.default}">checked="checked"</c:if> />
	        <label for="question_3-5">${allowModifications.name}</label>
	        <br />
	      </c:forEach>
	    </p> 
	
		<p>
		  <input name="enviar" type="submit" class="submit cursor" value="" />
		</p>
	</div>
</form>