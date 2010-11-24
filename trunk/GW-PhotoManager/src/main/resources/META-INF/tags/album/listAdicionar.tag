<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance"%>
<%@ attribute name="user" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.user.User" %>
<%@ attribute name="style" required="false" rtexprvalue="true" type="java.lang.String"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.custom.min.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/jquery.css" />

<r:callMethod methodName="listByUser" instance="${albumMgr}" var="albums">
    <r:param type="br.org.groupwareworkbench.collablet.coord.user.User" value="${user}"/>
</r:callMethod>

<script type="text/javascript">
<!--
var pageSize = 32;
var actualPage = 0;
var sizeLastRequest = pageSize;


$(window).resize( function(){
     loadImages();

});
function calcMargins() {
    var width = $("#list_anadir_container").width();
    var height = $("#list_anadir_container").height(); 
    pageLine = (width / 100) | 0;  
    var marginLeft = ((width - (pageLine * 100)) / pageLine) + (100 / pageLine)| 0;
    $(".shiftedImg").css("margin-left", marginLeft + "px");
    pageSize = (((width * height) / ((100 + marginLeft) * 127)) | 0 ) - 1;
    sizeLastRequest = pageSize;
    actualPage = 0;
}
function loadImages() {
    $.getJSON("${pageContext.request.contextPath}/groupware-workbench/photo/${photoMgr.id}/listbypage/"+pageSize+"/"+actualPage,
             function(json) {
               sizeLastRequest = json.list.length;
               if(sizeLastRequest > 0) {
                     $("#listPhotos").empty();
               }
               $.each(json.list, function(i,photo) {
                     var add = 
                         '<li class="shiftedImg" style="float: left; margin-bottom: 9px;" >' +
                           '<img src="${pageContext.request.contextPath}/groupware-workbench/photo/img-crop/'+photo.id+'" />' +
                           '<div><a style="font-size: 10px; margin: 4px;" onclick="openPanel('+photo.id+');" href="#">anadir</a></div>' +
                         '</li>';
                     $("#listPhotos").append(add);
               });
               calcMargins();
     });
}

$(document).ready(function(){
 loadImages();
 $("#modalPanel").dialog({
     autoOpen: false,
     modal: true,
     buttons: {
       "Cancelar": function() {
             $("#modalPanel").dialog("close");
        },
       "Anadir": function() {
             var object = $("#modalPanel_hidden").val();
             var album = $("#modalPanel input:radio[name=radioAlbum]:checked").val();
             if (album == null) {
                 alert("Escolhe um album");
             } else {
                 $.post("${pageContext.request.contextPath}/groupware-workbench/album/${albumMgr.id}/add/"+album+"/"+object);
                 $("#modalPanel").dialog("close");
             }
       }
     }
     });
});

function openPanel(idPhoto) {
     $("#modalPanel_hidden").val(idPhoto);
     $("#modalPanel").dialog("open");
}

function downPage(){
    if (actualPage > 0) {
        actualPage--;
    }
    loadImages();
}

function upPage() {
    if (sizeLastRequest == pageSize) {
        actualPage++;
    }
    loadImages();
}
//-->
</script>

<div id="list_anadir_container" style="${style}">
<div class="component_header" style="height: 25px ;">
    <span class="title">Fotos</span>
    <span style="float: right">
        <span class="span_link" style="color: white;" onclick="downPage();">anterior</span>
        <span style="margin-left: 4px;"></span>
        <span class="span_link" style="color: white;" onclick="upPage();">seguinte</span>
    </span>
</div>
       <ul id="listPhotos" style="list-style: none;"></ul>
</div>
<div id="modalPanel">
    <div>
        <h2>Albums:</h2>
        <input id="modalPanel_hidden" type="hidden" value=""/>
        <c:forEach items="${albums}" var="item">
            <div><input type="radio" name="radioAlbum" value="${item.id}">${item.title}</div>
        </c:forEach>
    </div>
</div>