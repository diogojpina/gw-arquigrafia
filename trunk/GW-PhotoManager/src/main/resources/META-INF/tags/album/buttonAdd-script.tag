<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ attribute name="photo" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>
<script type="text/javascript">
<!--
var dialog;
$(document).ready(function(){
        $(".modalPanel_adicionar input:radio[name=radioAlbum]:first").attr("checked", "checked");
        dialog = new Boxy($(".modalPanel_adicionar"),{
    	title: "Adicionar no album",
        closeable: false,
        modal: true,
        }).hide();        
});

function showDialog() {
    dialog.show();   
}

function closeDialog() {
    dialog.hide();
}   

function addToAlbum() {
	var album = $(".modalPanel_adicionar input:radio[name=radioAlbum]:checked").val();
    $.post("${pageContext.request.contextPath}/groupware-workbench/album/${albumMgr.id}/add/"+album+"/"+${photo.id}, function(data){
    	dialog.hide();
    });
}

//-->
</script>
