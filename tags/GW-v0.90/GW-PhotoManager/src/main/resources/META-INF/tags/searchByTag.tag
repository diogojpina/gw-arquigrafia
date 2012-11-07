<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>
<%@ attribute name="idList" required="true" type="java.util.Collection" %>

<%@ attribute name="showName" required="false" rtexprvalue="false" type="java.lang.Boolean" %>
<%@ attribute name="showLocation" required="false" rtexprvalue="false" type="java.lang.Boolean" %>
<%@ attribute name="linkClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="nameClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="locationClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="lineClass" required="false" rtexprvalue="false" type="java.lang.String" %>

<r:callMethod methodName="buscaFotoPorListaId" instance="${photoInstance}" var="photos">
    <r:param type="java.util.List" value="${idList}" />
</r:callMethod>        
        
<%--
    TODO: Evitar inserir <div> que não fecham de forma óbvia pois dependem de análise sensível ao contexto para
    garantir que são bem formadas.
--%>
<c:forEach var="foto" items="${photos}">
    <div class="${lineClass}" style="float: left">
        <c:if test="${showName || showLocation}">
            <div>
        </c:if>
        <a class="${linkClass}" rel="linkimage" href="<c:url value="/groupware-workbench/photo/${foto.id}"/>">
            <img src="<c:url value="/groupware-workbench/photo/img-thumb/${foto.id}"/>" alt="<c:out value="${foto.nome}" />" />
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

