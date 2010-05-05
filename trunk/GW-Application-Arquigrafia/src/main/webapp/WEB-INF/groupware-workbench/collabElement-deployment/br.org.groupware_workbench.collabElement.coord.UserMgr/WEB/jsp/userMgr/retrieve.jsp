<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/role" prefix="role" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/profile" prefix="profile" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Usu&aacute;rio</title>
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.maskedinput.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $("#form1").validate();
            });
        </script>
        <profile:ScriptProfile />
    </head>
    <body>
        <Widgets:Topo collabletInstance="${collabletInstance}" />
        <Widgets:ConteudoPagina titulo="Usu&aacute;rio">
            <br/>
            <ul>
                <c:forEach var="error" items="${errors}">
                    <li><c:out value="${error.message}" /> - <c:out value="${error.category}" /></li>
                </c:forEach>
            </ul>

            <form id="form1" class="cmxform" name="dados" method="POST" action="<c:url value="/groupware-workbench/${collabletInstance.id}/userMgr/${userMgr.id}" />" accept-charset="UTF-8">
                <input type="hidden" name="user.id" value="<c:out value="${user.id}" />" />
                <input type="hidden" name="user.idInstance" value="${collabletInstance.id}" />
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
                </div>

                <c:if test="${profileMgr != null}">
                    <profile:Profile profileMgr="${profileMgr}" genericEntity="${user}" />
                </c:if>

                <div class="subsection_f1">
                    <fieldset>
                        <c:if test="${roleMgr != null}">
                            <legend><span class="subtitle_f1">Atribuir pap&eacute;is:</span></legend>
                            <role:SelectRole roleMgr="${roleMgr}" genericEntity="${user}" />
                        </c:if>
                    </fieldset>
                </div>

                <div class="form_1">
                    <ul class="bt_line_f1">
                        <li class="bt_cell_submit">
                            <input type="submit" class="botao" value="Ok" />
                        </li>
                        <li class="bt_cell_submit">
                            <input type="button" class="botao" value="Cancela" onclick="history.back()" />
                        </li>
                    </ul>
                </div>
            </form>
        </Widgets:ConteudoPagina>
    </body>
</html>