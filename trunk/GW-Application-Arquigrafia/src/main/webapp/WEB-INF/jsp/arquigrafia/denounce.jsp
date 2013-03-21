<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="denounce">
	<form action="<c:url value="/sendmail/${mailMgrInstance.id}/send"/>" method="post">
		<h2>Denúncia</h2>
		<br />
		<h3>Qual é a sua denúncia?</h3>
		<br />
		<p>
			<label>
			</select> <br /> <label>* Denúncia:</label>
			<textarea cols="34" rows="3" name="mail.message"></textarea>
		</p>
		<p>
			<small>* Preenchimento obrigatório.</small>
		</p>
		<p>
			<input name="enviar" type="submit" class="submit cursor" value="" />
		</p>
		
	</form>
</div>