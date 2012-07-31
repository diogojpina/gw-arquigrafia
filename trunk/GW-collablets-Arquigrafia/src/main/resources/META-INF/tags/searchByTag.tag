<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="photoMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>
<%@ attribute name="idList" required="true" type="java.util.Collection" %>

<r:callMethod methodName="buscaFotoPorListaId" instance="${photoMgr}" var="photos">
    <r:param type="java.util.List" value="${idList}" />
</r:callMethod>        
        
<c:forEach var="foto" items="${photos}">

        <a class="foto" rel="linkimage" href="<c:url value="/photo/${foto.id}"/>" class="search_image">
            <img src="<c:url value="/photo/img-thumb/${foto.id}"/>?_log=no"  alt="<c:out value="${foto.name}" />" />
        </a>

       
</c:forEach>

