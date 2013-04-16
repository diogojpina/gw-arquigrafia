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
					var selectedCountry;
					selectedCountry = "${photoRegister.country}";
					console.log(selectedCountry);
			
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
				<option selected="" value="">Escolha o Estado</option>
				<option value="AC">Acre</option>
				<option value="AL">Alagoas</option>
				<option value="AM">Amazonas</option>
				<option value="AP">Amapá</option>
				<option value="BA">Bahia</option>
				<option value="CE">Ceará</option>
				<option value="DF">Distrito Federal</option>
				<option value="ES">Espirito Santo</option>
				<option value="GO">Goiás</option>
				<option value="MA">Maranhão</option>
				<option value="MG">Minas Gerais</option>
				<option value="MS">Mato Grosso do Sul</option>
				<option value="MT">Mato Grosso</option>
				<option value="PA">Pará</option>
				<option value="PB">Paraíba</option>
				<option value="PE">Pernambuco</option>
				<option value="PI">Piauí</option>
				<option value="PR">Paraná</option>
				<option value="RJ">Rio de Janeiro</option>
				<option value="RN">Rio Grande do Norte</option>
				<option value="RO">Rondônia</option>
				<option value="RR">Roraima</option>
				<option value="RS">Rio Grande do Sul</option>
				<option value="SC">Santa Catarina</option>
				<option value="SE">Sergipe</option>
				<option value="SP">São Paulo</option>
				<option value="TO">Tocantins</option>
			</select> 
			
			<label>Data da imagem:</label> <input name="imagedate" type="text"
				class="text" id="imagedate" value="<c:out value="${photoRegister.dataUpload}"/>"/> 
				<br /> 
				
				<label
				class="left_form_label_column">Cidade:</label> <select
				name="photoRegister.city" id="city" class="input_content"
				disabled="disabled">
				<option selected="" value="">Escolha uma cidade</option>
			</select> 
			
			<label>País:</label> 
			
			<select name="photoRegister.country" id="countries" value="photoRegister.country"
				class="input_content">

			</select>
			
			
			<label class="left_form_label_column">Bairro:</label> <input
				name="photoRegister.district" type="text" class="text" value="<c:out value="${photoRegister.district}"/>"/>
				
				 <label>Autor
				da obra:</label> <input name="photoRegister.workAuthor" type="text"
				class="text" value="<c:out value="${photoRegister.workAuthor}"/>"/> <br /> 
				
				<label class="left_form_label_column">Logradouro:</label>
			<input name="photoRegister.street" type="text" class="text" value="<c:out value="${photoRegister.street}"/>"/>
			
			 <label>Data
				da obra:</label> <input name="photoRegister	.workdate" type="text"
				class="text" id="workdate" value="<c:out value="${photoRegister.workdate}"/>" /> <br /> <label
				class="left_form_label_column">Tags:</label>
			<!-- <textarea name="tags" class="text"></textarea> -->
			<!-- <tag:scriptTags />
	  <tag:selectTags tagMgr="${tagMgr}" /> -->
			<tag:setTags tagMgr="${tagMgr}" entity="${photo}" />

			<label>Descrição:</label>
			<textarea name="photoRegister.description" class="input_content"><c:out value="${photoRegister.description}" /></textarea>
			<br />
		</p>
		<p>
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

		<p>
			<input name="enviar" type="submit" class="submit cursor" value="" />
		</p>
	</div>
</form>