<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ taglib prefix="tag" uri="http://www.groupwareworkbench.org.br/widgets/tag" %>

<%@ attribute name="photoRegister" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.Photo" %>
<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>
<%@ attribute name="tagMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.collablet.communic.tag.TagMgrInstance" %>
<%@ attribute name="formClass" required="false" type="java.lang.String" %>
<%@ attribute name="formLineClass" required="false" type="java.lang.String" %>
<%@ attribute name="formLabelClass" required="false" type="java.lang.String" %>
<%@ attribute name="formInputClass" required="false" type="java.lang.String" %>
<%@ attribute name="formLineBtClass" required="false" type="java.lang.String" %>
<%@ attribute name="formSubmitBtClass" required="false" type="java.lang.String" %>

<script type="text/javascript">
    $(function() {
        $("#datepicker").datepicker({
            "showOn": "button",
            "changeMonth": true,
            "changeYear": true,
            "width": 15,
            "dateFormat": "dd/mm/yy",
            "buttonImage": "${pageContext.request.contextPath}/images/calendar.gif",
            "buttonImageOnly": true
        });
    });
</script>

<tag:scriptTags />

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
    <ul class="${formLineClass}" style="vertical-align: top; height:120px">
        <li class="${formLabelClass}"><span>Tags:</span></li>
        <li class="${formInputClass}">
            <c:if test="${tagMgr != null}">
                <tag:selectTags tagMgr="${tagMgr}" />
                <tag:setTags tagMgr="${tagMgr}" idObject="${photoRegister.id}" />
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