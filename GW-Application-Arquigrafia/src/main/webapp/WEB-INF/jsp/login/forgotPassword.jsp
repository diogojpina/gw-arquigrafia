<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Recuperar senha</title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.js"></script>
    </head>
    <body>
        <form id="usuariosForm" method="post" name="loginForm" action='<c:url value="/groupware-workbench/users/getPassword" />'>
            <div class="login_box">
                <div class="login_fields">
                    <div>
                        <ul>
                            <li><span class="login_label">Informe seu e-mail:</span></li>
                            <li><input tabindex="1" name="user.email" type="text" class="box" id="email" size="45" /></li>
                        </ul>
                    </div>
                    <div class="login_button">
                        <input tabindex="3" name="Submit" type="submit" class="botao" id="Submit" value="Enviar" />
                    </div>
                </div>
                <div class="login_box_clear"></div>
                <div class="login_messages">
                    <c:set var="env" value="${sessionScope.emailEnviado}" />
                    <c:if test="${env.collablet.enabled and not env}">
                        <span class="login_error">E-mail não encontrado</span>
                    </c:if>
                    <c:if test="${sessionScope['log'] == false}">
                        <span class="login_error">E-mail enviado com sucesso</span>
                    </c:if>
                    <span class="login_link">
                        <a href="<c:url value="/groupware-workbench/users/${userMgr.id}/login" />">Voltar</a> &nbsp;&nbsp;&nbsp;&nbsp;
                    </span>
                </div>
            </div>
        </form>
    </body>
</html>
