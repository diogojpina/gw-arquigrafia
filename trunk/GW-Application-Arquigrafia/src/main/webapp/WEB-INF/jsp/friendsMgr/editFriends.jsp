<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="friends" uri="http://www.groupwareworkbench.org.br/widgets/friends" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/friends.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/arq-common.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/jquery.css" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript">
            function refreshFriendsPage() {
                window.location.reload(true);
            }
        </script>
    </head>
    <body style="margin: 0px; background: url(../../../images/header_bg.jpg) no-repeat scroll 0 0 transparent;">
        <div id="corpo" style="width: 990px;margin-left: auto; margin-right: auto; margin-top: 10px;">
            <div id="top_links" class="blue_link">
                <a href="${pageContext.request.contextPath}/groupware-workbench">In&iacute;cio</a>
                &nbsp;|&nbsp;
                <a href="${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/show/${userLogin.id}">Meu perfil</a>
            </div>

            <div style="background-color: #483E37;
                        color: white;
                        font-family: Arial,Helvetica,sans-serif;
                        height: 40px;
                        margin-bottom: 40px;
                        -webkit-border-radius: 5px;
                        -moz-border-radius: 5px;">
                <h2 style="padding-left: 30px; padding-top: 5px;">Editar Amigos</h2>
            </div>

            <friends:editFriends style="width: 475px; float: right;"
                    user="${userLogin}"
                    friendsMgr="${friendsMgr}"
                    afterRemoveFunction="refreshFriendsPage"
                    friendsHeader="friends_header" />

            <friends:listFriendsRequests style="width: 475px;"
                    user="${userLogin}"
                    friendsMgr="${friendsMgr}"
                    afterRejectFunction="refreshFriendsPage"
                    afterAcceptFunction="refreshFriendsPage"
                    friendsHeader="friends_header" />
        </div>
    </body>
</html>