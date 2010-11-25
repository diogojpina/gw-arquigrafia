<%-- 
    Criado em: 25/11/2010
    Autor    : Claudio Roberto França Pereira
--%>
<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="trackerInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.tracker.TrackerInstance" %>

<c:set var="userCount" value="${trackerInstance.onlineUserCount}" />
<c:choose>
	<c:when test="${userCount == 0}">Nenhum usuário conectado</c:when>
	<c:when test="${userCount == 1}">1 usuário online</c:when>
	<c:otherwise>${userCount} usuários online</c:otherwise>
</c:choose>