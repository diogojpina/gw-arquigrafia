<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="coll" uri="http://www.groupwareworkbench.org.br/widgets/collections" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Usu&aacute;rio</title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/arq-common.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/listagem.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <!-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/qTip.js"></script> -->
        <!-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script> -->
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.style-my-tooltips.js"></script>
        <script type="text/javascript">  
			$().ready(function() {  
				//applies to all elements with title attribute. Change to ".class[title]" to select only elements with specific .class and title
				$("[title]").style_my_tooltips({ 
					tip_follows_cursor: "on", //on/off
					tip_delay_time: 100 //milliseconds
				});  
			});  
		</script>
        
        <w:tabela baseUrl="/groupware-workbench/users"
                  createUrl="/groupware-workbench/users/${userMgr.id}/create"
                  msgAdd="Adicionar novo usuário"
                  msgDelete="Tem certeza que deseja remover o usuário?"
                  target="tabela-users"
                  titles="${coll:asList3('Nome', 'Login', 'E-mail')}"
                  columns="${coll:asList3('name', 'login', 'email')}"
                  elements="${userList}" />
    </head>
    <body>
        <w:topo collabletInstance="${userMgr.collablet}" />
        <w:conteudoPagina titulo="Usu&aacute;rios">
            <div id="tabela-users"></div>
            <div class="barra_botoes">
                <w:voltar collabletInstance="${userMgr.collablet.parent}" />
            </div>
            <div><label title="Este es un mensaje grande que quiero que aparesca en la pantalla si no me voy a irritar e no queremos eso o si, de otro lado este es un gran problema que tiene que ser resuelto porque la interrogante no tiene formato.">?</label></div>
            <a href="#" title="This tooltip should appear just below your cursor, which is the default position as with native browser tooltips.">Hover me!</a>
        </w:conteudoPagina>
    </body>
</html>