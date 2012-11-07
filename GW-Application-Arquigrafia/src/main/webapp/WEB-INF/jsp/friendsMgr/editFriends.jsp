<%@ include file="/WEB-INF/jsp/imports.jsp"%>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">
	<tiles:putAttribute name="title">Amigos</tiles:putAttribute>

	<tiles:putAttribute name="head">
		<script type="text/javascript">
            function refreshFriendsPage() {
                window.location.reload(true);
            }
        </script>
		<style>
			body {
				margin: 0px;
				background: url(../../../images/header_bg.jpg) no-repeat scroll 0 0
					transparent;
			}
		</style>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="body">
		<div id="corpo" class="default_div">
			<div id="info" class="default_info">
				<div id="top_links" class="blue_link"></div>
				<div>
					<span class="big_black_title">Editar Amigos</span> <a
						style="text-align: right;" class="blue_link"
						href="${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/show/${userLogin.id}">Meu
						perfil</a>
				</div>
				<br />
				<friends:editFriends style="width: 475px; float: right;"
					user="${userLogin}" friendsMgr="${friendsMgr}"
					afterRemoveFunction="refreshFriendsPage"
					friendsHeader="friends_header" />

				<friends:listFriendsRequests style="width: 475px;"
					user="${userLogin}" friendsMgr="${friendsMgr}"
					afterRejectFunction="refreshFriendsPage"
					afterAcceptFunction="refreshFriendsPage"
					friendsHeader="friends_header" />
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertTemplate>