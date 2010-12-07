<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance"%>
<%@ attribute name="user" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.user.User" %>
<%@ attribute name="photo" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>
<%@ attribute name="idButton" required="false" rtexprvalue="true" type="java.lang.String" %>
<r:callMethod methodName="listByUser" instance="${albumMgr}" var="albums">
    <r:param type="br.org.groupwareworkbench.collablet.coord.user.User" value="${user}"/>
</r:callMethod>
<button id="${idButton}" onclick='$("#modalPanel_adicionar").dialog("open");' type="button">Adicionar no &aacute;lbum</button>
<div id="modalPanel_adicionar" title="Adicionar no album">
    <div>
        <h2>Escolha um &aacute;lbum para adicionar esta foto:</h2>
        <c:forEach items="${albums}" var="item">
            <div><input type="radio" name="radioAlbum" value="${item.id}">${item.title}</div>
        </c:forEach>
    </div>
</div>