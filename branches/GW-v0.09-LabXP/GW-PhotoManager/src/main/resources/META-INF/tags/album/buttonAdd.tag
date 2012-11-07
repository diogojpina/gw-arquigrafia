<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance" %>
<%@ attribute name="user" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.user.User" %>
<%@ attribute name="photo" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>
<%@ attribute name="idButton" required="false" rtexprvalue="true" type="java.lang.String" %>

<r:callMethod methodName="listByUser" instance="${albumMgr}" var="albums">
    <r:param type="br.org.groupwareworkbench.collablet.coord.user.User" value="${user}" />
</r:callMethod>

<div id="${idButton}" onclick='showDialog();' >Adicionar no &aacute;lbum </div>
<div class="modalPanel_adicionar" title="Adicionar no album">
    <div>
        <h2>Escolha um &aacute;lbum para adicionar esta foto:</h2>
        <c:forEach items="${albums}" var="item">
            <div><input type="radio" name="radioAlbum" value="${item.id}"> ${item.title}</div>
        </c:forEach>        
    </div>
    <div class="controls">
        <div class="blue-button fechar" onclick="closeDialog();">Fechar</div>
        <div class="blue-button adicionar" onclick="addToAlbum();">Adicionar</div>
    </div>
</div>