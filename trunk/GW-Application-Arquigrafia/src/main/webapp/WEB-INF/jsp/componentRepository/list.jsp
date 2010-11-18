<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Arquigrafia Brasil</title>
		<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/arq-common.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/know_more.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/forms.css"  />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/plugins/sds/css/smoothDivScroll.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/bay.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/footer.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/jquery.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/tagcloud.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/image_wall.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/boxy.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.custom.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/scroll.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/chili-1.7.pack.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easing.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.dimensions.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.accordion.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/bay.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.boxy.js"></script>
    </head>
    <body>
        <div id="wrap">
            <arq:header2 photoInstance="${photoMgr}" />
            <div id="main_section">
	            <h1>Componentes do Repositório</h1>
				<a href="<c:url value="/groupware-workbench/repository/${componentRepository.id}/new" />">Cadastrar novo componente</a>
				<table border="1">
					<tr>
						<th>Nome</th>
						<th>Descrição</th>
						<th>Versão</th>
						<th>MD5</th>
						<th>Tamanho</th>
						<th>Data</th>
						<th>Deletar</th>
						<th>Baixar</th>
					</tr>
					<c:if test="${!empty componentList}">
						<c:forEach var="cmp" items="${componentList}">
							<tr>
								<td>${cmp.name}</td>
								<td>${cmp.description}</td>
								<td>${cmp.version}</td>
								<td>${cmp.md5hash}</td>
								<td>${cmp.size}</td>
								<td>${cmp.insertionDate}</td>
								<td>
									<form method="post" action="<c:url value="/groupware-workbench/repository/${componentRepository.id}/${cmp.id}" />">
										<input type="hidden" name="_method" value="DELETE" />
										<input type="submit" value="Deletar" />
									</form>
								</td>
								<td>
									<form method="get" action="<c:url value="/groupware-workbench/repository/${componentRepository.id}/${cmp.id}/download" />">
										<input type="submit" value="Baixar" />
									</form>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty componentList}">
						<tr>
							<td colspan="8">Nenhum componente cadastrado.</td>
						</tr>
					</c:if>
				</table>
	        </div>
	        <div style="height:30px;background-color:#fff;">&nbsp;</div>
            <arq:footer photoInstance="${photoMgr}" />
        </div>
    </body>
</html>
