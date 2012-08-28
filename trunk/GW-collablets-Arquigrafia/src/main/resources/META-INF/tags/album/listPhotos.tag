<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ attribute name="album" required="false" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.Album" %>
<%@ attribute name="albumGalleryBox" required="false" rtexprvalue="true" type="java.lang.String" %>


 <div id="<c:out value="${albumGalleryBox}" default="album_gallery_box"/>">
   <h1>${album.title}</h1>
   <br />
   <c:forEach items="${album.objects}" var="item">
   		<c:if test="${!item.deleted}">
   			<div class="album_image_box">
				<a href="<c:url value="/photo/${item.id}" />" class="image image_management_controls">
					<img src="<c:url value="/photo/img-crop/${item.id}"/>" width="170" height="117"/>
				</a>
				<c:if test="${sessionScope.userLogin.id eq album.owner.id}">
					<a href="<c:url value="/groupware-workbench/album/${album.id}/delete/${item.id}/list/${sessionScope.userLogin.id}"/>" class="album_image_delete_button"></a>
				</c:if>
		   </div>
	   </c:if>
   </c:forEach>
   
 </div>
