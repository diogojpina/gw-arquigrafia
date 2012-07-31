<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ attribute name="photo" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>
<%@ attribute name="idButton" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="className" required="false" rtexprvalue="true" type="java.lang.String" %>

<span id="${idButton}" onclick='showDialogDelete();' class="${className}">Eliminar</span>

<div class="modalPanel_delete" id="modalPanel_delete" title="Excluir foto">
    <div>
        <h2>Tem certeza que deseja excluir esta foto?</h2>
    </div>
    <div class="controls">
        <div class="blue-button fechar" onclick="closeDialogDelete();">Fechar</div>
        <div class="blue-button excluir" onclick="deletePhoto();">Eliminar</div>
    </div>
</div>