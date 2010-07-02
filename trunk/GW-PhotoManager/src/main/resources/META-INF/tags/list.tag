<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.PhotoMgrInstance" %>
<%@ attribute name="photos" required="true" rtexprvalue="true" type="java.util.List" %>
<%@ attribute name="linkClass" required="false" type="java.lang.String" %>
<%@ attribute name="showName" required="false" type="java.lang.Boolean" rtexprvalue="false" %>
<%@ attribute name="showLocation" required="false" type="java.lang.Boolean" rtexprvalue="false" %>
<%@ attribute name="nameClass" required="false" type="java.lang.String" %>
<%@ attribute name="locationClass" required="false" type="java.lang.String" %>
<%@ attribute name="lineClass" required="false" type="java.lang.String" %>

<%--
    TODO: Evitar inserir <div> que n�o fecham de forma �bvia pois dependem de an�lise sens�vel ao contexto para
    garantir que s�o bem formadas.
--%>
<c:forEach var="foto" items="${photos}">
    <div class="${lineClass}" style="float: left">
        <c:if test="${showName || showLocation}">
            <div>
        </c:if>
        <a class="${linkClass}" rel="linkimage" href="<c:url value="/groupware-workbench/${photoInstance.id}/photo/show/${foto.id}"/>">
            <img src="<c:url value="/groupware-workbench/${photoInstance.id}/photo/img-thumb/${foto.nomeArquivoUnico}"/>"/>
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