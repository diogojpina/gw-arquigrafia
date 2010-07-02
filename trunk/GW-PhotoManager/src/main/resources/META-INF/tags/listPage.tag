<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.PhotoMgrInstance" %>
<%@ attribute name="linkClass" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="keepRatio" required="true" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="showInDiv" required="false" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="divClass" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="pageSize" required="true" rtexprvalue="true" type="java.lang.Integer" %>
<%@ attribute name="pageNumber" required="true" rtexprvalue="true" type="java.lang.Integer" %>
<%@ attribute name="wrapClass" required="false" rtexprvalue="true" type="java.lang.String" %>

<r:callMethod methodName="listaPhotoPorPaginaEOrdem" instance="${photoInstance}" var="fotosA">
    <r:param type="int" value="${pageSize}" />
    <r:param type="int" value="${pageNumber}" />
</r:callMethod>


<div class="${wrapClass}">
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
            <img src="<c:url value="/groupware-workbench/${photoInstance.id}/photo/img-thumb/${fotoA.nomeArquivoUnico}"/>"/>
        </a>
        <c:if test="${showInDiv}">
            </div>
        </c:if>
    </c:forEach>
</div>