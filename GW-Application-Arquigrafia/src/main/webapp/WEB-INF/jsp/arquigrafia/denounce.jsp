<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="denounce">
	<form action="<c:url value="/sendmail/${mailMgrInstance.id}/send"/>" method="post">
		<h2>Den�ncia</h2>
		<br />
		<h3>Qual � a sua den�ncia?</h3>
		<br />
		<p>
			<label>
			</select> <br /> <label>* Den�ncia:</label>
			<textarea cols="34" rows="3" name="mail.message"></textarea>
		</p>
		<p>
			<small>* Preenchimento obrigat�rio.</small>
		</p>
		<p>
			<input name="enviar" type="submit" class="submit cursor" value="" />
		</p>
		
	</form>
</div>