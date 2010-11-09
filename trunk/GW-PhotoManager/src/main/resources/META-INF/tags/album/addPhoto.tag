<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance" %>
<%@ attribute name="album" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.Album" %>
<%@ attribute name="photo" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>

<%@ attribute name="albumDefault" required="false" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="user" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.user.User" %>
<%@ attribute name="successClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="buttonClass" required="false" rtexprvalue="false" type="java.lang.String" %>

<script type="text/javascript">
    function addObject() {
         $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/groupware-workbench/albuns/${albumMgr.id}/default/",
            data: "objectId=${photo.id}&strClass=${photo.class.name}",
            complete: function() {
                alert("O Elemento foi adicionado ${successAddObjectAtDefaultAlbum}");
            }
        });
    };
 </script>

<div id="BtPhoto" class="${buttonClass}">
    <input id="submitAlbum" type="submit" value="Add to Album" name="submit" onclick="addObject();"/>
</div>

<div id="successAddToAlbum" class="${successClass}">
    <script type="text/javascript">
        $("#successAddToAlbum").show().delay(2000).slideUp(300);
    </script>
    <c:out value="${successAddObjectAtDefaultAlbum}" />
    <c:if test="${empty successAddObjectAtDefaultAlbum}">
        <script type="text/javascript">
            $("#successAddToAlbum").hide();
        </script>
    </c:if>
</div>
  