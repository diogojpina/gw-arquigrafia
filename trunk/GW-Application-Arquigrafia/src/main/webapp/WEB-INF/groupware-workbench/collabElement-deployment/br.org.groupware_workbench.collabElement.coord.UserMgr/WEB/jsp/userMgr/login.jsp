<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Autentica&ccedil;&atilde;o</title>
        <link href="${pageContext.request.contextPath}/css/interface.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="middle">
                    <table width="60%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
                        <tr>
                            <td bgcolor="#FFFFFF">
                                <table width="90%" border="0" align="center" cellpadding="2" cellspacing="2">
                                    <tr>
                                        <td>
                                            <div align="center">
                                                <b><font size="5">Groupware Workbench Test with Vraptor3</font></b>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <form id="loginForm" method="post" name="loginForm" action="<c:url value="/groupware-workbench/${param.idCollabletInstance}/doLogin" />" accept-charset="UTF-8">
                                                <table width="100%" border="0" align="center" bordercolor="#9B9B9B">
                                                    <tr>
                                                        <td>
                                                            <table border="0" align="center" bordercolor="#9B9B9B">
                                                                <tr>
                                                                    <td colspan="4">
                                                                        <div align="center"></div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td rowspan="2">
                                                                        <div align="right">
                                                                            <img src="images/loginSistea.jpg" width="20" height="67" alt="" />
                                                                        </div>
                                                                        <div align="right">
                                                                        </div>
                                                                    </td>
                                                                    <td height="20" valign="baseline" bgcolor="#FFFFFF">
                                                                        <span class="style3">Login</span>
                                                                    </td>
                                                                    <td valign="baseline" bgcolor="#FFFFFF">
                                                                        <span class="style3">Senha</span>
                                                                    </td>
                                                                    <td bgcolor="#FFFFFF">&nbsp;</td>
                                                                </tr>
                                                                <tr>
                                                                    <td valign="top" bgcolor="#FFFFFF">
                                                                        <label><input name="user.login" type="text" class="box" size="15" maxlength="10" /></label>
                                                                    </td>
                                                                    <td valign="top" bgcolor="#FFFFFF">
                                                                        <input name="user.senha" type="password" class="box" id="senha" size="15" maxlength="15" />
                                                                    </td>
                                                                    <td valign="top" bgcolor="#FFFFFF">
                                                                        <input name="Submit" type="submit" class="botao" id="Submit" value="Entrar" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4">&nbsp;</td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4">
                                                                        <div align="right"><span class="style8"></span></div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </form>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
</html>