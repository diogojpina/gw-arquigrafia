<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<%@ attribute name="photoMgr" required="true" rtexprvalue="true" type="br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance" %>

<%@ attribute name="searchInputClass" required="false" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="searchButtonClass" required="false" rtexprvalue="false" type="java.lang.String" %>

<div id="search_box">
    <form name="formBusca" action="<c:url value="/photo/${photoMgr.id}/busca"/>" method="post">
        <input type="text" name="busca" id="s_b_search" class="${searchInputClass}" />
        <input type="submit" value="Buscar" id="s_b_button" class="${searchButtonClass}" />
    </form>
</div>
