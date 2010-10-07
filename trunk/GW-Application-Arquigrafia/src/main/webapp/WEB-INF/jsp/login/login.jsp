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
    </head>
    <body>
        <form id="usuariosForm" method="post" name="loginForm" action='<c:url value="/groupware-workbench/users/${userMgr.id}/login" />'>
            <div id="login_box">
                <div id="lb_title"><span class="style1">Groupware Workbench</span></div>
                <div id="lb_logo"><img src="<c:url value="/images/loginSistea.jpg" />" width="202" height="67" alt="Login" /></div>
                <div id="lb_fields">
                    <div id="lb_fields_1">
                        <ul>
                            <li><span class="style3">Login</span></li>
                            <li><input tabindex="1" name="user.login" type="text" class="box" id="login" size="15" maxlength="30" /></li>
                        </ul>
                    </div>
                    <div id="lb_fields_3">
                        <input tabindex="3" name="Submit" type="submit" class="botao" id="Submit" value="Entrar" />
                    </div>
                    <div id="lb_fields_2">
                        <ul>
                            <li><span class="style3">Senha</span></li>
                            <li><input tabindex="2" name="user.password" type="password" class="box" id="senha" size="15" maxlength="30" /></li>
                        </ul>
                    </div>
                </div>
                <%-- TODO: Renomear style8 para algum nome melhor. --%>
                <div id="lb_messages">
                    <c:if test="${sessionScope['log'] == null}">
                        <div id="lb_message_1" align="right">
                            <a href="<c:url value="/groupware-workbench/users/${userMgr.id}/forgotLogout"/>">Esqueceu a senha?</a>
                            <span class="style8"></span>
                        </div>
                    </c:if>
                    <c:if test="${sessionScope['log'] != null}">
                        <c:if test="${!sessionScope['log']}">
                            <div id="lb_message_2" align="right">
                                <span class="style8">Login ou senha incorretos</span>
                            </div>
                            <div id="lb_message_3" align="right">
                                <a href="<c:url value="/groupware-workbench/users/${userMgr.id}/forgotLogout"/>">Esqueceu a senha?</a>
                                <span class="style8"></span>
                            </div>
                        </c:if>
                    </c:if>
                </div>
            </div>
        </form>
    </body>
</html>
