<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>

<div id="header">
    <div id="title">
        <a href="${pageContext.request.contextPath}/groupware-workbench/photo/${photoInstance.id}/index">
            <img src="${pageContext.request.contextPath}/images/head1_left_top.png" width="350" height="100" alt="Arquigrafia Brasil" />
        </a>
    </div>
    <div id="header_top_right">
        <div id="user_top_links">
            <a href="#" class="black_link"><c:out value="${sessionScope.userLogin.name}" /></a>
            &nbsp;&nbsp;
            <a href="<c:url value="/groupware-workbench/users/${userMgr.id}/logout" />" class="gray_link">sair</a>
        </div>
        <div id="suggestions">
            <a href="mailto:test@somewhere" class="white_link">Sugest&otilde;es e Cr&iacute;ticas</a><br />
            <a href="mailto:test@somewhere" class="white_link">Reportar Problema</a>
        </div>
        <div id="user_bottom_links">
            <!-- TODO: reativar links, quando for criado o lado de rede social do site. -->
            <div style="height: 13px"></div>
        </div>
    </div>
    <div id="top_links" class="blue_link">
        <a href="${pageContext.request.contextPath}/groupware-workbench/photo/${photoInstance.id}/index">In&iacute;cio</a>
        &nbsp;|&nbsp;
        <div id="photoUploadContent" style="visibility: hidden; display: none;">
            <iframe name="photoUploadFrame" style="width: 600px; height: 400px; opacity: 0.95;" id="photoUploadFrame" src="${pageContext.request.contextPath}/groupware-workbench/photo/${photoInstance.id}/registra"></iframe>
        </div>
        <div id="friendsContent" style="visibility: hidden; display: none;">            
            <div id="friendsFrame"></div>
        </div>
        <div id="edithFriends" style="visibility: hidden; display: none;">
            <div id="edithFriendsContent"></div>
        </div>
        <div id="friendsRequest" style="visibility: hidden; display: none;">
            <div id="friendsRequestContent"></div>
        </div>
        <div id="systemUsers" style="visibility: hidden; display: none;">
            <div id="systemUsersContent"></div>
        </div>
        <div id="profileDiv" style="visibility: hidden; display: none;">
            <iframe name="profileContentFrame" style="width: 400px; height: 600px; opacity: 0.95;"
                    id="profileContentFrame" src="${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/show/${userLogin.id}"></iframe>
        </div>
        <script type="text/javascript">
            function refreshPage() {
                window.location.reload(true);
            }

            function showPhotoUpload() {
                new Boxy($("#photoUploadContent").html(), {
                    title: "Use o formulário para enviar uma foto.",
                    modal: true,
                    closeText: "Fechar",
                    afterHide: refreshPage
                }).show();
            }

            function showFriends() {
                var url = "${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/list";
                $("#friendsFrame").load(url, function() {
                    new Boxy($("#friendsContent").html(), {
                        title: "Amigos",
                        modal: true,
                        closeText: "Fechar",
                        afterHide: function() {
                            $("#friendsFrame").empty();
                        }
                    }).show();
                });
            }

            function showSystemUsers() {
                var url = "${pageContext.request.contextPath}/groupware-workbench/photo/${photoInstance.id}/system_users";
                $("#systemUsersContent").load(url, function() {
                    new Boxy($("#systemUsers").html(), {
                        title: "Usu&aacute;rios do sistema",
                        modal: true,
                        closeText: "Fechar",
                        afterHide: function() {
                            $("#systemUsersContent").empty();
                        }
                    }).show();
                });
            }

            function showEdithFriends() {
                var url = "${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/edit";
                $("#edithFriendsContent").load(url, function() {
                    new Boxy($("#edithFriends").html(), {
                        title: "Editar amigos",
                        modal: true,
                        closeText: "Fechar",
                        afterHide: function() {
                            $("#edithFriendsContent").empty();
                        }
                    }).show();
                });
            }

            function showFriendsRequest() {
                var url = "${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/friendsRequest";
                $("#friendsRequestContent").load(url, function() {
                    new Boxy($("#friendsRequest").html(), {
                        title: "Convites",
                        modal: true,
                        closeText: "Fechar",
                        afterHide: function() {
                            $("#friendsRequestContent").empty();
                        }
                    }).show();
                });
            }

            function showProfile() {
                new Boxy($("#profileDiv").html(), {
                    title: "Meu Perfil",
                    modal: true,
                    closeText: "Fechar"
                }).show();
            }
        </script>
        <a href="#" onclick="return showPhotoUpload();">Upload de fotos</a>
        &nbsp;|&nbsp;
        <a href="#" onclick="return showProfile();">Meu Perfil</a>
        &nbsp;|&nbsp;
        <a href="#" onclick="return showFriends();">Meus Amigos</a>
        &nbsp;|&nbsp;
        <a href="#" onclick="return showFriendsRequest();">Convites</a>
        &nbsp;|&nbsp;
        <a href="#" onclick="return showEdithFriends();">Editar Amigos</a>
        &nbsp;|&nbsp;
        <a href="#" onclick="return showFriends();">Meus Amigos</a>
        &nbsp;|&nbsp;
        <a href="${pageContext.request.contextPath}/groupware-workbench/manager/${manager.id}">Gerenciador</a>
        &nbsp;|&nbsp;
        <a href="#" onclick="return showSystemUsers();">Usu&aacute;rios do sistema</a>
        &nbsp;|&nbsp;
        <a href="${pageContext.request.contextPath}/groupware-workbench/users/${userMgr.id}/list">Gerenciar Usu&aacute;rios</a>
    </div>
    <div id="search_field">
        <img src="${pageContext.request.contextPath}/images/head1_left2_top.png" width="99" height="100" alt="campo de busca" />
        <div id="search_input">
            <ul style="list-style: none">
                <li style="display: inline">
                    <photo:simpleSearch photoInstance="${photoInstance}" />
                </li>
                <li style="display: inline">
                    <div id="search_options1">
                        <!-- <span class="option_on">Texto</span>
                        <span class="fat_separator">|</span>
                        <span class="option_off">Tags</span> -->
                        <br />
                        <span id="advancedSearch">
                            <a href="#" class="orange_link">Busca Avan&ccedil;ada &gt;&gt;</a>
                        </span>
                    </div>
                    <div id="search_options2">
                        <!--<span class="option_on">Texto</span>
                        <span class="fat_separator">|</span>
                        <span class="option_off">Tags</span> -->
                        <br />
                        <span id="simpleSearch">
                            <a href="#" class="orange_link">Busca Simples &gt;&gt;</a>
                        </span>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div id="advancedSearchField" class="mid_blue_text">
        <div>
            <photo:advancedSearch photoInstance="${photoInstance}" formClass="form1" formLineClass="field_line_f1" formLabelClass="label_f1" formInputClass="input_f1"
                    formLineBtClass="bt_line_f1" formSubmitBtClass="bt_cell_submit" />
        </div>
        <div></div>
        <div style="clear: both"></div>
    </div>
    <script type="text/javascript">
        $("#search_options2").hide();
        $("#advancedSearchField").hide();
        $("#simpleSearch").click(function() {
            $("#search_options1").show();
            $("#search_options2").hide();
            $("#advancedSearchField").slideUp();
        });
        $("#advancedSearch").click(function() {
            $("#search_options2").show();
            $("#search_options1").hide();
            $("#advancedSearchField").slideDown();
        });
    </script>
</div>