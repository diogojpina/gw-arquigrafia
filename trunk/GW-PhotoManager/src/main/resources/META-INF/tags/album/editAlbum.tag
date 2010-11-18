<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="album" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.Album" %>
<%@ attribute name="style" required="false" rtexprvalue="true" type="java.lang.String" %>
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
</script>
<style type="text/css">
.label {
    float: left;
    width: 150px;
}
</style>

<div style="${style}">
    <div>
        <div class="label">T&iacute;tulo</div>
        <div><input type="text" name="album.title" value="${album.title}" /></div>
    </div>
    <div>
        <div class="label"><label for="album.creationDate" class="${formLabelClass}">Data de cria&ccedil;&atilde;o:</label></div>
        <div><input type="text" id="edithAlbum_dateInput" name="album.creationDate" value="${album.formattedCreationDate}" /></div>
    </div>
    <div>
        <div class="label"><label for="album.urlCover" class="${formLabelClass}">Imagen da Capa</label></div>
        <div>
            <c:choose>
                <c:when test="${album.id != null}">
                    <input type="text" name="album.urlCover" value="${album.urlCover}" />
                </c:when>
                <c:otherwise>
                    <input type="text" name="album.urlCover" value="${pageContext.request.contextPath}/images/default_album.jpg" />
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div>
        <div class="label"><label for="album.description" class="${formLabelClass}">Descri&ccedil;&atilde;o:</label></div>
        <div><textarea name="album.description">${album.description}</textarea></div>
    </div>
    <div>
        <input type="submit" class="botao" value="Save" />
    </div>
</div>
