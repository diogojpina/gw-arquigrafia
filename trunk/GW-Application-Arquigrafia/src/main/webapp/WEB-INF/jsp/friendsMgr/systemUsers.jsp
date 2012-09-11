<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="r" uri="http://www.groupwareworkbench.org.br/taglibs/reflection" %>
<%@ taglib prefix="friends" uri="http://www.groupwareworkbench.org.br/widgets/friends" %>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Convidar usu&aacute;rio</title>
        <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/images/favicon.ico"/>" />
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/friends.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/reset.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/arq-common.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/header.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/know_more.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/forms.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/plugins/sds/css/smoothDivScroll.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/bay.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/footer.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/jquery.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/tagcloud.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/image_wall.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/boxy.css" />"/>
        <script type="text/javascript" src="<c:url value="/js/jquery.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery-ui.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/scroll.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery.boxy.js"/>"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $("div#makeMeScrollable").smoothDivScroll({
                    scrollingSpeed: 12,
                    mouseDownSpeedBooster: 3,
                    visibleHotSpots: "always",
                    startAtElementId: "startAtMe"
                });

                $("div#makeMeScrollable2").smoothDivScroll({
                    scrollingSpeed: 12,
                    mouseDownSpeedBooster: 3,
                    visibleHotSpots: "always",
                    startAtElementId: "startAtMe"
                });
            });
        
        
        <script type="text/javascript">
            function aviso() {
                alert("Seu convite foi enviado.");
            }
        </script>
    </head>
    <body>
        <arq:header2 photoMgr="${photoMgr}" />
        <div class="default_div">
        <br />
        <span class="big_black_title" style="text-align: right; margin-left:10px;" >Usu&aacute;rios do sistema</span>
        <br />
            <c:if test="${userMgr.collablet.enabled}">
                <c:forEach items="${userMgr.allElements}" var="u">
                    <c:if test="${u.login != userLogin.login}">
                        <div style="float: left; margin: 20px auto; padding: 10px;">
                            <div class="linha">
                            	<a href="<c:url value="/friends/${friendsMgr.id}/show/${u.id}"/>">
                                    <c:choose>
                                        <c:when test="${empty u.photoURL}">
                                            <img class="imagem_user" src="<c:url value="/img/avatar.jpg" />" />
                                        </c:when>
                                        <c:otherwise>
                                            <img class="imagem_user" src="<c:out value="${u.photoURL}" />" alt="Foto do usu&aacute;rio" />
                                        </c:otherwise>
                                    </c:choose>
                            	</a>
                            	&nbsp;
                            	<div class="coluna"> 
                                    <div class="linha">
                                        <a class="blue_link" href="<c:url value="/friends/${friendsMgr.id}/show/${u.id}"/> ">
                                            <c:out value="${u.name}" />
                                        </a>
                                    </div>
                                    <div class="linha">
                                        <friends:sendRequest friendsMgr="${friendsMgr}" viewer="${userLogin}" viewed="${u}" afterRequestFunction="aviso" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </c:if>
        </div>
        <div>
    </body>
</html>