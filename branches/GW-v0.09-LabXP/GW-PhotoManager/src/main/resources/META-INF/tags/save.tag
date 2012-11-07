<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag" %>
<%@ taglib prefix="gmaps" uri="http://www.groupwareworkbench.org.br/widgets/georeference" %>

<%@ attribute name="photoRegister" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>
<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>

<%@ attribute name="tagMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.communic.tag.TagMgrInstance" %>
<%@ attribute name="user" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.user.User" %>
<%@ attribute name="geoReferenceMgr" required="false" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.communic.georeference.GeoReferenceMgrInstance" %>

<%@ attribute name="formClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="formLineClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="formLabelClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="formInputClass" required="false" rtexprvalue="false" type="java.lang.String" %>

<tag:scriptTags />

<script type="text/javascript">
    $(document).ready(function() {
        var datepick = document.getElementById("datepicker");
        var data = new Date();
        datepick.value = data.getDate() + "/" + (data.getMonth() + 1) + "/" + data.getFullYear();
    });
    
    function showLicence(chkbox){
        var text = "Com uma licença Creative Commons, mantém os seus direitos de autor mas permite que outros "+
            "copiem e distribuam a sua obra desde que façam a atribuição."+
            "\n\n A sua imagem precisa de esta licença para poder ser enviada.";
        alert(text);
  		chkbox.checked = true;
    }
</script>

<script type="text/javascript">
    $(document).ready(function() {		
        $("#datepicker").datepicker({
            "showOn": "button",
            "changeMonth": true,
            "changeYear": true,
            "width": 15,
            "dateFormat": "dd/mm/yy", <%-- Aten��o: De acordo com a documenta��o, yy � o ano com 4 d�gitos. --%>
            "buttonImage": "${pageContext.request.contextPath}/images/calendar.gif",
            "buttonImageOnly": true
        });
    });
</script>

<input type="hidden" name="user.id" value="<c:out value="${user.id}" />" />
<input type="hidden" name="photoRegister.id" value="<c:out value="${photoRegister.id}" />" />

<div class="${formClass}" id="image_save_form">
   <ul class="${formLineClass}" id="imageUploadField">
       <li class="${formLabelClass}">
           <span>Arquivo*:</span>
       </li>
       <li class="${formInputClass}" id="imageUpload-li">
       	   <input id="imageUpload" type="file" name="foto" value="<c:out value="${photoRegister.nomeArquivo}" />" />
       </li>
   </ul>
   <fieldset>
       <legend>Nome e Descri&ccedil;&atilde;o</legend>
       <div class="${formLineClass}">
           <label for="photoRegister.nome" class="${formLabelClass}">
               <span>Nome:</span>
           </label>
           <span class="${formInputClass}">
               <input type="text" name="photoRegister.nome" value="<c:out value="${photoRegister.nome}" />" />
           </span>
       </div>
       <div class="${formLineClass}">
           <label for="photoRegister.descricao" class="${formLabelClass}">
               <span>Descri&ccedil;&atilde;o:</span>
           </label>
           <textarea rows="3" name="photoRegister.descricao" class="${formInputClass}"><c:out value="${photoRegister.descricao}" /></textarea>
       </div>
       <br/>
       <div>
       		<br/>
       		<span class="input_f1">
       		<input type="checkbox" name="opcao" onclick="showLicence(this);" value="aceitar" checked /> Li e concordo com a licença Creative Commons. 
       		Para mais informações clique <a target="_blanck" href="http://creativecommons.org/licenses/by/3.0/br/">aqui</a>.
       		</span>
       </div>
    </fieldset>
    
    <fieldset>
        <legend>Data e Informa&ccedil;&otilde;es arquitetonicas</legend>
        <div class="${formLineClass}">
            <label for="photoRegister.dataCriacao" class="${formLabelClass}">
                <span>Data da foto:</span>
            </label>
            <span class="${formInputClass}">
                <input type="text" id="datepicker" name="photoRegister.dataCriacao" />
            </span>
        </div>
        <div class="${formLineClass}">
            <label for="photoRegister.infoArquitetonicas" class="${formLabelClass}">
                <span>Informa&ccedil;&otilde;es arquitetonicas:</span>
            </label>
            <span class="${formInputClass}">
                <textarea name="photoRegister.infArquitetonicas" >${photoRegister.infArquitetonicas}</textarea>
            </span>
        </div>
    </fieldset>
    
    <fieldset>
        <legend>Localiza&ccedil;&atilde;o e Direitos Autorais</legend>
        <div class="${formLineClass}">
            <label for="photoRegister.cidade" class="${formLabelClass}">
                <span>Cidade:</span>
            </label>
            <span class="${formInputClass}">
                <input type="text" name="photoRegister.cidade" value="<c:out value="${photoRegister.cidade}" />" />
            </span>
        </div>
        <div class="${formLineClass}">
            <label for="photoRegister.estado" class="${formLabelClass}">
                <span>Estado:</span>
            </label>
            <span class="${formInputClass}">
                <input type="text" name="photoRegister.estado" value="<c:out value="${photoRegister.estado}" />" />
            </span>            
        </div>
        <div class="${formLineClass}">
            <label for="photoRegister.pais" class="${formLabelClass}">
                <span>Pais:</span>
            </label>
            <span class="${formInputClass}">
                <input type="text" name="photoRegister.pais" value="<c:out value="${photoRegister.pais}" />" />
            </span>            
        </div>
        <div class="${formLineClass}">
            <gmaps:setGeoref geoReferenceMgr="${geoReferenceMgr}" entity="${photoRegister}" />
        </div>
    </fieldset>

    <c:if test="${tagMgr.collablet.enabled}">
        <fieldset>
            <legend>Dados Adicionais</legend>
            <ul class="${formLineClass}" style="line-height: normal;">
                <li class="${formLabelClass}"><span>Tags:</span></li>
                <li class="${formInputClass}">
                    <label style="font-size: 12px; color: blue;">As tags devem ser separadas por v&iacute;rgulas</label>
                    <tag:selectTags tagMgr="${tagMgr}" />
                    <tag:setTags tagMgr="${tagMgr}" entity="${photoRegister}" />
                </li>
            </ul>
        </fieldset>
    </c:if>
</div>