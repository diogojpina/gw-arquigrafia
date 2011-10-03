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
        <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/images/favicon.ico" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/reset.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/login.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/know_more.css" />"/>
        <script type="text/javascript" src="<c:url value="/js/jquery.js"/>"></script>
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
	    <form id="usuariosForm" method="post" name="loginForm" action="<c:url value="/j_spring_security_check" />">
            <div class="login_box">
                <div class="login_fields">
                    <div class="login_fields_1">
                        <ul>
                            <li><span class="login_label">Login</span></li>
                            <li><input tabindex="1" name="j_username" type="text" class="box" id="login" size="23" maxlength="30" /></li>
                        </ul>
                    </div>
                    <div class="login_fields_2">
                        <ul>
                            <li><span class="login_label">Senha</span></li>
                            <li><input tabindex="2" name="j_password" type="password" class="box" id="senha" size="23" maxlength="30" /></li>
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

                <div class="login-buttons">
                      <a class="google" style="margin-right: 5px;" href="<c:url value="/groupware-workbench/users/${userMgr.id}/loginOrkutAuth"/>">
                        <img style="border-style: solid; border-width: 1px;"  src="${pageContext.request.contextPath}/images/google.png"/>
                      </a> 
                      <a class="facebook" style="margin-left: 5px; margin-right: 5px;" href="<c:url value="/groupware-workbench/users/${userMgr.id}/loginFacebookAuth?auth=s"/>">
                        <img src="${pageContext.request.contextPath}/images/facebook.jpeg"/>
                      </a>
                      <a class="twitter" style="margin-left: 5px;" href="<c:url value="/groupware-workbench/users/${userMgr.id}/loginTwitterAuth"/>">
                        <img src="${pageContext.request.contextPath}/images/twitter-signin.png"/>
                      </a>
                 </div>
                
                
            </div>
            
        </form>
        <arq:know_more />
    </body>
</html>
