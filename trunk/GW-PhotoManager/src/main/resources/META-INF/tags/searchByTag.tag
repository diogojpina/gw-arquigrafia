<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/taglibs/reflection" prefix="r" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag" prefix="TagMgr" %>

<%@ attribute name="tagName" required="true" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.PhotoMgrInstance" %>
<%@ attribute name="tagMgr" required="true" rtexprvalue="true" type="br.org.groupware_workbench.collabElement.communic.tagMgr.api.TagMgrInstance" %>

<r:callMethod methodName="listGenericEntityIdByTagName" instance="${tagMgr}" var="ids">
    <r:param type="java.lang.String" value="${tagName}" />
</r:callMethod>



