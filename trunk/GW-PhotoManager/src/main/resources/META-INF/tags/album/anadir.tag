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
var pageSize = 10;
var actualPage = 0;
var sizeLastRequest = pageSize;
function loadImages() {
    $.getJSON("${pageContext.request.contextPath}/groupware-workbench/photo/${photoMgr.id}/listbypage/"+pageSize+"/"+actualPage,
             function(json) {
               sizeLastRequest = json.list.length;
               if(sizeLastRequest > 0) {
            	    $("#listPhotos").empty();
               }
               $.each(json.list, function(i,photo) {
                     var add = 
                         '<li style="float: left; margin-left: 9px; margin-bottom: 9px;" >' +
                           '<img src="${pageContext.request.contextPath}/groupware-workbench/photo/img-crop/'+photo.id+'" />' +
                           '<div><a style="font-size: 10px; margin: 4px;" onclick="openPanel('+photo.id+');" href="#">anadir</a></div>' +
                         '</li>';
                     $("#listPhotos").append(add);
               });
     });   
}

$(function(){
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

<div style="${style}">
<div style="height: 20px ;text-align: center; vertical-align: middle">
    <span><a href="#" onclick="downPage();">anterior</a></span>
    <span style="margin-left: 4px;"></span>
    <span><a href="#" onclick="upPage();">seguinte</a></span>
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