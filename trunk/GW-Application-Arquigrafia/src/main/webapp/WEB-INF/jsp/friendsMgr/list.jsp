<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="friends" uri="http://www.groupwareworkbench.org.br/widgets/friends" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Amigos</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/friends.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/jquery.css" />
        <script type="text/javascript">
            function refreshFriendsPage() {
                window.location.reload(true);
            }
        </script>
    </head>
    <body>
        <br />
        <friends:listFriendsRequests user="${userLogin}" friendsMgr="${friendsMgr}" afterRejectFunction="refreshFriendsPage" afterAcceptFunction="refreshFriendsPage" friendsHeader="friends_header" />
        <br/>
        <friends:listFriends user="${userLogin}" friendsMgr="${friendsMgr}" friendsHeader="friends_header" />
        <br/>
        <friends:editFriends user="${userLogin}" friendsMgr="${friendsMgr}" afterRemoveFunction="refreshFriendsPage" friendsHeader="friends_header" />
        <br/>
    </body>
</html>