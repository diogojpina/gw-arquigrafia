<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance" %>
<%@ attribute name="album" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.Album" %>
<%@ attribute name="photos" required="true" rtexprvalue="true" type="java.util.List" %>

<%@ attribute name="showName" required="false" rtexprvalue="false" type="java.lang.Boolean" %>
<%@ attribute name="showLocation" required="false" rtexprvalue="false" type="java.lang.Boolean" %>
<%@ attribute name="linkClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="nameClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="locationClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="lineClass" required="false" rtexprvalue="false" type="java.lang.String" %>

<%--
    TODO: Evitar inserir <div> que nao fecham de forma obvia pois dependem de analise sensivel ao contexto para
    garantir que sao bem formadas.
--%>
<c:forEach var="foto" items="${photos}">
    <div class="${lineClass}" style="float: left">
        <c:if test="${showName || showLocation}">
            <div>
        </c:if>
        <a class="${linkClass}" rel="linkimage" href="<c:url value="${pageContext.request.contextPath}/groupware-workbench/photo/${foto.id}" />">
            <img src="<c:url value="${pageContext.request.contextPath}/groupware-workbench/photo/img-thumb/${foto.id}" />" />
        </a>
        <c:if test="${showName || showLocation}">
            </div>
        </c:if>
        <c:if test="${showName}">
            <div class="${nameClass}">
                <c:out value="${foto.nome}" />
            </div>
        </c:if>
        <c:if test="${showLocation}">
            <div class="${locationClass}" >
                <c:out value="${foto.lugar}" />
            </div>
        </c:if>
    </div>
</c:forEach>