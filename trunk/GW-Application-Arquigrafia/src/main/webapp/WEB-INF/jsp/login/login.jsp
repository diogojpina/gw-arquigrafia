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
    		function setFocus() {
      			var loginForm = document.getElementById("usuariosForm");
      			if (loginForm) {
        			loginForm["user.login"].focus();
      			}
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
            <div class="info_box">
            <h1 class="title_text">Bem vindo ao Arquigrafia-Brasil! </h1>
            <p class="info_text">O projeto Arquigrafia-Brasil propõe a construção coletiva e colaborativa de um acervo digital de imagens da arquitetura brasileira. Valendo-se da dinâmica de um rede social na Web 2.0, o Arquigrafia poderá reunir fotografias, desenhos e vídeos de todos os recantos do país, produzidos por arquitetos, estudantes, professores, fotógrafos e pessoas interessadas em arquitetura, conformando assim um acervo iconográfico da arquitetura brasileira, que depois poderá ser ampliado à arquitetura mundial. Disponível on line para acesso convencional e em dispositivos móveis (Android), esse acervo de imagens digitais em contínua expansão é aberto ao público, garantindo contudo o gerenciamento dos direitos autorais sobre as imagens.   </p>
            </div>
        </form>
    </body>
</html>
