<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="friends" uri="http://www.groupwareworkbench.org.br/widgets/friends"%>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/page_content.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/friends.css" />
        <title>Friends</title>
    </head>
    <body>
    <div style="padding-left: 15px">
    
            <friends:listFriendsRequests user="${user}" friendsMgr="${friendsMgr}" friends_header="friends_header"/>
            <br/>
            <friends:listFriends user="${user}" friendsMgr="${friendsMgr}" friends_header="friends_header" />
            <br/>
            <friends:editFriends user="${user}" friendsMgr="${friendsMgr}" friends_header="friends_header"/>


		    <c:if test="${userMgr.collablet.enabled}">
		    	<r:callMethod methodName="getAllElements" instance="${userMgr}" var="listUsers"/>    	
		    	
		    	<div>
			    	<c:forEach items="${listUsers}" var="u">
			    		<div class="all_friends">
			    		<c:if test="${u.login != user.login}">
			    			<c:out value="${u.login}"/>  <friends:sendRequest friendsMgr="${friendsMgr}" user="${u}"/>
			    		</c:if>
			    		</div>
			    		
			   		</c:forEach>
		   		</div>
		    </c:if>
		    </div>
    </body>
</html>