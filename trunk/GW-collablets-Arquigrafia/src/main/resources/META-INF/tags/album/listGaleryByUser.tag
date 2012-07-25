<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ taglib prefix="album" uri="http://www.groupwareworkbench.org.br/widgets/album" %>
<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance" %>
<%@ attribute name="user" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.user.User" %>
<r:callMethod methodName="listByUser" instance="${albumMgr}" var="albunsByUser" >
    <r:param type="br.org.groupwareworkbench.collablet.coord.user.User" value="${user}" />
</r:callMethod>


     <h2 id="profile_block_title">Minhas&nbsp;galerias</h2>
     
     <a href="#" id="small" class="profile_block_link">Ver todas</a>
	<div id="profile_box">
		<c:forEach items="${albunsByUser}" var="album">
	     	<div id="gallery_box">
	        	<a href="${pageContext.request.contextPath}/groupware-workbench/album/${albumMgr.id}/default/${album.id}" id="gallery_photo">
         	    	<img src="<c:url value="/img/album_icon-1.png" />" id="gallery_photo" />
	       		</a>
	        		
	         	<a href="${pageContext.request.contextPath}/groupware-workbench/album/${albumMgr.id}/default/${album.id}" id="name"><c:out value="${album.title}" /></a>
	         	<br />
	         	<span id="small">${fn:length(album.objects)} foto(s)</span>
			</div>
		</c:forEach>          	
	</div>
			
 
