<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/taglibs/reflection" prefix="r" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag" prefix="TagMgr" %>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.PhotoMgrInstance" %>
<%@ attribute name="formClass" required="false" type="java.lang.String" %>
<%@ attribute name="formLineClass" required="false" type="java.lang.String" %>
<%@ attribute name="formLabelClass" required="false" type="java.lang.String" %>
<%@ attribute name="formInputClass" required="false" type="java.lang.String" %>
<%@ attribute name="formLineBtClass" required="false" type="java.lang.String" %>
<%@ attribute name="formSubmitBtClass" required="false" type="java.lang.String" %>

<script type="text/javascript">
    $(function() {
        $("#datepicker_").datepicker({
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

<form name="formBuscaAvancada" action="<c:url value="/groupware-workbench/${photoInstance.id}/photo/buscaA"/>" method="post">
        <%-- TODO: Tableless! --%>
        <div class="${formClass}">
            <ul class="${formLineClass}">
        		<li class="${formLabelClass}"><span>Nome:</span></li>
                <li class="${formInputClass}"><input type="text" name="nome" /></li>
            </ul>
            <ul class="${formLineClass}" style="height: 90px">
        		<li class="${formLabelClass}"><span>Descrição:</span></li>
                <li class="${formInputClass}"><textarea rows="3" name="descricao"></textarea></li>
            </ul>
            <ul class="${formLineClass}">
        		<li class="${formLabelClass}"><span>Lugar onde foi tirada:</span></li>
                <li class="${formInputClass}"><input type="text" name="lugar" /></li>
            </ul>
            <ul class="${formLineClass}">
        		<li class="${formLabelClass}"><span>Data:</span></li>
                <li class="${formInputClass}"><input type="text" id="datepicker_" name="date" /></li>
            </ul>
		    <ul class="${formLineBtClass}">
		        <li class="${formSubmitBtClass}"><input type="submit" value="Buscar" /></li>
		    </ul>
        </div>
    </form>