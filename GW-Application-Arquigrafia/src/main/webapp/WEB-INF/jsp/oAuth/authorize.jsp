<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Arquigrafia Brasil OAuth Provider</title>
        <style type="text/css">
        form {
        	display: inline;
        }
        h1 {
        	color: white;
        }
        </style>
    </head>
    <body style="color: #A6A6A6; background-color: black">


	<div style="width: 700px; margin: auto; border: 1px solid; padding: 20px;">
        <h1>Arquigrafia Brasil OAuth Provider</h1>
	    <h3>"${appDesc}GW-Application-FAQ" está intentando acessar suas informações.</h3>
	    <div style="display: block; text-align: center">
	    	<div style="display: inline;">
			    <form name="authZForm" action='<c:url value="/authorize"/>' method="POST">
			        <input type="hidden" name="oauth_token" value="${token}"/>
			        <input type="hidden" name="oauth_callback" value="${callback}"/>
			        <input type="submit" name="Authorize" value="Autorizar"/>
			    </form>
		    </div>
			<div style="display: inline;">
			    <form name="authZForm" action='<c:url value="/"/>' method="GET">
			        <input type="submit" name="Authorize" value="Denegar"/>
			    </form>
		    </div>
	    </div>
    
    </div>

    </body>
</html>
