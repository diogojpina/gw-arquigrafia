<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Arquigrafia Brasil - &Aacute;lbuns</tiles:putAttribute>
	
	<tiles:putAttribute name="head">
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
            });
        </script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="body">
		<div class="main">
			<div class="text list-albums-frame">
				<div class="component_header">
					<span class="title">Meus &Aacute;lbuns</span>
				</div>
				<div class="criar-album">
					<span class="span_link" id="open_album_novo">criar novo
						&aacute;lbum</span>
				</div>
				<album:listAlbumByUser albumMgr="${albumMgr}" user="${userLogin}" />
			</div>
			<album:listAdicionar classe="list-adicionar" albumMgr="${albumMgr}"
				user="${userLogin}" />

			<div id="album_novo" class="text" title="Novo &aacute;lbum">
				<album:edit classe="edit-album" afterSaveFunction="afterSave"
					albumMgr="${albumMgr}" />
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertTemplate>

