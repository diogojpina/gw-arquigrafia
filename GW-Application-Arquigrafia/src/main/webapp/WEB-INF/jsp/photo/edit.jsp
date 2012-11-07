<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag" %>

  <style type="text/css">
  	.block { display: block; }
  	form.cmxform label.error { display: none; }	
  </style>
<script type="text/javascript" src="<c:url value="/js/upload-validation.js" />"></script>
<form id="upload_form" name="dados" method="POST" action="<c:url value="/photo/${photoMgr.id}/update" />">
	<input type="hidden" name="_method" value="put"/>
	<input type="hidden" name="user.id" value="${user.id}">
	<input type="hidden" name="photoRegister.id" value="${photoRegister.id}">
	
	<br/><br/>	
	<small>Todos os campos com * são obrigatórios.</small></p>
	
	<div id="upload_form" action="#" method="get">
	  <p>
	  <label class="left_form_label_column">Título:</label>
	  <input name="photoRegister.name" type="text" class="text" value="${photoRegister.name}"/>
	  <label>Autor da imagem:</label>
	  <input name="photoRegister.imageAuthor" type="text" class="text" value="${photoRegister.imageAuthor}"/>
	  <br />
	  <label class="left_form_label_column" >Cidade:</label>
	  <input name="photoRegister.city" type="text" class="text" value="${photoRegister.city}"/>
	  <label>Data da imagem:</label>
	  <input name="photoRegister.dataCriacao" type="text" class="text" id="imagedate" value="${photoRegister.dataCriacaoFormatada}"/>
	  <br />
	  <label class="left_form_label_column">Bairro:</label>
	  <input name="photoRegister.district" type="text" class="text" value="${photoRegister.district}"/>
	  <label>Autor da obra:</label>
	  <input name="photoRegister.workAuthor" type="text" class="text" value="${photoRegister.workAuthor }"/>
	  <br />
	  <label class="left_form_label_column" >Logradouro:</label>
	  <input name="photoRegister.street" type="text" class="text" value="${photoRegister.street}"/>
	  <label>Data da obra:</label>
	  <input name="photoRegister.workdate" type="text" class="text" id="workdate" value="${photoRegister.workdate}"/>
	  <br />
	  <label class="left_form_label_column">Catalogação:</label>
	  <input name="photoRegister.cataloguingTime" type="text" class="text" id="cataloguingTime" value="${photoRegister.formattedCataloguingTime}"/>
	  <label >Tombo:</label>
	  <input name="photoRegister.tombo" type="text" class="text" value="${photoRegister.tombo}"/>
	  <br />
	  <label class="left_form_label_column">Observações:</label>
	  <textarea name="photoRegister.aditionalImageComments" class="input_content">${photoRegister.aditionalImageComments}</textarea>
	  
	  <label>Descrição:</label>
	  <textarea name="photoRegister.description" class="input_content">${photoRegister.description}</textarea>
	  <br />
	  </p>
	
		<p>
		  <input name="enviar" type="submit" class="submit cursor" value="" />
		</p>
	</div>
</form>