<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance"%>
<%@ attribute name="user" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.user.User" %>
<%@ attribute name="photo" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>

<r:callMethod methodName="listByUser" instance="${albumMgr}" var="albums">
    <r:param type="br.org.groupwareworkbench.collablet.coord.user.User" value="${user}"/>
</r:callMethod>

<script type="text/javascript">
$(function(){
     $("#modalPanel_adicionar").dialog({
         autoOpen: false,
         modal: true,
         buttons: {
           "Cancelar": function() {
                 $("#modalPanel_adicionar").dialog("close");
            },
           "Adicionar": function() {
                 var album = $("#modalPanel_adicionar input:radio[name=radioAlbum]:checked").val();
                 if (album == null) {
                     alert("Escolhe um album");
                 } else {
                     $.post("${pageContext.request.contextPath}/groupware-workbench/album/${albumMgr.id}/add/"+album+"/"+${photo.id});
                     $("#modalPanel_adicionar").dialog("close");
                 }
           }
         }
     });
 });
</script>

<button onclick='$("#modalPanel_adicionar").dialog("open");' type="button">Adicionar</button>
<div id="modalPanel_adicionar">
    <div>
        <h2>Albums:</h2>
        <c:forEach items="${albums}" var="item">
            <div><input type="radio" name="radioAlbum" value="${item.id}">${item.title}</div>
        </c:forEach>
    </div>
</div>