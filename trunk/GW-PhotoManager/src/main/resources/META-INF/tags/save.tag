<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/taglibs/reflection" prefix="r" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag" prefix="TagMgr" %>

<%@ attribute name="photoRegister" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.Photo" %>
<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.PhotoMgrInstance" %>
<%@ attribute name="tagMgr" required="true" rtexprvalue="true" type="br.org.groupware_workbench.collabElement.communic.tagMgr.api.TagMgrInstance" %>



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

<TagMgr:ScriptTags/>


<input type="hidden" name="photoRegister.id" value="<c:out value="${photoRegister.id}" />" />
<table>
	<tr>
		<!--td colspan="2">Registrar uma foto</td-->
	</tr>
	<tr>
		<td>Nome:</td>
		<td><input type="text" name="photoRegister.nome"></td>
	</tr>
	<tr>
		<td>Descrição:</td>
		<td><textarea rows="3" name="photoRegister.descricao"></textarea></td>
	</tr>
	<tr>
		<td>Lugar onde foi tirada</td>
		<td><input type="text" name="photoRegister.lugar"></td>
	</tr>
	<tr style="vertical-align: top">
		<td>Tags:</td>
		<td>
			<c:if test="${tagMgr != null}">                                
	            <TagMgr:SelectTags tagMgr="${tagMgr}" />
	            <TagMgr:SetTags tagMgr="${tagMgr}" idObject="${photoRegister.id}" />
			</c:if>		
		</td>
	</tr>	
	<tr>
		<td>Data</td>
		<td><input type="text" id="datepicker" name=photoRegister.data>
		</td>
	</tr>
	<tr>
		<td>Arquivo:</td>
		<td><input type="file" name="foto"></td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value="Salvar"></td>
	</tr>
</table>