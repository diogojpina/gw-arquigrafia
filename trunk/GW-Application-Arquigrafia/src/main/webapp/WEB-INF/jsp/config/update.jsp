<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.groupwareworkbench.org.br/widgets/security" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Executar update a partir do xml</title>
        <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/images/favicon.ico" />"/>
    </head>
    <body>
    	<s:check name="X-X-admin">
	        <form name="uploadForm" method="post" enctype="multipart/form-data" action="<c:url value="/config/update" />">
		        <label>Arquivo:</label>
		        <select name="fileName" class="input_content">
			  		<c:forEach items="${files}" var="file">
			  			<option value="${file}">${file}</option>
			  		</c:forEach>
			  	</select>
	            <input type="submit" name="Submit" value="send" />
	        </form>
	        <a href="<c:url value="/config/upload" />">Enviar arquivo xml de configuração</a>
        </s:check>
    </body>
</html>