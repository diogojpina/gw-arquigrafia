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
  <label class="left_form_label_column">T�tulo:</label>
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
	<option value="AP">Amap�</option>
    <option value="BA">Bahia</option>
    <option value="CE">Cear�</option>
    <option value="DF">Distrito Federal</option>
    <option value="ES">Espirito Santo</option>
    <option value="GO">Goi�s</option>
    <option value="MA">Maranh�o</option>
    <option value="MG">Minas Gerais</option>
    <option value="MS">Mato Grosso do Sul</option>
    <option value="MT">Mato Grosso</option>
    <option value="PA">Par�</option>
    <option value="PB">Para�ba</option>
    <option value="PE">Pernambuco</option>
    <option value="PI">Piau�</option>
    <option value="PR">Paran�</option>
    <option value="RJ">Rio de Janeiro</option>
    <option value="RN">Rio Grande do Norte</option>
    <option value="RO">Rond�nia</option>
    <option value="RR">Roraima</option>
    <option value="RS">Rio Grande do Sul</option>
    <option value="SC">Santa Catarina</option>
    <option value="SE">Sergipe</option>
    <option value="SP">S�o Paulo</option>
    <option value="TO">Tocantins</option>
  </select>
  <label>Pa�s:</label>
  <select name="photoRegister.country" class="input_content">
	<option value="Afeganist�o">Afeganist�o</option>
	<option value="�frica do Sul">�frica do Sul</option>
	<option value="Alb�nia">Alb�nia</option>
	<option value="Alemanha">Alemanha</option>
	<option value="Am�rica Samoa">Am�rica Samoa</option>
	<option value="Andorra">Andorra</option>
	<option value="Angola">Angola</option>
	<option value="Anguilla">Anguilla</option>
	<option value="Antartida">Antartida</option>
	<option value="Antigua">Antigua</option>
	<option value="Antigua e Barbuda">Antigua e Barbuda</option>
	<option value="Ar�bia Saudita">Ar�bia Saudita</option>
	<option value="Argentina">Argentina</option>
	<option value="Aruba">Aruba</option>
	<option value="Australia">Australia</option>
	<option value="Austria">Austria</option>
	<option value="Bahamas">Bahamas</option>
	<option value="Bahrain">Bahrain</option>
	<option value="Barbados">Barbados</option>
	<option value="B�lgica">B�lgica</option>
	<option value="Belize">Belize</option>
	<option value="Bermuda">Bermuda</option>
	<option value="Bhutan">Bhutan</option>
	<option value="Bol�via">Bol�via</option>
	<option value="Botswana">Botswana</option>
	<option value="Brasil" selected="selected" >Brasil</option>
	<option value="Brunei">Brunei</option>
	<option value="Bulg�ria">Bulg�ria</option>
	<option value="Burundi">Burundi</option>
	<option value="Cabo Verde">Cabo Verde</option>
	<option value="Camboja">Camboja</option>
	<option value="Canad�">Canad�</option>
	<option value="Chade">Chade</option>
	<option value="Chile">Chile</option>
	<option value="China">China</option>
	<option value="Cingapura">Cingapura</option>
	<option value="Col�mbia">Col�mbia</option>
	<option value="Djibouti">Djibouti</option>
	<option value="Dominicana">Dominicana</option>
	<option value="Emirados �rabes">Emirados �rabes</option>
	<option value="Equador">Equador</option>
	<option value="Espanha">Espanha</option>
	<option value="Estados Unidos">Estados Unidos</option>
	<option value="Fiji">Fiji</option>
	<option value="Filipinas">Filipinas</option>
	<option value="Finl�ndia">Finl�ndia</option>
	<option value="Fran�a">Fran�a</option>
	<option value="Gab�o">Gab�o</option>
	<option value="Gaza Strip">Gaza Strip</option>
	<option value="Ghana">Ghana</option>
	<option value="Gibraltar">Gibraltar</option>
	<option value="Granada">Granada</option>
	<option value="Gr�cia">Gr�cia</option>
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
	<option value="�ndia">�ndia</option>
	<option value="Indon�sia">Indon�sia</option>
	<option value="Inglaterra">Inglaterra</option>
	<option value="Ir�">Ir�</option>
	<option value="Iraque">Iraque</option>
	<option value="Irlanda">Irlanda</option>
	<option value="Irlanda do Norte">Irlanda do Norte</option>
	<option value="Isl�ndia">Isl�ndia</option>
	<option value="Israel">Israel</option>
	<option value="It�lia">It�lia</option>
	<option value="Iugosl�via">Iugosl�via</option>
	<option value="Jamaica">Jamaica</option>
	<option value="Jap�o">Jap�o</option>
	<option value="Jersey">Jersey</option>
	<option value="Kirgizst�o">Kirgizst�o</option>
	<option value="Kiribati">Kiribati</option>
	<option value="Kittsnev">Kittsnev</option>
	<option value="Kuwait">Kuwait</option>
	<option value="Laos">Laos</option>
	<option value="Lesotho">Lesotho</option>
	<option value="L�bano">L�bano</option>
	<option value="L�bia">L�bia</option>
	<option value="Liechtenstein">Liechtenstein</option>
	<option value="Luxemburgo">Luxemburgo</option>
	<option value="Maldivas">Maldivas</option>
	<option value="Malta">Malta</option>
	<option value="Marrocos">Marrocos</option>
	<option value="Maurit�nia">Maurit�nia</option>
	<option value="Mauritius">Mauritius</option>
	<option value="M�xico">M�xico</option>
	<option value="Mo�ambique">Mo�ambique</option>
	<option value="M�naco">M�naco</option>
	<option value="Mong�lia">Mong�lia</option>
	<option value="Nam�bia">Nam�bia</option>
	<option value="Nepal">Nepal</option>
	<option value="Netherlands Antilles">Netherlands Antilles</option>
	<option value="Nicar�gua">Nicar�gua</option>
	<option value="Nig�ria">Nig�ria</option>
	<option value="Noruega">Noruega</option>
	<option value="Nova Zel�ndia">Nova Zel�ndia</option>
	<option value="Om�">Om�</option>
	<option value="Panam�">Panam�</option>
	<option value="Paquist�o">Paquist�o</option>
	<option value="Paraguai">Paraguai</option>
	<option value="Peru">Peru</option>
	<option value="Polin�sia Francesa">Polin�sia Francesa</option>
	<option value="Pol�nia">Pol�nia</option>
	<option value="Portugal">Portugal</option>
	<option value="Qatar">Qatar</option>
	<option value="Qu�nia">Qu�nia</option>
	<option value="Rep�blica Dominicana">Rep�blica Dominicana</option>
	<option value="Rom�nia">Rom�nia</option>
	<option value="R�ssia">R�ssia</option>
	<option value="Santa Helena">Santa Helena</option>
	<option value="Santa Kitts e Nevis">Santa Kitts e Nevis</option>
	<option value="Santa L�cia">Santa L�cia</option>
	<option value="Santo Vicente e Grenadines">Santo Vicente e Grenadines</option>
	<option value="S�o Vicente">S�o Vicente</option>
	<option value="Singapura">Singapura</option>
	<option value="S�ria">S�ria</option>
	<option value="Spiemich">Spiemich</option>
	<option value="Sud�o">Sud�o</option>
	<option value="Su�cia">Su�cia</option>
	<option value="Sui�a">Sui�a</option>
	<option value="Suriname">Suriname</option>
	<option value="Swaziland">Swaziland</option>
	<option value="Tail�ndia">Tail�ndia</option>
	<option value="Taiwan">Taiwan</option>
	<option value="Tchecoslov�quia">Tchecoslov�quia</option>
	<option value="Tonga">Tonga</option>
	<option value="Trinidad e Tobago">Trinidad e Tobago</option>
	<option value="Turksccai">Turksccai</option>
	<option value="Turquia">Turquia</option>
	<option value="Tuvalu">Tuvalu</option>
	<option value="Uruguai">Uruguai</option>
	<option value="Vanuatu">Vanuatu</option>
	<option value="Wallis e Fortuna">Wallis e Fortuna</option>
	<option value="West Bank">West Bank</option>
	<option value="Y�men">Y�men</option>
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
  
  <label>Descri��o:</label>
  <textarea name="photoRegister.description" class="input_content"></textarea>
  <br />
  </p>
  <p> 
  	 <input name="terms" type="checkbox" value="read" id="creative_commons_text_checkbox" onclick="javascript:validar(this);"/> Sou o autor da imagem ou possuo permiss�o expressa do autor para disponibiliz�-la no Arquigrafia. 
  	 <br />
     Escolho a licen�a <a href="http://creativecommons.org/licenses/?lang=pt_BR" id="creative_commons" target="_blank" style="text-decoration:underline; line-height:16px;">Creative Commons</a>, para publicar minha obra, com as seguintes permiss�es:
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
      Permitir modifica��es em sua obra?
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