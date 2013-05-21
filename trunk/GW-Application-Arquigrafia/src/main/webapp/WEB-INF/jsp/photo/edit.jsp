<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tag"
	uri="http://www.groupwareworkbench.org.br/widgets/tag"%>

<style type="text/css">
.block {
	display: block;
}

form.cmxform label.error {
	display: none;
}
</style>
<script type="text/javascript"
	src="<c:url value="/js/upload-validation.js" />"></script>
<script>
    $(function() {
        
        $('#state').change(function(){
					var state = $(this).attr('value'),
							select_city = $("#city");

					$.getJSON('${pageContext.request.contextPath}/js/state/brazil.json', function(response) {
					    var cities = $.map(response['Brasil'][state], function(city) {
					        return '<option value="' + city + '">' + city + '</option>';
					    }).join('');
					    select_city.empty().append(cities);
					});
       });
    });
</script>


<script>
	$(function() {
					var selectedCountry;
					selectedCountry = "${photoRegister.country}";
			
    				var select_countries = $("#countries");
    				
					$.getJSON('${pageContext.request.contextPath}/js/countries.json', function(response) {
					    var countries = $.map(response['countries'], function(countries) {
					    	if( countries == selectedCountry)
					    		return '<option value="' + countries + '" selected = "selected">' + countries + '</option>';
					    	else
					    	return '<option value="' + countries + '">' + countries + '</option>';
					    }).join('');
					    select_countries.empty().append(countries);
					});
	});
	
</script>

<script>
	$(function() {
					var selectedState;
					selectedState = "${photoRegister.state}";
					
    				var select_state = $("#state");
    				select_state.empty();
    				if (selectedState == "" ){
					    select_state.append('<option selected="selected" value="" >Escolha o Estado</option>');
    				}
					$.getJSON('${pageContext.request.contextPath}/js/states.json', function(response) {
					    var states = $.map(response['states'], function(states) {
					    	if( states.sigla == selectedState)
					    		return '<option value="' + states.sigla + '" selected = "selected">' + states.nome + '</option>';
					    	else
					    	return '<option value="' + states.sigla + '">' + states.nome + '</option>';
					    }).join('');
					    select_state.append(states);
					});
					
					var select_city = $("#city");
					var selectedCity = "${photoRegister.city}";
					
					select_city.empty();
					
					if (selectedCity == "") {
						select_city.append('<option selected="" value="">Escolha uma cidade</option>');
					}

					if (selectedState != "") {
						$.getJSON('${pageContext.request.contextPath}/js/state/brazil.json', function(response) {
						    var cities = $.map(response['Brasil'][selectedState], function(city) {
						    	if( city == selectedCity)
						        	return '<option value="' + city + '" selected = "selected">' + city + '</option>';
						       	else
						       		return '<option value="' + city + '">' + city + '</option>';
					        	
						    }).join('');
						    select_city.removeAttr('disabled');
						    select_city.append(cities);
						});
					}
	});
	
</script>
<form id="upload_form" name="dados" method="POST"
	action="<c:url value="/photo/${photoMgr.id}/update" />">
	<input type="hidden" name="_method" value="put" /> <input type="hidden"
		name="user.id" value="${user.id}"> <input type="hidden"
		name="photoRegister.id" value="${photoRegister.id}"> <br />
	<br /> <small>Todos os campos com * são obrigatórios.</small>
	</p>

	<div id="upload_form" action="#" method="get">
		<p>
			<label class="left_form_label_column">Título:</label> <input
				name="photoRegister.name" type="text" class="text" value="<c:out value="${photoRegister.name}"/>" />
		  
		   <label>Autor
				da imagem:</label> <input name="photoRegister.imageAuthor" type="text"
				class="text" value="<c:out value="${photoRegister.imageAuthor}"/>" /> 
				
				<br /> 

			<label class="left_form_label_column">Estado:</label>
			<select name="photoRegister.state" id="state" class="input_content">
			</select> 

			<label class="right_form_label_column">Data da imagem:</label> <input name="photoRegister.dataCriacao" type="text"
				class="text" id="imagedate" value="<c:out value="${photoRegister.dataCriacaoISO8601ToDate}"/>"/> 
				<br /> 

			<label class="left_form_label_column">Cidade:</label> <select
				name="photoRegister.city" id="city" class="input_content" disabled="disabled">
			</select> 
			
			<label class="right_form_label_column">País:</label> 
			<select name="photoRegister.country" id="countries" value="photoRegister.country"
				class="input_content">
			</select>
			
			<br />
			
			<label class="left_form_label_column">Bairro:</label> <input
				name="photoRegister.district" type="text" class="text" value="<c:out value="${photoRegister.district}"/>"/>
			
			
			 <label class="right_form_label_column">Autor
				da obra:</label> <input name="photoRegister.workAuthor" type="text"
				class="text" value="<c:out value="${photoRegister.workAuthor}"/>"/> 
			
			<br />
		
				<label class="left_form_label_column">Logradouro:</label>
				<input name="photoRegister.street" type="text" class="text" value="<c:out value="${photoRegister.street}"/>"/>
		
			
			<label class="right_form_label_column">Data da obra:</label> 
			<input name="photoRegister.workdate" type="text"
				class="text" id="workdate" value="<c:out value="${photoRegister.workdateISO8601ToDate}"/>" />
				 <br />
				
						
				
				
				 <label class="left_form_label_column">Tags:</label>
			<!-- <textarea name="tags" class="text"></textarea> -->
			<!-- <tag:scriptTags />
	  <tag:selectTags tagMgr="${tagMgr}" /> -->
			<tag:setTags tagMgr="${tagMgr}" entity="${photo}" />

			<label class="right_form_label_column" >Descrição:</label>
			<textarea name="photoRegister.description" class="input_content"><c:out value="${photoRegister.description}" /></textarea>
			<br />
		</p>
		<!-- <p>
		Publicar minha obra, com as seguintes permissões:
		</p>
		<p class="creative_commons_form" id="creative_commons_left_form">
			Permitir o uso comercial da sua obra? <br />
			<c:forEach items="${allowCommercialUsesList}"
				var="allowCommercialUses">
				<input type="radio" name="photoRegister.allowCommercialUses"
					value="${allowCommercialUses}"
					id="photoRegister.allowCommercialUses"
					<c:if test="${allowCommercialUses==allowCommercialUses.default}">checked="checked"</c:if> />
				<label for="photoRegister.allowCommercialUses">${allowCommercialUses.name}</label>
				<br />
			</c:forEach>
		</p>
		<p class="creative_commons_form" id="creative_commons_right_form">
			Permitir modificações em sua obra? <br />
			<c:forEach items="${allowModificationsList}" var="allowModifications">
				<input type="radio" name="photoRegister.allowModifications"
					value="${allowModifications}" id="photoRegister.allowModifications"
					<c:if test="${allowModifications==allowModifications.default}">checked="checked"</c:if> />
				<label for="question_3-5">${allowModifications.name}</label>
				<br />
			</c:forEach>
		</p>
 -->
		<p>
			<input name="enviar" type="submit" class="submit cursor" value="" />
		</p>
	</div>
</form>