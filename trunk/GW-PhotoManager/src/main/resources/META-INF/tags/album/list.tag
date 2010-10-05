<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance" %>
<%@ attribute name="albuns" required="true" rtexprvalue="true" type="java.util.List" %>

<%@ attribute name="showNumber" required="true" rtexprvalue="false" type="java.lang.Boolean" %>
<%@ attribute name="showEdit" required="true" rtexprvalue="false" type="java.lang.Boolean" %>
<%@ attribute name="showDelete" required="false" rtexprvalue="false" type="java.lang.Boolean" %>
<%@ attribute name="linkClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="nameClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="locationClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="lineClass" required="false" rtexprvalue="false" type="java.lang.String" %>

<%--
    TODO: Evitar inserir <div> que nao fecham de forma obvia pois dependem de analise sensivel ao contexto para
    garantir que sao bem formadas.
--%>
<c:forEach var="album" items="${albuns}">
    <div class="${lineClass}" style="float: left">
      <!-- <form action="${pageContext.request.contextPath}/groupware-workbench/${collablet.id}/albumMgr/${albumMgr.id}/remove/${album.id}"> -->
        <c:if test="${showNumber || showEdit}">
            <div>
        </c:if>
        <!--<a class="${linkClass}" rel="linkimage" href="<c:url value="/groupware-workbench/${photoInstance.id}/photo/show/${foto.id}"/>">
            <img src="<c:url value="/groupware-workbench/${photoInstance.id}/photo/img-thumb/${foto.nomeArquivoUnico}"/>"/>
        </a>-->
        <a class="${linkClass}" href="<c:url value="${pageContext.request.contextPath}/groupware-workbench/${collablet.id}/albumMgr/${album.id}"/>">
            <c:out value="${album.title}"/>
        </a>
        <c:if test="${showNumber || showEdit}">
            </div>
        </c:if>
        <c:if test="${showNumber}">
            <div class="${numberClass}">
                <c:out value="${albuns.size}" />
            </div>
        </c:if>
        <c:if test="${showEdit}">
            <div class="${editClass}" >
            	<a class="${linkClass}"  href="<c:url value="${pageContext.request.contextPath}/groupware-workbench/${collablet.id}/albumMgr/${album.id}"/>">
            		<c:out value="Edit"/>
        		</a>
            </div>
        </c:if>
        <c:if test="${showDelete}">
            <div class="${editClass}" >
            	<a class="${linkClass}"  href="<c:url value="${pageContext.request.contextPath}/groupware-workbench/${collablet.id}/albumMgr/${albumMgr.id}/remove/${album.id}"/>">
            		<c:out value="Delete"/>
        		</a>
            </div>
        </c:if>
        <!-- </form> -->
    </div>
</c:forEach>