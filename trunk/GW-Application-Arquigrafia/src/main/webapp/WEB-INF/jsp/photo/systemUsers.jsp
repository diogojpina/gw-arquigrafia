<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ taglib prefix="friends" uri="http://www.groupwareworkbench.org.br/widgets/friends"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/friends.css" />
<style type="text/css">
.friend {
    height: 30px;
}

.friend span {
    float: left;
    width: 350px;
}
</style>
<div style="width: 450px;">
<c:if test="${userMgr.collablet.enabled}">
    <r:callMethod methodName="getAllElements" instance="${userMgr}" var="listUsers" />
    <div><c:forEach items="${listUsers}" var="u">
        <c:if test="${u.login != userLogin.login}">
            <div class="friend"><span><c:out value="${u.name}" /></span>
            <div><friends:sendRequest friendsMgr="${friendsMgr}" user="${u}" /></div>
            </div>
        </c:if>
    </c:forEach></div>
</c:if>
</div>