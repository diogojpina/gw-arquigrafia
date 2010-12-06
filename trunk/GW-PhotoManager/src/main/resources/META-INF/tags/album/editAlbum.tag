<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="album" required="false" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.Album" %>
<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance"%>
<%@ attribute name="classe" required="true" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="afterSaveFunction" required="false" rtexprvalue="true" type="java.lang.String" %>
<script type="text/javascript">
    $(document).ready((function() {
        $("#edithAlbum_dateInput").datepicker({
            "showOn": "button",
            "changeMonth": true,
            "changeYear": true,
            "width": 15,
            "dateFormat": "dd/mm/yy",
            "buttonImage": "${pageContext.request.contextPath}/images/calendar.gif",
            "buttonImageOnly": true
        });
    }));

    function serialize() {
        serial="";
        $(".${classe} input, .${classe} textarea").each(function(i,item){
            val = $(item).val();
            nome = $(item).attr("name");
            serial=serial + "&" +nome+"="+val
         });
        serial = serial.substring(1);
        return serial;
    }
    
    function saveAlbum() {
        var arguments = serialize();
        $.ajax({
            url: "${pageContext.request.contextPath}/groupware-workbench/album/${albumMgr.id}/save",
            type: "POST",
            data: arguments,
            success: ${afterSaveFunction}
        });
    }


</script>

<div class="${classe}">
    <input type="hidden" name="album.urlCover" value="${pageContext.request.contextPath}/images/album_icon.png" />
    <div>
        <div class="label">T&iacute;tulo</div>
        <div><input type="text" name="album.title" value="${album.title}" /></div>
    </div>    
    <div>
        <div class="label">Descri&ccedil;&atilde;o:</div>
        <div><textarea name="album.description">${album.description}</textarea></div>
    </div>
    <div>
        <button onclick="saveAlbum();" class="botao">Guardar</button>
    </div>
</div>
