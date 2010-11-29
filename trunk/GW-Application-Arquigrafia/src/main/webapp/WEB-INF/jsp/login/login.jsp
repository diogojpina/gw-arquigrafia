<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Login</title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css" />
		<script type="text/javascript">
           	function showAboutArquigrafia() {
              	new Boxy($("#aboutDiv").html(), {
               	title: "Sobre o Arquigrafia",
               	modal: true,
               	closeText: "Fechar"
             	}).show();
    		}
    		function setFocus() {
      			var loginForm = document.getElementById("usuariosForm");
      			if (loginForm) {
        			loginForm["user.login"].focus();
      			}
    		}
 		</script>
    </head>
    <body onload="setFocus();">

		<div id="aboutDiv" style="visibility: hidden; display: none;">
			<iframe name="aboutContentFrame" style="width: 450px; height: 500px; opacity: 0.95;" id="aboutContentFrame"
				src="${pageContext.request.contextPath}/groupware-workbench/photo/about.jsp">
			</iframe>
		</div>

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
                        <span class="login_link">
                            <a href="<c:url value="/groupware-workbench/users/${userMgr.id}/forgotPassword" />">Esqueceu a senha?</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        </span>
                    </div>
                </c:if>
                <div class="login_messages">
	        		<a href="${pageContext.request.contextPath}/groupware-workbench/users/${userMgr.id}/register">Cadastre-se</a>&nbsp;&nbsp;&nbsp;&nbsp;
    	    	</div>
            </div>
        </form>
    	<!-- <div class="login_messages">
	    	<a href="#" onclick="return showAboutArquigrafia();">Sobre Arquigrafia</a>&nbsp;&nbsp;&nbsp;&nbsp;
    	</div> -->
    </body>
</html>
