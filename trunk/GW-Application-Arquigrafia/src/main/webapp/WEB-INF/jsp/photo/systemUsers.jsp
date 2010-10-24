<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection"%>
<%@ taglib prefix="friends" uri="http://www.groupwareworkbench.org.br/widgets/friends"%>
<html>
<head>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/jquery.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/friends.css" />
<script type="text/javascript">
function aviso(){
    alert('seu convite foi enviado');
}
</script>
</head>
<body>
<div>
<c:if test="${userMgr.collablet.enabled}">
    <r:callMethod methodName="getAllElements" instance="${userMgr}" var="listUsers" />
    <div><c:forEach items="${listUsers}" var="u">
        <c:if test="${u.login != userLogin.login}">
            <div>
                <br/>
                <img src="<c:out value="${u.photoURL}" />" alt="foto do usuario" />
                &nbsp;
                <a href="${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/show/${u.id}">
                    <c:out value="${u.name}"/>
                </a>
                &nbsp;
                <friends:sendRequest friendsMgr="${friendsMgr}" user="${u}" afterRequestFunction="aviso" />
            </div>
        </c:if>
    </c:forEach></div>
</c:if>
</div>
</body>
</html>