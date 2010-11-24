<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ attribute name="album" required="false" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.Album"%>
<div>
    <div class="component_header" style="height: 25px ;">
        <span class="title">${album.title}</span>
    </div>
    <div style="padding: 3px;">
        <c:forEach items="${album.objects}" var="item">
            <div style="float: left; margin: 3px;">
                <a href="<c:url value="/groupware-workbench/photo/${item.id}"/>">    
                    <img style="border: 0;" src="<c:url value="/groupware-workbench/photo/img-crop/${item.id}"/>" />
                </a>
            </div>
        </c:forEach>
    </div>
</div>

