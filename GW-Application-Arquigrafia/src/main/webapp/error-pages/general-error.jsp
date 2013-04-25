<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	String result;

	//smtp.gmail.com", "arquigrafiabrasil@gmail.com", "4rquigr4fi4", 465
	final String username = "arquigrafiabrasil@gmail.com";
	final String password = "4rquigr4fi4";

	Properties props = new Properties();
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.starttls.enable", "true");
	props.put("mail.smtp.host", "smtp.gmail.com");
	props.put("mail.smtp.port", "587");

	String errorMessageSubject = "Mensagem automática de erro - ";
	String errorMessageMessage = "Mensagem automática de erro gerada pelo arquigrafia. ";
	
	try {
		StringWriter sw = new StringWriter();
		exception.printStackTrace(new PrintWriter(sw));
		String stacktrace = sw.toString();
		
		errorMessageSubject += exception.getCause();
		errorMessageMessage += "";
		errorMessageMessage += "\n\n  O código do erro é : ";
		errorMessageMessage += request.getAttribute("javax.servlet.error.status_code");
		errorMessageMessage += "\n\n  O id do usuário logado é: ";
		errorMessageMessage += session.getAttribute("userLoginId");
		errorMessageMessage += "\n\n  O nome do usuário logado é: ";
		errorMessageMessage += session.getAttribute("userLoginName");
		errorMessageMessage += "\n\n  A aplicação está no servidor: ";
		errorMessageMessage += request.getServerName();
		errorMessageMessage += "\n\n  A pagina requisitada no momento do erro é: ";
		errorMessageMessage += request.getAttribute("javax.servlet.error.request_uri");
		errorMessageMessage += "\n\n  A classe que gerou a excessão é: ";
		errorMessageMessage += exception.getClass();
		errorMessageMessage += "\n\n  O tipo da excessão é: ";
		errorMessageMessage += request.getAttribute("javax.servlet.error.exception_type");
		errorMessageMessage += "\n\n  A mensagem de erro é: ";
		errorMessageMessage += request.getAttribute("javax.servlet.error.message");
		errorMessageMessage += "\n\n  A string da excessão é: ";
		errorMessageMessage += exception.toString();
		errorMessageMessage += "\n\n  A pilha de execução no momento é:"; 
		errorMessageMessage += stacktrace;
		errorMessageMessage += "\n\n  Atenciosamente ";
		errorMessageMessage += "\n\n  Equipe do Arquigrafia. ";
	} catch(Exception e) {
		errorMessageSubject += " NÃO FOI POSSIVEL CRIAR O EMAIL CORRETAMENTE";
		errorMessageMessage += "\n\n  NÃO FOI POSSIVEL CRIAR O EMAIL CORRETAMENTE";
	}
	
	try {

		Session sessions = Session.getInstance(props,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(username,
								password);
					}
				});
		
		Message message = new MimeMessage(sessions);
		message.setFrom(new InternetAddress(
				"arquigrafiabrasil@gmail.com"));
		message.setRecipients(Message.RecipientType.TO, InternetAddress
				.parse("strausmm@gmail.com"));
		message.setSubject(errorMessageSubject);
		message.setText(errorMessageMessage);
		Transport.send(message);

		result = "<p>Sua ajuda é muito importante para o projeto. Caso o problema persista envie um email " 
			+ "informando as ações executadas que causaram o erro para  "
			+ " <a href=\"mailto:arquigrafiabrasil@gmail.com\">arquigrafiabrasil@gmail.com</a>.</p>";

	} catch (MessagingException e) {
		//throw new RuntimeException(e);

		result = "<p>Sua ajuda é muito importante para o projeto. Envie um e-mail "
			+ "informando as ações executadas que causaram o erro para  "
			+ " <a href=\"mailto:arquigrafiabrasil@gmail.com\">arquigrafiabrasil@gmail.com</a>.</p>";
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Erro...</title>
	</head>
	<body>
		<p>Aconteceu um erro.</p>
		
		<p>Esta é a versão Beta 2013 do Arquigrafia-Brasil, em fase de implementação, e alguns erros podem acontecer.</p>
		
		<% out.println( result + "\n"); %>
		
		<p>Obrigado por sua colaboração, e iremos corrigir o problema assim que possível!</p>
	</body>
</html>
