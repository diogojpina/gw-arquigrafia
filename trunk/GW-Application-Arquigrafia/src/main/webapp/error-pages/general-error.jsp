<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Erro...</title>
    </head>
    <body>
        <h1>Aconteceu um erro.</h1>
        <p>Esta é a versão alfa do Arquigrafia-Brasil, ela esta em desenvolvimento e alguns erros podem acontecer.</p>
        <p>Sua ajuda é muito importante para o projeto. Envie um e-mail informando as ações executadas que causaram o erro para <strong>arquigrafiabrasil@gmail.com</strong>.</p>
        <p>Obrigado pela sua colaboração, iremos corrigir o problema assim que possível!</p>
        <pre><%--
            --%><!--<c:set var="cause" value="${pageContext.exception}" />--><%--
             --%><!--<c:forEach begin="1" end="10">--><%--
                 --%><!--<c:if test="${cause != null}">--><%--
                     --%><!--<c:out value="${cause}" />--><%--
		             --%><!--<c:forEach items="${cause.stackTrace}" var="stackTraceElement">--><%--
		                 --%><!--<c:out value="${stackTraceElement}" />--><%--
		             --%><!--</c:forEach>--><%--
		             --%><!--<c:set var="cause" value="${cause.cause}" />--><%--
		         --%><!--</c:if>--><%--
	         --%><!--</c:forEach>--><%--
         --%></pre>
    </body>
</html>