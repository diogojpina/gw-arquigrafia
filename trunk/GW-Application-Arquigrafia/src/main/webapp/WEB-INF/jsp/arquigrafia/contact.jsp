<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="contact_us_form">
	<form action="<c:url value="/sendmail/${mailMgrInstance.id}/send"/>" method="post">
		<h2>Fale conosco</h2>
		<br />
		<h3>Envie suas criticas, dúvidas e sugestões:</h3>
		<br />
		<p>
			<label>* Nome:</label> <input name="mail.firstname" type="text"
				class="text" /> <br /> <label>* Email:</label> <input
				name="mail.email" type="text" class="text" /> <br /> <label>*
				Assunto:</label> <select name="mail.subject">
				<option value="duvida" selected="selected">Dúvida</option>
				<option value="critica">Crítica</option>
				<option value="sugestao">Sugestão</option>
				<option value="elogio">Elogio</option>
				<option value="outros">Outros</option>
			</select> <br /> <label>* Mensagem:</label>
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