<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="photoMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>

<%@ attribute name="formClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="formLineClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="formLabelClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="formInputClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="formLineBtClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="formSubmitBtClass" required="false" rtexprvalue="false" type="java.lang.String" %>

<script type="text/javascript">
    $(function() {
        $("#datepicker_").datepicker({
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

<form name="formBuscaAvancada" action="<c:url value="/photo/${photoMgr.id}/buscaA"/>" method="post">
    <div class="${formClass}">
        <ul class="${formLineClass}">
            <li class="${formLabelClass}"><span>Nome:</span></li>
            <li class="${formInputClass}"><input type="text" name="nome" /></li>
        </ul>
        <ul class="${formLineClass}" style="height: 65px">
            <li class="${formLabelClass}"><span>Descri&ccedil;&atilde;o:</span></li>
            <li class="${formInputClass}"><textarea rows="3" name="descricao"></textarea></li>
        </ul>
        <ul class="${formLineClass}" style="float: left">
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