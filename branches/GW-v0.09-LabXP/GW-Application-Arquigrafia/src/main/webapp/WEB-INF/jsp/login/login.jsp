<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Login</title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/know_more.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
		<script type="text/javascript">
    		function setFocus() {
      			var loginForm = document.getElementById("usuariosForm");
      			if (loginForm) {
        			loginForm["user.login"].focus();
      			}
            	$("#login_box").hide();
	            $("#login_easter_eeg").click(function(){
	                $("#login_box").slideDown();
	            });
    		}
 		</script>
    </head>
    <body onload="setFocus();">
	    <form id="usuariosForm" method="post" name="loginForm" action="<c:url value="/groupware-workbench/users/${userMgr.id}/login" />">
            <div class="login_box">
                <div class="login_fields">
                    <div class="login_fields_1">
                        <ul>
                            <li><span class="login_label">Login</span></li>
                            <li><input tabindex="1" name="user.login" type="text" class="box" id="login" size="23" maxlength="30" /></li>
                        </ul>
                    </div>
                    <div class="login_fields_2">
                        <ul>
                            <li><span class="login_label">Senha</span></li>
                            <li><input tabindex="2" name="user.password" type="password" class="box" id="senha" size="23" maxlength="30" /></li>
                        </ul>
                    </div>
                    <div class="login_button">
                        <input tabindex="3" name="Submit" type="submit" class="botao" id="Submit" value="Entrar" />
                    </div>
                   
                </div>
                
                <div class="login_box_clear"></div>
                <c:if test="${not sessionScope['log']}">
                    <div class="login_messages">
                        <c:if test="${sessionScope['log'] == false}">
                            <span class="login_error">Login ou senha incorretos</span>
                        </c:if>
                    </div>
                </c:if>
            </div>
            
        </form>
        <arq:know_more />
    </body>
</html>
