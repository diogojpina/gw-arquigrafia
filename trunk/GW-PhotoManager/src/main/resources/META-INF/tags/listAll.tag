<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.groupwareworkbench.org.br/taglibs/reflection" prefix="r"%>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.PhotoMgrInstance"%>
<%@ attribute name="linkClass" required="false" rtexprvalue="true" type="String"%>
<%@ attribute name="keepRatio" required="true" rtexprvalue="true" type="Boolean" %>

<r:callMethod methodName="listaTodaPhoto" instance="${photoInstance}" var="fotosA" />
<r:callMethod methodName="getDirImagesRelativo" instance="${photoInstance}" var="dirImagemA" />
<r:callMethod methodName="getMostraPrefix" instance="${photoInstance}" var="showPrefixA" />

<c:choose>
    <c:when test="${keepRatio}">
        <r:callMethod methodName="getThumbPrefix" instance="${photoInstance}" var="thumbPrefix" />
    </c:when>
    <c:otherwise>
        <r:callMethod methodName="getCropPrefix" instance="${photoInstance}" var="thumbPrefix" />
    </c:otherwise>
    <c:forEach var="fotoA" items="${fotosA}">
        <a class="${linkClass}" rel="linkimage" href="<c:url value="/groupware-workbench/${photoInstance.id}/photo/show/${fotoA.id}"/>">
            <img src="${pageContext.request.contextPath}/${dirImagemA}/${thumbPrefix}${fotoA.nomeArquivo}" />
        </a>
    </c:forEach>
</c:choose>