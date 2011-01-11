<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance" %>
<%@ attribute name="user" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.user.User" %>
<%@ attribute name="classe" required="true" rtexprvalue="true" type="java.lang.String" %>

<r:callMethod methodName="listByUser" instance="${albumMgr}" var="albums">
    <r:param type="br.org.groupwareworkbench.collablet.coord.user.User" value="${user}" />
</r:callMethod>

<script type="text/javascript">
    var pageSize = 32;
    var actualPage = 0;
    var sizeLastRequest = pageSize;
    var marginLeft = 0;
    var dialog;


    $(window).resize(function() {
         loadImages();
    });

    function calcMargins() {
        var width = $(".${classe}").width();
        var height = $(".${classe}").height();
        pageLine = (width / 100) | 0;
        marginLeft = ((width - (pageLine * 100)) / pageLine) + (100 / pageLine) | 0;
        pageSize = (((width * height) / ((100 + marginLeft) * 127)) | 0 ) - 6;
        sizeLastRequest = pageSize;
    }

    function loadImages() {
        calcMargins();
        $.getJSON("${pageContext.request.contextPath}/groupware-workbench/photo/${photoMgr.id}/listbyuserpage/"+pageSize+"/"+actualPage,
           function(json) {
           sizeLastRequest = json.list.length;
           if(sizeLastRequest > 0) {
               $("#listPhotos").empty();
           } else {
                 actualPage = 0;
                 $(".anterior").show();
                 $(".seguinte").show();
           }
           $.each(json.list, function(i, photo) {
               var add =
               '<li class="shiftedImg">' +
                   '<a href="${pageContext.request.contextPath}/groupware-workbench/photo/' + photo.id + '">' +
                   '<img src="${pageContext.request.contextPath}/groupware-workbench/photo/img-crop/' + photo.id + '" />' +
                   '</a>' +
                   '<div><a onclick="openPanel(' + photo.id + ');" href="#">adicionar</a></div>' +
               '</li>';
               $("#listPhotos").append(add);
           });
           $(".shiftedImg").css("margin-left", marginLeft + "px");
         });
    }

    $(document).ready(function(){
        $(".modalPanel_adicionar input:radio[name=radioAlbum]:first").attr("checked", "checked");
        dialog = new Boxy($(".modalPanel_adicionar"), {
            title: "Adicionar no &aacute;lbum",
            closeable: false,
            modal: true,
            }).hide();
        loadImages();
    });

    function closeDialog() {
        dialog.hide();
    }

    function addToAlbum() {
        var object = $("#modalPanel_hidden").val();
        var album = $(".modalPanel_adicionar input:radio[name=radioAlbum]:checked").val();
        $.post("${pageContext.request.contextPath}/groupware-workbench/album/${albumMgr.id}/add/" + album + "/" + object, function(data) {
            dialog.hide();
        });
    }

    function openPanel(idPhoto) {
         $("#modalPanel_hidden").val(idPhoto);
         dialog.show();
    }

    function downPage() {
        if (actualPage > 0) {
            actualPage--;
            $(".anterior").show();
        } else {
            $(".anterior").hide();
        }
        $(".seguinte").show();
        loadImages();
    }

    function upPage() {
        if (sizeLastRequest == pageSize) {
            actualPage++;
            $(".seguinte").show();
        } else {
            $(".seguinte").hide();
        }
        $(".anterior").show();
        loadImages();
    }
</script>

<div class="${classe}">
    <input type="hidden" id="modalPanel_hidden"/>
    <div class="component_header">
        <span class="title">Minhas Imagens</span>
        <span style="float: right;">
            <span class="span_link anterior" onclick="downPage();">anterior</span>
            <span style="margin-left: 4px;"></span>
            <span class="span_link seguinte" onclick="upPage();">seguinte</span>
        </span>
    </div>
    <ul id="listPhotos" style="list-style: none;"></ul>
</div>

<div class="modalPanel_adicionar" title="Adicionar no &aacute;lbum">
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