<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag" %>

<form name="dados" method="POST" action="<c:url value="/photo/${photoInstance.id}/registra" />" enctype="multipart/form-data">
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
	  //Datepicker
	  $(function() {
		$( "#imagedate" ).datepicker();
	  });
	  $(function() {
		$( "#workdate" ).datepicker();
	  });
    });
  </script>-->
  <script type="text/javascript">
	function validar(obj){
		var form = document.dados;
		if(obj.checked == true){
			form.enviar.disabled = false;
		}else{
			form.enviar.disabled= true;
		}
	}
	</script>
  <h2>Upload</h2><br />
  <h3>Selecione a imagem para o upload:</h3>
  <br />
  <!-- AAMM --><input id="imageUpload" type="file" name="foto" value="" /><br /><!-- AAMM -->
  <!-- <input type="url" class="url_bar" />
  <input name="selecionar" type="submit" id="select_button" value="" /><br /><br />  -->
</div>
<div id="upload_form" action="#" method="get">
  <p>
  <label class="left_form_label_column">Título:</label>
  <input name="photoRegister.name" type="text" class="text" />
  <label>Autor da imagem:</label>
  <input name="photoRegister.copyRights" type="text" class="text" />
  <br />
  <label class="left_form_label_column" >Cidade:</label>
  <input name="photoRegister.city" type="text" class="text" />
  <label>Data da imagem:</label>
  <input name="imagedate" type="text" class="text" id="imagedate" />
  <br />
  <label class="left_form_label_column">Estado:</label>
  <select name="photoRegister.state" class="input_content">
  	<option selected="" value="" >Escolha o Estado</option>
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
  <label>País:</label>
  <select name="photoRegister.country" class="input_content">
	<option value="Afeganistão">Afeganistão</option>
	<option value="África do Sul">África do Sul</option>
	<option value="Albânia">Albânia</option>
	<option value="Alemanha">Alemanha</option>
	<option value="América Samoa">América Samoa</option>
	<option value="Andorra">Andorra</option>
	<option value="Angola">Angola</option>
	<option value="Anguilla">Anguilla</option>
	<option value="Antartida">Antartida</option>
	<option value="Antigua">Antigua</option>
	<option value="Antigua e Barbuda">Antigua e Barbuda</option>
	<option value="Arábia Saudita">Arábia Saudita</option>
	<option value="Argentina">Argentina</option>
	<option value="Aruba">Aruba</option>
	<option value="Australia">Australia</option>
	<option value="Austria">Austria</option>
	<option value="Bahamas">Bahamas</option>
	<option value="Bahrain">Bahrain</option>
	<option value="Barbados">Barbados</option>
	<option value="Bélgica">Bélgica</option>
	<option value="Belize">Belize</option>
	<option value="Bermuda">Bermuda</option>
	<option value="Bhutan">Bhutan</option>
	<option value="Bolívia">Bolívia</option>
	<option value="Botswana">Botswana</option>
	<option value="Brasil" selected="selected" >Brasil</option>
	<option value="Brunei">Brunei</option>
	<option value="Bulgária">Bulgária</option>
	<option value="Burundi">Burundi</option>
	<option value="Cabo Verde">Cabo Verde</option>
	<option value="Camboja">Camboja</option>
	<option value="Canadá">Canadá</option>
	<option value="Chade">Chade</option>
	<option value="Chile">Chile</option>
	<option value="China">China</option>
	<option value="Cingapura">Cingapura</option>
	<option value="Colômbia">Colômbia</option>
	<option value="Djibouti">Djibouti</option>
	<option value="Dominicana">Dominicana</option>
	<option value="Emirados Árabes">Emirados Árabes</option>
	<option value="Equador">Equador</option>
	<option value="Espanha">Espanha</option>
	<option value="Estados Unidos">Estados Unidos</option>
	<option value="Fiji">Fiji</option>
	<option value="Filipinas">Filipinas</option>
	<option value="Finlândia">Finlândia</option>
	<option value="França">França</option>
	<option value="Gabão">Gabão</option>
	<option value="Gaza Strip">Gaza Strip</option>
	<option value="Ghana">Ghana</option>
	<option value="Gibraltar">Gibraltar</option>
	<option value="Granada">Granada</option>
	<option value="Grécia">Grécia</option>
	<option value="Guadalupe">Guadalupe</option>
	<option value="Guam">Guam</option>
	<option value="Guatemala">Guatemala</option>
	<option value="Guernsey">Guernsey</option>
	<option value="Guiana">Guiana</option>
	<option value="Guiana Francesa">Guiana Francesa</option>
	<option value="Haiti">Haiti</option>
	<option value="Holanda">Holanda</option>
	<option value="Honduras">Honduras</option>
	<option value="Hong Kong">Hong Kong</option>
	<option value="Hungria">Hungria</option>
	<option value="Ilha Cocos (Keeling)">Ilha Cocos (Keeling)</option>
	<option value="Ilha Cook">Ilha Cook</option>
	<option value="Ilha Marshall">Ilha Marshall</option>
	<option value="Ilha Norfolk">Ilha Norfolk</option>
	<option value="Ilhas Turcas e Caicos">Ilhas Turcas e Caicos</option>
	<option value="Ilhas Virgens">Ilhas Virgens</option>
	<option value="Índia">Índia</option>
	<option value="Indonésia">Indonésia</option>
	<option value="Inglaterra">Inglaterra</option>
	<option value="Irã">Irã</option>
	<option value="Iraque">Iraque</option>
	<option value="Irlanda">Irlanda</option>
	<option value="Irlanda do Norte">Irlanda do Norte</option>
	<option value="Islândia">Islândia</option>
	<option value="Israel">Israel</option>
	<option value="Itália">Itália</option>
	<option value="Iugoslávia">Iugoslávia</option>
	<option value="Jamaica">Jamaica</option>
	<option value="Japão">Japão</option>
	<option value="Jersey">Jersey</option>
	<option value="Kirgizstão">Kirgizstão</option>
	<option value="Kiribati">Kiribati</option>
	<option value="Kittsnev">Kittsnev</option>
	<option value="Kuwait">Kuwait</option>
	<option value="Laos">Laos</option>
	<option value="Lesotho">Lesotho</option>
	<option value="Líbano">Líbano</option>
	<option value="Líbia">Líbia</option>
	<option value="Liechtenstein">Liechtenstein</option>
	<option value="Luxemburgo">Luxemburgo</option>
	<option value="Maldivas">Maldivas</option>
	<option value="Malta">Malta</option>
	<option value="Marrocos">Marrocos</option>
	<option value="Mauritânia">Mauritânia</option>
	<option value="Mauritius">Mauritius</option>
	<option value="México">México</option>
	<option value="Moçambique">Moçambique</option>
	<option value="Mônaco">Mônaco</option>
	<option value="Mongólia">Mongólia</option>
	<option value="Namíbia">Namíbia</option>
	<option value="Nepal">Nepal</option>
	<option value="Netherlands Antilles">Netherlands Antilles</option>
	<option value="Nicarágua">Nicarágua</option>
	<option value="Nigéria">Nigéria</option>
	<option value="Noruega">Noruega</option>
	<option value="Nova Zelândia">Nova Zelândia</option>
	<option value="Omã">Omã</option>
	<option value="Panamá">Panamá</option>
	<option value="Paquistão">Paquistão</option>
	<option value="Paraguai">Paraguai</option>
	<option value="Peru">Peru</option>
	<option value="Polinésia Francesa">Polinésia Francesa</option>
	<option value="Polônia">Polônia</option>
	<option value="Portugal">Portugal</option>
	<option value="Qatar">Qatar</option>
	<option value="Quênia">Quênia</option>
	<option value="República Dominicana">República Dominicana</option>
	<option value="Romênia">Romênia</option>
	<option value="Rússia">Rússia</option>
	<option value="Santa Helena">Santa Helena</option>
	<option value="Santa Kitts e Nevis">Santa Kitts e Nevis</option>
	<option value="Santa Lúcia">Santa Lúcia</option>
	<option value="Santo Vicente e Grenadines">Santo Vicente e Grenadines</option>
	<option value="São Vicente">São Vicente</option>
	<option value="Singapura">Singapura</option>
	<option value="Síria">Síria</option>
	<option value="Spiemich">Spiemich</option>
	<option value="Sudão">Sudão</option>
	<option value="Suécia">Suécia</option>
	<option value="Suiça">Suiça</option>
	<option value="Suriname">Suriname</option>
	<option value="Swaziland">Swaziland</option>
	<option value="Tailândia">Tailândia</option>
	<option value="Taiwan">Taiwan</option>
	<option value="Tchecoslováquia">Tchecoslováquia</option>
	<option value="Tonga">Tonga</option>
	<option value="Trinidad e Tobago">Trinidad e Tobago</option>
	<option value="Turksccai">Turksccai</option>
	<option value="Turquia">Turquia</option>
	<option value="Tuvalu">Tuvalu</option>
	<option value="Uruguai">Uruguai</option>
	<option value="Vanuatu">Vanuatu</option>
	<option value="Wallis e Fortuna">Wallis e Fortuna</option>
	<option value="West Bank">West Bank</option>
	<option value="Yémen">Yémen</option>
	<option value="Zaire">Zaire</option>
	<option value="Zimbabwe">Zimbabwe</option>
  </select>
  <br />
  <label class="left_form_label_column">Bairro:</label>
  <input name="photoRegister.district" type="text" class="text" />
  <label>Autor da obra:</label>
  <input name="photoRegister.workAuthor" type="text" class="text" />
  <br />
  <label class="left_form_label_column" >Rua:</label>
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
  	 <input name="terms" type="checkbox" value="read" id="creative_commons_text_checkbox" onclick="javascript:validar(this);"/> Sou o autor da imagem ou possuo permissão expressa do autor para disponibilizá-la no Arquigrafia. 
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
  <input href="#form_window" name="enviar" type="submit" class="submit cursor" value="" />
</p>
</div>

</form>