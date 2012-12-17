<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="album" required="false" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.Album" %>
<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance"%>
<%@ attribute name="message" required="true" rtexprvalue="true" type="java.lang.String" %>

<h2>${message}</h2>
<br />
<small>* Todos os campos a seguir são obrigatórios.</small></p>
<form id="form1" class="cmxform" name="dados" method="POST" action="<c:url value="/album/${albumMgr.id}/save" />" accept-charset="UTF-8" autocomplete="off">
  	
		 <c:if test="${not empty album.id}">
		   <input type="hidden" name="album.id" value="${album.id}"/>
		   <input type="hidden" name="_method" value="put"/>
		 </c:if>
  	
  	<div>
    	<h3>Dados da Coleção</h3>
  		<p>
			<label>Título*:</label>
    		<input type="text" class="required" name="album.title" value="<c:out value="${album.title}" />"/>
  			<br />
  			<label>Decrição*:</label>
				<input type="text" class="required" name="album.description" value="<c:out value="${album.description}" />"/>
  		</p>
	</div>

	<div>
		<input name="enviar" type="submit" class="submit cursor" value="" />
	</div>

</form>