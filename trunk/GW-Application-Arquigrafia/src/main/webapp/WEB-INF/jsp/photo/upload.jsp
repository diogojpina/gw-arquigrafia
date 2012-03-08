<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
  <h3>Selecione as imagens / pasta para fazer o upload:</h3>
  <br />
  <input type="url" class="url_bar" />
  <input name="selecionar" type="submit" id="select_button" value="" /><br /><br />
</div><br />
<div id="upload_form" action="#" method="get">
  <h3>Características (preenchimento opcional)</h3>
  <p>
  <label>Nome:</label>
  <input name="firstname" type="text" class="text" />
  <label>Autor da imagem:</label>
  <input name="imageauthor" type="text" class="text" />
  <br />
  <label>Cidade:</label>
  <input name="city" type="text" class="text" />
  <label>Data da imagem:</label>
  <input name="imagedate" type="text" class="text" id="imagedate" />
  <br />
  <label>País:</label>
  <select>
    <option value="BR" selected="selected">Basil</option>
    <option value="EUA">Estado Unidos</option>
  </select>
  <label id="state_selector">Estado:</label>
  <select>
    <option value="sp" selected="selected">SP</option>
    <option value="rj">RJ</option>
  </select>
  <br />
  <label>Bairro:</label>
  <input name="quarter" type="text" class="text" />
  <label>Autor da obra:</label>
  <input name="workauthor" type="text" class="text" />
  <br />
  <label>Rua:</label>
  <input name="street" type="text" class="text" />
  <label>Data da obra:</label>
  <input name="workdate" type="text" class="text" id="workdate" />
  <br />
  <label>TAGS:</label>
  <textarea name="tags" class="text"></textarea>
  <label>Descrição:</label>
  <textarea name="decription" class="text"></textarea>
</p>
<p>
  Li e aceito os
  <a href="#" style="text-decoration: underline;">termos de compromisso</a>: 
  <input name="terms" type="checkbox" value="read" /><br />
  <a href="#" id="creative_commons" style="text-decoration:underline;">Creative Commons</a>
</p>
<p>
  <input href="#form_window" name="enviar" type="submit" class="submit cursor" value="" />
</p>
</div>