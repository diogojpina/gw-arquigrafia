<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.groupwareworkbench.org.br/taglibs/reflection" prefix="r"%>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.PhotoMgrInstance"%>
<%@ attribute name="linkClass" required="false" rtexprvalue="true" type="java.lang.String"%>
<%@ attribute name="keepRatio" required="true" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="showInDiv" required="false" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="divClass" required="false" rtexprvalue="true" type="java.lang.String" %>

<r:callMethod methodName="listaPrimeirasCem" instance="${photoInstance}" var="fotosA" />
<c:set var="dirImagemA" value="${photoInstance.dirImagesRelativo}" />
<c:set var="showPrefixA" value="${photoInstance.mostraPrefix}" />

<c:choose>
    <c:when test="${keepRatio}">
        <c:set var="thumbPrefix" value="${photoInstance.thumbPrefix}" />
    </c:when>
    <c:otherwise>
        <c:set var="thumbPrefix" value="${photoInstance.cropPrefix}" />
    </c:otherwise>
</c:choose>
<c:forEach var="fotoA" items="${fotosA}">
    <c:if test="${showInDiv}">
        <div class="<c:out value="${divClass}" />">
    </c:if>
    <a class="${linkClass}" rel="linkimage" href="<c:url value="/groupware-workbench/${photoInstance.id}/photo/show/${fotoA.id}"/>">
        <img src="${pageContext.request.contextPath}/${dirImagemA}/${thumbPrefix}${fotoA.nomeArquivoUnico}" />
    </a>
    <c:if test="${showInDiv}">
        </div>
    </c:if>
</c:forEach>