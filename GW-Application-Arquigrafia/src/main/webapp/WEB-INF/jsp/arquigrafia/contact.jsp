<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="contact_us_form">
	<form action="<c:url value="/sendmail/${mailMgrInstance.id}/send"/>" method="post">
		<h2>Fale conosco</h2>
		<br />
		<h3>Envie suas criticas, d�vidas e sugest�es:</h3>
		<br />
		<p>
			<label>* Nome:</label> <input name="mail.firstname" type="text"
				class="text" /> <br /> <label>* Email:</label> <input
				name="mail.email" type="text" class="text" /> <br /> <label>*
				Assunto:</label> <select name="mail.subject">
				<option value="duvida" selected="selected">D�vida</option>
				<option value="critica">Cr�tica</option>
				<option value="sugestao">Sugest�o</option>
				<option value="elogio">Elogio</option>
				<option value="outros">Outros</option>
			</select> <br /> <label>* Mensagem:</label>
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