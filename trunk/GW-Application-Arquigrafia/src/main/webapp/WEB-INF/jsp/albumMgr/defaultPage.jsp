<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="album" uri="http://www.groupwareworkbench.org.br/widgets/album" %>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Arquigrafia Brasil - &Aacute;lbuns</title>
        <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/images/favicon.ico"/>" />
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/reset.css" />" />
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/arq-common.css" />" />
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/header.css" />" />
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/know_more.css" />" />
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/forms.css"  />" />
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/plugins/sds/css/smoothDivScroll.css" />" />
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/footer.css" />" />
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/jquery.css" />" />
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/tagcloud.css" />" />
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/boxy.css" />" />
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/album.css" />" />
        <script type="text/javascript" src="<c:url value="/js/jquery.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery-ui.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/scroll.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.boxy.js"/>"></script>
        <script type="text/javascript">
            function afterSave() {
                $("#album_novo").dialog("close");
                window.location.reload();
            }
            
            $(document).ready(function() {
               $("#album_novo").dialog({
                    autoOpen: false,
                    modal: true,
                    width: 380,
                    height: 200
               });

               $("#open_album_novo").click(function(){
                   $("#album_novo").dialog("open");
               });

               $("div#makeMeScrollable").smoothDivScroll({
                   scrollingSpeed: 12,
                   mouseDownSpeedBooster: 3,
                   visibleHotSpots: "always",
                   startAtElementId: "startAtMe"
               });

               $("div#makeMeScrollable2").smoothDivScroll({
                   scrollingSpeed: 12,
                   mouseDownSpeedBooster: 3,
                    visibleHotSpots: "always",
                   startAtElementId: "startAtMe"
               });

            });

    </script>
    </head>
    <body>
        <arq:header2 photoMgr="${photoMgr}" />
        <div class="default_div">
        <div class="main">
            <div class="text list-albums-frame">
                <div class="component_header"><span class="title">Meus &Aacute;lbuns</span></div>
                <div class="criar-album">
                    <span class="span_link" id="open_album_novo">criar novo &aacute;lbum</span>
                </div>
                <album:listAlbumByUser albumMgr="${albumMgr}" user="${userLogin}"/>
            </div>
            <album:listAdicionar classe="list-adicionar" albumMgr="${albumMgr}" user="${userLogin}"/>

            <div id="album_novo" class="text"  title="Novo &aacute;lbum">
                <album:edit classe="edit-album" afterSaveFunction="afterSave" albumMgr="${albumMgr}"/>
            </div>
        </div>
        </div>
        <arq:footer photoMgr="${photoMgr}" />
    </body>
</html>