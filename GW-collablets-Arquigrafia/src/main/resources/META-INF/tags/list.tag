<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="photoMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>
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
        <a  class="search_image" rel="linkimage" href="<c:url value="/photo/${foto.id}"/>" title="${foto.name}" >
            <img src="<c:url value="/photo/img-thumb/${foto.id}"/>?_log=no" />
        </a>
        <c:if test="${showName || showLocation}">
            </div>
        </c:if>
        <c:if test="${showName}">
            <div class="${nameClass}">
                <c:out value="${foto.name}" />
            </div>
        </c:if>
        <c:if test="${showLocation}">
            <div class="${locationClass}" >
                <c:out value="${foto.lugar}" />
            </div>
        </c:if>
    </div>
</c:forEach>