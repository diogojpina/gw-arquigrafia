<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.groupwareworkbench.org.br/taglibs/reflection" prefix="r"%>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.PhotoMgrInstance"%>
<%@ attribute name="linkClass" required="false" rtexprvalue="true" type="java.lang.String"%>
<%@ attribute name="keepRatio" required="true" rtexprvalue="true" type="java.lang.Boolean" %>

<r:callMethod methodName="listaTodaPhoto" instance="${photoInstance}" var="fotosA" />
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
    <a class="${linkClass}" rel="linkimage" href="<c:url value="/groupware-workbench/${photoInstance.id}/photo/show/${fotoA.id}"/>">
        <img src="${pageContext.request.contextPath}/${dirImagemA}/${thumbPrefix}${fotoA.nomeArquivo}" />
    </a>
</c:forEach>