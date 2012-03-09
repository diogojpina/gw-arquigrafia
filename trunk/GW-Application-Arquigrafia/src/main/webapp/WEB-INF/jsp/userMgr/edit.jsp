<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="role" uri="http://www.groupwareworkbench.org.br/widgets/role" %>
<%@ taglib prefix="profile" uri="http://www.groupwareworkbench.org.br/widgets/profile" %>
<%@ taglib prefix="role" uri="http://www.groupwareworkbench.org.br/widgets/role" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>

<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Usu&aacute;rio</title>       
        <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/images/favicon.ico" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/reset.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/arq-common.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/header.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/know_more.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/forms.css"  />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/plugins/sds/css/smoothDivScroll.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/bay.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/footer.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/jquery.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/tagcloud.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/image_wall.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/boxy.css" />"/>
        <script type="text/javascript" src="<c:url value="/js/jquery.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery-ui-1.8.custom.min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/scroll.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.boxy.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.maskedinput.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.validate.js"/>"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $("div#makeMeScrollable").smoothDivScroll({
                    scrollingSpeed: 12,
                    mouseDownSpeedBooster: 3,
                    visibleHotSpots: "always",
                    startAtElementId: "startAtMe"
                });

                $("div#makeMeScrollable2").smoothDivScroll({
                    scrollingSpeed: 12,
                    mouseDownSpeedBooster: 3,
                    visibleHotSpots: "always",
                    startAtElementId: "startAtMe"
                });
            });
        </script>

        <script type="text/javascript">
            $(document).ready(function() {
                $("#form1").validate();
            });
        </script>

        <script type="text/javascript">
            function setFocus() {
                var loginForm = document.getElementById("form1");
                if (loginForm) {
                    loginForm["user.login"].focus();
                }
            }
        </script>

        <profile:scriptProfile />
    </head>
    <body onload="setFocus();">
        <arq:header2 photoInstance="${photoMgr}" />
        <div id="corpo" class="default_div">
            <div id="info" style="display: block;width: 500px; margin-left: auto; margin-right: auto; margin-top: 10px;background: transparent;">
        	<w:conteudoPagina titulo="Perfil de Usu&aacute;rio">
                    <br />
                    <ul>
                        <c:forEach var="error" items="${errors}">
                        <li><c:out value="${error.message}" /> - <c:out value="${error.category}" /></li>
                        </c:forEach>
                    </ul>

                    <form id="form1" class="cmxform" name="dados" method="POST" action="<c:url value="/groupware-workbench/users/${userMgr.id}/saveWithUrl" />" accept-charset="UTF-8" autocomplete="off">
                        <input type="hidden" name="user.id" value="<c:out value="${user.id}" />" />
                        <input type="hidden" id="url" name="url" value="${url}" />
                        <div class="form_1" id="user_retrieve_form">
                            <ul class="field_line_f1">
                                <li class="label_f1"><span>Login:</span></li>
                                <li class="input_f1"><input type="text" class="required" name="user.login" value="<c:out value="${user.login}" />" /></li>
                            </ul>
                            <ul class="field_line_f1">
                                <li class="label_f1"><span>Password:</span></li>
                                <li class="input_f1"><input id="password" class="required" type="password" name="user.password" value="<c:out value="${user.password}" />" /></li>
                            </ul>
                            <ul class="field_line_f1">
                                <li class="label_f1"><span>E-mail:</span></li>
                                <li class="input_f1"><input id="email" class="required email" type="text" name="user.email" value="<c:out value="${user.email}" />" /></li>
                            </ul>
                            <ul class="field_line_f1">
                                <li class="label_f1"><span>Nome:</span></li>
                                <li class="input_f1"><input id="name" class="required" type="text" name="user.name" value="<c:out value="${user.name}" />" /></li>
                            </ul>
                            <ul class="field_line_f1">
                                <li class="label_f1"><span>Endere&ccedil;o da sua foto:</span></li>
                                <li class="input_f1"><input id="photoURL" type="text" name="user.photoURL" value="<c:out value="${user.photoURL}" />" /></li>
                            </ul>
                        </div>

                        <c:if test="${profileMgr.collablet.enabled}">
                            <profile:profile profileMgr="${profileMgr}" user="${user}" />
                        </c:if>

                        <div class="form_1">
                           <input type="submit" class="botao" value="Ok" />
                        </div>
                    </form>
                    <div class="voltar" align="center">
                       <button onclick="javascript:history.back(1);">Voltar</button>
                    </div>
                </w:conteudoPagina>
            </div>
        </div>
        <%--<div>
            <div style="height: 30px; background-color: #fff"></div>
            <arq:footer photoInstance="${photoMgr}" />
        </div>--%>
    </body>
</html>