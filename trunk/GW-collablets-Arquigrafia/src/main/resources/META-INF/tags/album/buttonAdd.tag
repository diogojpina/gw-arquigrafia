


<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ taglib prefix="album" uri="http://www.groupwareworkbench.org.br/widgets/album" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance"%>
<%@ attribute name="user" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.user.User" %>
<%@ attribute name="photo" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>

<r:callMethod methodName="listByUser" instance="${albumMgr}" var="albums">
    <r:param type="br.org.groupwareworkbench.collablet.coord.user.User" value="${user}" />
</r:callMethod>

<form id="form1" class="cmxform" name="dados" method="POST" action="<c:url value="/groupware-workbench/album/${albumMgr.id}/add/${photo.id}" />" accept-charset="UTF-8" autocomplete="off">
  	
  	<div>
    	<h3>Escolha alguns &aacute;lbuns para adicionar esta foto:</h3>
  		<p>
       <c:forEach items="${albums}" var="album" varStatus="item">
    		<input type="checkbox" <c:if test="${album:contains(album, photo) }">checked="checked"</c:if> class="required" name="albums[${item.index}]" value="<c:out value="${album.id}" />"/> ${album.title}
				<br/>
			</c:forEach>  		
			
  		</p>
		</div>

		<div>
			<input name="enviar" type="submit" class="submit cursor" value="" />
		</div>

</form>
