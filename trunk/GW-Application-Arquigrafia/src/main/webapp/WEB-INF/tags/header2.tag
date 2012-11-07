<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="tracker" uri="http://www.groupwareworkbench.org.br/widgets/tracker" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>

<div id="header">
    <div id="title">
        <a href="${pageContext.request.contextPath}/groupware-workbench/photo/${photoInstance.id}/index">
            <img src="${pageContext.request.contextPath}/images/head1_left_top.png" width="350" height="100" alt="Arquigrafia Brasil" />
        </a>
    </div>
    <div id="header_top_right">
        <div id="user_top_links">
            <a href="${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/show/${userLogin.id}" class="black_link"><c:out value="${sessionScope.userLogin.name}" /></a>
            &nbsp;&nbsp;
            <a href="<c:url value="/j_spring_security_logout" />" class="gray_link">sair</a>
        </div>
        <div id="suggestions">
	         <a href="${pageContext.request.contextPath}/groupware-workbench/users/${userMgr.id}/suggest" class="white_link">Sugest&otilde;es e Cr&iacute;ticas</a><br />
	         <a href="${pageContext.request.contextPath}/groupware-workbench/users/${userMgr.id}/report" class="white_link">Reportar Problema</a>
        </div>
        <div id="user_bottom_links">
            <div style="height: 13px">
                <a class="user_bottom_icon_links" href="#" onclick="return showPhotoUpload();">  <img src="${pageContext.request.contextPath}/images/icon/upload.png" /> Enviar Imagem</a>&nbsp;|&nbsp;
                <a class="user_bottom_icon_links" href="${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/show/${userLogin.id}" onclick=""> <img src="${pageContext.request.contextPath}/images/icon/meuPerfil.png" /> Meu perfil</a>&nbsp;|&nbsp;
                <a class="user_bottom_icon_links" href="${pageContext.request.contextPath}/groupware-workbench/album/${albumMgr.id}"><img src="${pageContext.request.contextPath}/images/icon/meuArquigrafia.png" /> Meu Arquigrafia</a>
            </div>
        </div>
    </div>
    <div id="top_links" class="blue_link">
        <a href="${pageContext.request.contextPath}/groupware-workbench/photo/${photoInstance.id}/index">In&iacute;cio</a>
        &nbsp;|&nbsp;
        <div id="photoUploadContent" style="visibility: hidden; display: none;">
            <%--iframe id="photoUploadBody" name="photoUploadFrame" style="width: 800px; height: 400px; opacity: 0.95;" id="photoUploadFrame" src="${pageContext.request.contextPath}/groupware-workbench/photo/${photoInstance.id}/registra"></iframe --%>
            <iframe id="photoUploadData" name="photoUploadFrame" style="width: 800px; height: 400px; opacity: 0.95;" id="photoUploadFrame"></iframe>
        </div>
        

        <script type="text/javascript">
            function goInitPage() {
                window.location = "${pageContext.request.contextPath}";
            }

            function showPhotoUpload() {
            	$("#photoUploadData").attr("src","${pageContext.request.contextPath}/groupware-workbench/photo/${photoInstance.id}/registra");
                new Boxy($("#photoUploadContent").html(), {
                    title: "Use o formulário para enviar uma foto.",
                    modal: true,
                    closeText: "Fechar",
                    afterHide: goInitPage
                }).show();
                
            }

        </script>
        <a href="#" onclick="return showPhotoUpload();">Enviar Imagem</a>
        &nbsp;|&nbsp;
        <a href="${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/system_users">Usu&aacute;rios do sistema</a>
        <!-- TODO: solução temporária, aqui deve ser usado o papel e não o nome do usuário -->
        <c:if test = "${sessionScope.userLogin.name == 'Administrador'}">  
            &nbsp;|&nbsp;
            <a href="${pageContext.request.contextPath}/groupware-workbench/users/${userMgr.id}/list">Gerenciar usu&aacute;rios</a>
            &nbsp;|&nbsp;
            <a href="${pageContext.request.contextPath}/groupware-workbench/manager/${manager.id}">Gerenciar aplica&ccedil;&atilde;o</a>
            &nbsp;|&nbsp;
            <a href="${pageContext.request.contextPath}/groupware-workbench/tracker/${tracker.id}">Localizador de Usuários</a>
            &nbsp;|&nbsp;
            <a href="${pageContext.request.contextPath}/groupware-workbench/repository/${componentRepository.id}">Repositório Android</a>
        </c:if>
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