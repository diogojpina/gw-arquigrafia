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
  <h2>Upload</h2><br />
  <h3>Selecione a imagem para o upload:</h3>
  <br />
  <!-- AAMM --><input id="imageUpload" type="file" name="foto" value="" /><br /><!-- AAMM -->
  <!-- <input type="url" class="url_bar" />
  <input name="selecionar" type="submit" id="select_button" value="" /><br /><br />  -->
</div><br />
<div id="upload_form" action="#" method="get">
  <h3>Características (preenchimento opcional)</h3>
  <p>
  <label>Nome:</label>
  <input name="photoRegister.name" type="text" class="text" />
  <label>Autor da imagem:</label>
  <input name="photoRegister.copyRights" type="text" class="text" />
  <br />
  <label>Cidade:</label>
  <input name="photoRegister.city" type="text" class="text" />
  <label>Data da imagem:</label>
  <input name="imagedate" type="text" class="text" id="imagedate" />
  <br />
  <label>País:</label>
  <select name="photoRegister.country">
    <option value="BR" selected="selected">Basil</option>
    <option value="EUA">Estado Unidos</option>
  </select>
  <label id="state_selector">Estado:</label>
  <select name="photoRegister.state">
    <option value="sp" selected="selected">SP</option>
    <option value="rj">RJ</option>
  </select>
  <br />
  <label>Bairro:</label>
  <input name="photoRegister.district" type="text" class="text" />
  <label>Autor da obra:</label>
  <input name="photoRegister.workAuthor" type="text" class="text" />
  <br />
  <label>Rua:</label>
  <input name="photoRegister.street" type="text" class="text" />
  <label>Data da obra:</label>
  <input name="photoRegister.workdate" type="text" class="text" id="workdate" />
  <br />
  <label>TAGS:</label>
  <!-- <textarea name="tags" class="text"></textarea> -->
  <!-- <tag:scriptTags />
  <tag:selectTags tagMgr="${tagMgr}" /> -->
  <tag:setTags tagMgr="${tagMgr}" entity="${photo}" />
  
  <label>Descrição:</label>
  <textarea name="photoRegister.description" class="text"></textarea>
  <br />
  </p>
  
     Escolho a licença <a href="http://creativecommons.org/licenses/?lang=pt_BR" id="creative_commons" target="_blank" style="text-decoration:underline; line-height:16px;">Creative Commons</a>, para publicar minha obra, com as seguintes permissões:
      <br /><br />
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