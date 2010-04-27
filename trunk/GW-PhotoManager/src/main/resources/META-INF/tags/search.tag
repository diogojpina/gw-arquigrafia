<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/taglibs/reflection" prefix="r" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag" prefix="TagMgr" %>


<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.PhotoMgrInstance" %>


<script type="text/javascript">
	$(function() {
		$("#datepicker")
				.datepicker(
						{
							showOn : 'button',
							changeMonth : true,
							changeYear : true,
							width : 15,
							dateFormat : 'dd/mm/yy',
							buttonImage : '${pageContext.request.contextPath}/images/calendar.gif',
							buttonImageOnly : true
						});
	});
</script>

<div id="form1">
<form name="formBusca"
	action="<c:url value="/groupware-workbench/${photoInstance.id}/photo/busca"/>"
	method="post">
<table>
	<tr>
		<td><input type="text" name="busca"></td>
	</tr>
	<tr>
		<td><input type="submit" value="Buscar"></td>
	</tr>
</table>
</form>
<br>
<span id="avancedSearch"><a href="#">Pesquisa Avançãda</a></span>
</div>

<div id="form2">
<form name="formBuscaAvanzada" action="<c:url value="/groupware-workbench/${photoInstance.id}/photo/buscaA"/>"
	method="post">
<table>
	<tr>
		<td>Nome:</td>
		<td><input type="text" name="nome"></td>
	</tr>
	<tr>
		<td>Descrição:</td>
		<td><textarea rows="3" name="descricao"></textarea></td>
	</tr>
	<tr>
		<td>Lugar onde foi tirada</td>
		<td><input type="text" name="lugar"></td>
	</tr>
	<tr>
		<td>Data</td>
		<td><input type="text" id="datepicker" name=date>
		</td>
	</tr>
	<tr>
		<td><input type="submit" value="Buscar"></td>
	</tr>
</table>
</form>
<br>
<span id="simpleSearch"><a href="#">Pesquisa Simple</a></span>
</div>

<script type="text/javascript">
	$("#form2").hide();
	$("#simpleSearch").click(function(){$("#form1").show();$("#form2").hide();});
	$("#avancedSearch").click(function(){$("#form2").show();$("#form1").hide();});
</script>
