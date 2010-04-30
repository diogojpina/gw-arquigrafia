<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag" prefix="TagMgr" %>
<%-- TODO: Reformatar essa p�gina. --%>
<html>
    <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <meta http-equiv="cache-control" content="no-cache">
        <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/css/arq-common.css" />
		<style type="text/css">#vlightbox a#vlb{display:none}</style> 
		<link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/visual_lightbox/engine/css/visuallightbox.css" type="text/css" media="screen" /> 
		<link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/visual_lightbox/engine/css/vlightbox.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/sds/css/smoothDivScroll.css" type="text/css" media="screen" />
		<link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/css/footer.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/plugins/sds/js/scroll.js" type="text/javascript"></script>
		<script type="text/javascript">
		$(function() {
			$("div#makeMeScrollable").smoothDivScroll({scrollingSpeed: 12, mouseDownSpeedBooster: 3, visibleHotSpots: "always", startAtElementId: "startAtMe"});
			
		});
		</script> 
		        
    </head>
    <body>
    <form id="usuariosForm" method="post" name="loginForm" action='<c:url value="/groupware-workbench/${collablet.id}/userMgr/${userMgr.id}/login" />'>
    	<div id="login_box">
    		<div id="lb_title"><span class="style1">Groupware Workbench</span></div>
    		<div id="lb_logo"><img src="<c:url value="/images/loginSistea.jpg" />" width="202" height="67" alt="Login" /></div>
    		<div id="lb_fields">
    			<div id="lb_fields_1">
	    			<ul>
	    				<li><span class="style3">Login</span></li>
	    				<li><input tabindex=1 name="user.login" type="text" class="box" id="login" size="15" maxlength="30" /></li>
	    			</ul>
    			</div>
    			<div id="lb_fields_3">
    				<input tabindex=3 name="Submit" type="submit" class="botao" id="Submit" value="Entrar" />
    			</div>
    			<div id="lb_fields_2">
    				<ul>
    					<li><span class="style3">Senha</span></li>
    					<li><input tabindex=2 name="user.password" type="password" class="box" id="senha" size="15" maxlength="30" /></li>
    				</ul>
    			</div>
    		</div>
    		<div id="lb_messages">
    			<c:if test="${sessionScope['log']==null}">
                      <div id="lb_message_1" align="right"><a href="<c:url value="/groupware-workbench/${collablet.id}/userMgr/${userMgr.id}/forgotLogout"/>">Esqueceu a senha?</a><span class="style8"></span></div>
                </c:if>
                <c:if test="${sessionScope['log']!=null}">
                  <c:if test="${!sessionScope['log']}">
					  <div id="lb_message_2" align="right"><span class="style8">Login ou senha incorretos</span></div>
                      <div id="lb_message_3" align="right"><a href="<c:url value="/groupware-workbench/${collablet.id}/userMgr/${userMgr.id}/forgotLogout"/>">Esqueceu a senha?</a><span class="style8"></span></div>
                   </c:if>
                </c:if>
    		</div>
    	</div>
        </form>
    </body>
</html>
