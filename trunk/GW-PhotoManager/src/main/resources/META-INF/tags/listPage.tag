<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>

<%@ attribute name="linkClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="divClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="wrapClass" required="false" rtexprvalue="false" type="java.lang.String" %>

<%@ attribute name="keepRatio" required="true" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="showInDiv" required="false" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="pageSize" required="true" rtexprvalue="true" type="java.lang.Integer" %>
<%@ attribute name="pageNumber" required="true" rtexprvalue="true" type="java.lang.Integer" %>

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
            <div class="${divClass}">
        </c:if>
        <a class="${linkClass}" rel="linkimage" href="<c:url value="/groupware-workbench/${photoInstance.id}/photo/show/${fotoA.id}"/>">            
            <c:choose>
                <c:when test="${keepRatio}">
                    <img src="<c:url value="/groupware-workbench/${photoInstance.id}/photo/img-thumb/${fotoA.nomeArquivoUnico}"/>"/>
                </c:when>
                <c:otherwise>
                    <img src="<c:url value="/groupware-workbench/${photoInstance.id}/photo/img-crop/${fotoA.nomeArquivoUnico}"/>"/>
                </c:otherwise>
            </c:choose>
        </a>
        <c:if test="${showInDiv}">
            </div>
        </c:if>
    </c:forEach>
</div>