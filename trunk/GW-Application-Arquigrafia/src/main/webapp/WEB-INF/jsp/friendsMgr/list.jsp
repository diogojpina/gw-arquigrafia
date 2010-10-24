<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="friends" uri="http://www.groupwareworkbench.org.br/widgets/friends"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/friends.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/jquery.css" />
<script type="text/javascript">
function refreshPage() {
    window.location.reload(true);
}
</script>
</head>
<body>
<br/>
<friends:listFriendsRequests user="${userLogin}" friendsMgr="${friendsMgr}" afterRejectFunction="refreshPage" afterAcceptFunction="refreshPage" friends_header="friends_header" />
<br/>
<friends:listFriends user="${user}" friendsMgr="${friendsMgr}" friends_header="friends_header" />
<br/>
<friends:editFriends user="${userLogin}" friendsMgr="${friendsMgr}" afterRemoveFunction="refreshPage" friends_header="friends_header"/>
<br/>
</body>
</html>