<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/taglibs/reflection" prefix="r" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag" prefix="TagMgr" %>

<%@ attribute name="photoRegister" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.Photo" %>
<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.PhotoMgrInstance" %>
<%@ attribute name="tagMgr" required="true" rtexprvalue="true" type="br.org.groupware_workbench.collabElement.communic.tagMgr.api.TagMgrInstance" %>
<%@ attribute name="formClass" required="false" type="java.lang.String"%>
<%@ attribute name="formLineClass" required="false" type="java.lang.String" %>
<%@ attribute name="formLabelClass" required="false" type="java.lang.String" %>
<%@ attribute name="formInputClass" required="false" type="java.lang.String" %>
<%@ attribute name="formLineBtClass" required="false" type="java.lang.String"%>
<%@ attribute name="formSubmitBtClass" required="false" type="java.lang.String" %>

<script type="text/javascript">
    $(function() {
        $("#datepicker").datepicker({
            "showOn": "button",
            "changeMonth": true,
            "changeYear": true,
            "width": 15,
            "dateFormat": "dd/mm/yyyy",
            "buttonImage": "${pageContext.request.contextPath}/images/calendar.gif",
            "buttonImageOnly": true
        });
    });
</script>

<TagMgr:ScriptTags/>

<input type="hidden" name="photoRegister.id" value="<c:out value="${photoRegister.id}" />" />
<div class="${formClass}" id="image_save_form">
    <ul class="${formLineClass}">
        <li class="${formLabelClass}"><span>Nome*:</span></li>
        <li class="${formInputClass}"><input type="text" name="photoRegister.nome"></li>
    </ul>
    <ul class="${formLineClass}" style="height:90px">
        <li class="${formLabelClass}"><span>Descri&ccedil;&atilde;o:</span></li>
        <li class="${formInputClass}"><textarea rows="3" name="photoRegister.descricao"></textarea></li>
    </ul>
    <ul class="${formLineClass}">
        <li class="${formLabelClass}"><span>Lugar onde foi tirada</span></li>
        <li class="${formInputClass}"><input type="text" name="photoRegister.lugar"></li>
    </ul>
    <ul class="${formLineClass}" style="vertical-align: top; height:100px">
        <li class="${formLabelClass}"><span>Tags:</span></li>
        <li class="${formInputClass}">
            <c:if test="${tagMgr != null}">
                <TagMgr:SelectTags tagMgr="${tagMgr}" />
                <TagMgr:SetTags tagMgr="${tagMgr}" idObject="${photoRegister.id}" />
            </c:if>
        </li>
    </ul>
    <ul class="${formLineClass}">
        <li class="${formLabelClass}"><span>Data:</span></li>
        <li class="${formInputClass}"><input type="text" id="datepicker" name="photoRegister.data" /></li>
    </ul>
    <ul class="${formLineClass}">
        <li class="${formLabelClass}"><span>Arquivo*:</span></li>
        <li class="${formInputClass}"><input type="file" name="foto" /></li>
    </ul>
    <ul class="${formLineBtClass}">
        <li class="${formSubmitBtClass}"><input type="submit" value="Salvar" /></li>
    </ul>
</div>