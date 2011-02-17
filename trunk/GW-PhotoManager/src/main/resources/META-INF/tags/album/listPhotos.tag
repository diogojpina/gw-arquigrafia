<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ attribute name="album" required="false" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.Album" %>
<%@ attribute name="classe" required="false" rtexprvalue="true" type="java.lang.String" %>
<div class="${classe}">
    <div class="component_header">
        <span class="title">${album.title}</span>
    </div>
    <div class="corpo">
        <c:forEach items="${album.objects}" var="item">
            <div class="photo-item">
                <a href="<c:url value="/groupware-workbench/photo/${item.id}" />">
                    <img src="<c:url value="/groupware-workbench/photo/img-crop/${item.id}" />?_log=no" />
                </a>
            </div>
        </c:forEach>
    </div>
</div>

