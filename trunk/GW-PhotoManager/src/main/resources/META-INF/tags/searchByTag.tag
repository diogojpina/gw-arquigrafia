<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/taglibs/reflection" prefix="r" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/tag" prefix="TagMgr" %>

<%@ attribute name="tagName" required="true" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="photoInstance" required="true" rtexprvalue="true" type="br.org.groupware_workbench.photo.PhotoMgrInstance" %>
<%@ attribute name="tagMgr" required="true" rtexprvalue="true" type="br.org.groupware_workbench.collabElement.communic.tagMgr.api.TagMgrInstance" %>

<%--
    TODO: Isto n�o tem o efeito desejado, pois a vari�vel ids ser� colocada no escopoda tag, o que far� com que esta
    chamada n�o tenha nenhum efeito externamente. Al�m disso, este tipo de coisa n�o � apropriada para tag-files, e sim
    para taglibs, pois aqui est� sendo feita uma chamada a API java. [Victor]
--%>
<r:callMethod methodName="listGenericEntityIdByTagName" instance="${tagMgr}" var="ids">
    <r:param type="java.lang.String" value="${tagName}" />
</r:callMethod>