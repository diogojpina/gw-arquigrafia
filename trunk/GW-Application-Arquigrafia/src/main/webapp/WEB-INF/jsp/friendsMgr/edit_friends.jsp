<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="friends" uri="http://www.groupwareworkbench.org.br/widgets/friends"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/friends.css" />
<friends:editFriends user="${userLogin}" friendsMgr="${friendsMgr}" friends_header="friends_header"/>