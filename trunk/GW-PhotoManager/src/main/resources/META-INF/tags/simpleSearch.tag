<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/taglibs/reflection" prefix="r" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag" prefix="TagMgr" %>

<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.PhotoMgrInstance" %>
<%@ attribute name="seachLineClass" required="false" type="String" %>
<%@ attribute name="searchInputClass" required="false" type="String" %>
<%@ attribute name="searchButtonClass" required="false" type="String" %>

<div id="form_search">
    <form name="formBusca" action="<c:url value="/groupware-workbench/${photoInstance.id}/photo/busca"/>" method="post">
        <ul class="${searchLineClass}">
            <li class="${searchInputClass}"><input type="text" name="busca" /></li>
            <li class="${searchButtonClass}"><input type="submit" value="Buscar" /></li>
        </ul>
    </form>
</div>
