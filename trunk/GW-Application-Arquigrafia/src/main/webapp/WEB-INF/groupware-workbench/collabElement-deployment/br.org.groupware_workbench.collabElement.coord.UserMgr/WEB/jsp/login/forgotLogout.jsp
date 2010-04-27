<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <meta http-equiv="cache-control" content="no-cache">
        <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="middle"><table width="60%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
      <tr>
        <td bgcolor="#FFFFFF"><table width="90%" border="0" align="center" cellpadding="2" cellspacing="2">
            <tr>
              <td><div align="center"><b><font size="5">Groupware Workbench</font></b></div></td>
            </tr>
            <tr>
              <td><form id="usuariosForm" method="post" name="loginForm" action='<c:url value="/groupware-workbench/${collablet.id}/userMgr/${userMgr.id}/getPassword" />'>

                  <table width="100%" border="0" align="center" bordercolor="#9B9B9B">
                    <tr>
                      <td><table border="0" align="center" bordercolor="#9B9B9B">
                          <tr>
                            <td colspan="4"><div align="center"></div></td>
                          </tr>
                          <tr>
                            <td rowspan="2"><div align="right"><img src="<c:url value="/images/forgotPassword.jpg" />" width="202" height="67" alt="Login"></div>
                            <div align="right"></div></td>
                            <td height="20" valign="baseline" bgcolor="#FFFFFF"><span class="style3">Informe seu email abaixo:</span></td>
                            <td bgcolor="#FFFFFF">&nbsp;</td>
                          </tr>
                          <tr>
                            <td valign="top" bgcolor="#FFFFFF"><label>
                              <input name="user.email" type="text" class="box" id="email" size="15" maxlength="30" />
                            </label></td>
                            <td valign="top" bgcolor="#FFFFFF"><input name="Submit" type="submit" class="botao" id="Submit" value="Enviar" /></td>
                          </tr>

                          <tr>
                            <td colspan="4">&nbsp;</td>
                          </tr>

                          <c:set var="env" value="${sessionScope.emailEnviado}" />
                          <c:choose>
                              <c:when test="${env != null and not env}">
                              <tr>
                                <td colspan="4"><div align="right"><span class="style8">E-mail não encontrado</span></div></td>
                              </tr> 
                               <tr>
                                 <td colspan="4"><div align="left"><span class="style8"><a href="<c:url value="/groupware-workbench/${collablet.id}/userMgr/login"/>">Voltar</a></span></div></td>
                               </tr>
                          </c:when>
                            <c:when test="${env}">
                              <tr>
                                <td colspan="4"><div align="right"><span class="style8">E-mail enviado com sucesso! </span></div></td>
                              </tr> 
                               <tr>
                                 <td colspan="4"><div align="left"><span class="style8"><a href="<c:url value="/groupware-workbench/${collablet.id}/userMgr/login"/>">Voltar</a></span></div></td>
                               </tr>
                          </c:when>

                           <c:otherwise>
                              <tr>
                                <td colspan="4"><div align="left"><span class="style8"><a href="<c:url value="/groupware-workbench/${collablet.id}/userMgr/logout"/>">Voltar</a></span></div></td>
                              </tr>
                           </c:otherwise>
					</c:choose>
                      </table></td>
                    </tr>
                  </table>
              </form></td>
            </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
    </body>
</html>
