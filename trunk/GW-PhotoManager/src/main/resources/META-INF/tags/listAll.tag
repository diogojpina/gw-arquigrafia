<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>
<%@ attribute name="linkClass" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="keepRatio" required="true" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="showInDiv" required="false" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="divClass" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="wrapClass" required="false" rtexprvalue="true" type="java.lang.String" %>

<r:callMethod methodName="listaTodaPhoto" instance="${photoInstance}" var="fotosA" />


<div class="wrapClass">
    <c:forEach var="fotoA" items="${fotosA}">
        <c:if test="${showInDiv}">
            <div class="${divClass}">
        </c:if>
        <a class="${linkClass}" rel="linkimage" href="<c:url value="/groupware-workbench/photo/${photoInstance.id}/show/${fotoA.id}"/>">
            <c:choose>
                <c:when test="${keepRatio}">
                    <img src="<c:url value="/groupware-workbench/photo/img-thumb/${fotoA.id}"/>" />
                </c:when>
                <c:otherwise>
                    <img src="<c:url value="/groupware-workbench/photo/img-crop/${fotoA.id}"/>" />
                </c:otherwise>
            </c:choose>
        </a>
        <c:if test="${showInDiv}">
            </div>
        </c:if>
    </c:forEach>
</div>