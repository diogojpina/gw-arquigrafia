<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.groupwareworkbench.org.br/taglibs/reflection" prefix="r"%>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag" prefix="TagMgr"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.PhotoMgrInstance"%>
<%@ attribute name="photos" required="true" rtexprvalue="true" type="java.util.List"%>
<%@ attribute name="linkClass" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="showName" required="false" rtexprvalue="false" type="java.lang.Boolean" %>
<%@ attribute name="showLocation" required="false" rtexprvalue="false" type="java.lang.Boolean" %>
<%@ attribute name="nameClass" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="locationClass" required="false" rtexprvalue="true" type="java.lang.String" %>

<r:callMethod methodName="getDirImagesRelativo"	instance="${photoInstance}" var="dirImagem" />
<r:callMethod methodName="getThumbPrefix" instance="${photoInstance}" var="thumbPrefix" />
<r:callMethod methodName="getMostraPrefix" instance="${photoInstance}" var="showPrefix" />

<c:forEach var="foto" items="${photos}">
    <a class="${linkClass}" rel="linkimage" href="<c:url value="/groupware-workbench/${photoInstance.id}/photo/show/${foto.id}"/>">
        <img src="${pageContext.request.contextPath}/${dirImagem}/${thumbPrefix}${foto.nomeArquivo}" alt="${foto.nome}" />
    </a>
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
</c:forEach>