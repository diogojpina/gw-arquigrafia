<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance" %>
<%@ attribute name="album" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.Album" %>
<%@ attribute name="photo" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>

<%@ attribute name="albumDefault" required="false" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="user" required="false" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.user.User" %>
<%@ attribute name="linkClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="nameClass" required="false" rtexprvalue="false" type="java.lang.String" %>

<%--
    TODO: Evitar inserir <div> que nao fecham de forma obvia pois dependem de analise sensivel ao contexto para
    garantir que sao bem formadas.
--%>
 <script type="text/javascript">
     $(document).ready(function() {
    	$('#addPhotoToAlbum').submit(function() {
   			$.ajax({
   			    type: 		"post",
   	   			url: "/groupware-workbench/albuns/"+${albumMgr.id}+"/default/",
   	   			data: "object=" +${photo},
   	   			function(data){
   	   		     alert("Data Loaded: " + data);
   	   			}
  			});
    		return false;
   		});
     });
 </script>

<form name="addPhotoToAlbum" method="post" enctype="multipart/form-data" 
      action="<c:url value="" />"  >
      <input id="photot" type="hidden" value="${photo}" name="object"/>
           
      <div id="BtPhoto">
         	<input id="submit" type="submit" value="Add to Album" name="submit"/>
      </div>
</form>      
