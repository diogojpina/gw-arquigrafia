<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag" %>

<%@ attribute name="photoRegister" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>
<%@ attribute name="albumMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coop.album.AlbumMgrInstance" %>

<%@ attribute name="user" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.coord.user.User" %>

<%@ attribute name="formClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="formLineClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="formLabelClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="formInputClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="formLineBtClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="formSubmitBtClass" required="false" rtexprvalue="false" type="java.lang.String" %>

<script type="text/javascript">
    $(function() {
        $("#datepicker").datepicker({
            "showOn": "button",
            "changeMonth": true,
            "changeYear": true,
            "width": 15,
            "dateFormat": "dd/mm/yy", <%-- Atenção: De acordo com a documentação, yy é o ano com 4 dígitos. --%>
            "buttonImage": "${pageContext.request.contextPath}/images/calendar.gif",
            "buttonImageOnly": true
        });

        $("#imageUpload").jqUploader({
            background: "FFFFDF",
            barColor: "CD270A",
            allowedExt: "*.avi; *.jpg; *.jpeg; *.png",
            allowedExtDescr: "Images and movies (*.avi; *.jpg; *.jpeg; *.png)"
        });
    });
</script>

<tag:scriptTags />

<input type="hidden" name="user.id" value="<c:out value="${user.id}" />" />
<input type="hidden" name="photoRegister.id" value="<c:out value="${photoRegister.id}" />" />
<div class="${formClass}" id="image_save_form">
   <ul class="${formLineClass}" id="imageUploadField">
       <li class="${formLabelClass}"><span>Arquivo*:</span></li>
       <li class="${formInputClass}" id="imageUpload"><input id="imageUpload" type="file" name="foto" /></li>
   </ul>
   <fieldset>
       <legend>Nome e Descri&ccedil;&atilde;o</legend>
       <div class="${formLineClass}">
           <label for="photoRegister.nome" class="${formLabelClass}"><span>Nome*:</span></label>
           <span  class="${formInputClass}"><input type="text" name="photoRegister.nome" /></span>
       </div>
       <div class="${formLineClass}">
           <label for="photoRegister.descricao" class="${formLabelClass}"><span>Descri&ccedil;&atilde;o:</span></label>
           <textarea rows="3" name="photoRegister.descricao" class="${formInputClass}"></textarea>
       </div>
    </fieldset>
    <fieldset>
        <legend>Data e Localiza&ccedil;&atilde;o</legend>
        <div class="${formLineClass}">
            <label for="photoRegister.data" class="${formLabelClass}"><span>Data:</span></label>
            <span class="${formInputClass}"><input type="text" id="datepicker" name="photoRegister.data" /></span>
        </div>
        <div class="${formLineClass}">
            <label for="photoRegister.lugar" class="${formLabelClass}"><span>Localiza&ccedil;&atilde;o:</span></label>
            <span class="${formInputClass}"><input type="text" name="photoRegister.lugar"></span>
        </div>
    </fieldset>
    <fieldset>
        <legend>Dados Adicionais</legend>
        <!-- <ul class="${formLineClass}" style="vertical-align: top; height: 120px">
            <li class="${formLabelClass}"><span>Tags:</span></li>
            <li class="${formInputClass}">
                <c:if test="${tagMgr.collablet.enabled}">
                    <tag:selectTags tagMgr="${tagMgr}" />
                    <tag:setTags tagMgr="${tagMgr}" entity="${photoRegister}" />
                </c:if>
            </li>
        </ul> -->
        <ul class="${formLineBtClass}">
            <li class="${formSubmitBtClass}"><input id="imageSubmit" type="submit" value="Salvar" /></li>
        </ul>
    </fieldset>
</div>