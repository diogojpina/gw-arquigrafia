<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ attribute name="photo" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>
<script type="text/javascript">
    var dialogDelete;
    $(document).ready(function() {
        dialogDelete = new Boxy($(".modalPanel_delete"), {
            title: "Eliminar",
            closeable: false,
            modal: true,
        }).hide();
    });

    function showDialogDelete() {
        dialogDelete.show();
    }

    function closeDialogDelete() {
        dialogDelete.hide();
    }
    
    function deletePhoto() {
    	dialogDelete.hide();
        $.post("${pageContext.request.contextPath}/groupware-workbench/photo/delete/" + ${photo.id}, function(data) {});
        goInitPage();
    }
    
    function goInitPage() {
        window.location = "${pageContext.request.contextPath}";
    }
</script>