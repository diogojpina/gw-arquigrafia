<%@ include file="/WEB-INF/jsp/imports.jsp" %>

<tiles:insertTemplate template="/WEB-INF/jsp/template.jsp">

	<tiles:putAttribute name="title">Usuário</tiles:putAttribute>

	<tiles:putAttribute name="body">
        <w:tabela baseUrl="/groupware-workbench/users"
              createUrl="/groupware-workbench/users/${userMgr.id}/create"
              msgAdd="Adicionar novo usuário"
              msgDelete="Tem certeza que deseja remover o usuário?"
              target="tabela-users"
              titles="${coll:asList3('Nome', 'Login', 'E-mail')}"
              columns="${coll:asList3('name', 'login', 'email')}"
              elements="${userList}" />
  
        <div id="corpo" class="default_div">
            <div id="info" class="default_info">
            <w:conteudoPagina titulo="Usu&aacute;rios">
                <div id="tabela-users"></div>
                <div class="barra_botoes" align="center">
                    <w:voltar collabletInstance="${userMgr.collablet.parent}" />
                </div>
            </w:conteudoPagina>
            </div>
        </div>
	</tiles:putAttribute>
</tiles:insertTemplate>
  