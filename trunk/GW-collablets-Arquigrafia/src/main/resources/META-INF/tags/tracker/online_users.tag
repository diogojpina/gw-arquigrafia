<%-- 
    Criado em: 25/11/2010
    Autor    : Claudio Roberto França Pereira
--%>
<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="trackerInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.tracker.TrackerInstance" %>

<c:set var="userCount" value="${trackerInstance.onlineUserCount}" />
<c:choose>
    <c:when test="${userCount == 0}">Nenhum usu&aacute;rio conectado</c:when>
    <c:when test="${userCount == 1}">1 usu&aacute;rio online</c:when>
    <c:otherwise>${userCount} usu&aacute;rios online</c:otherwise>
</c:choose>