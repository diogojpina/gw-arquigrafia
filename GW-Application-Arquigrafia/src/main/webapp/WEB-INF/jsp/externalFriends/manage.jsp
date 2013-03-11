<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="external" uri="http://www.groupwareworkbench.org.br/widgets/external-friends" %>
<%@ taglib prefix="activity" uri="http://www.groupwareworkbench.org.br/widgets/activity" %>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Arquigrafia Brasil External Friends</title>
        <style type="text/css">
        #widget {
        	width: 500px;
        	display: inline-block;
        	border: 1px solid;
        	vertical-align: top;
        }
        
           	#activities {
        	display: inline-block; 
        	width: 400px; 
        	border: 1px solid;
        	vertical-align: top;
        	margin-left:100px; 
       	}
 
        	
        </style>
        
        
    </head>
    <body>
        <external:listFriends  idWidget="widget" snName="facebook" userId="${userLogin.id}"/>
        <activity:activities idWidget="activities" userId="${userLogin.id}"/>
        
    </body>
</html>