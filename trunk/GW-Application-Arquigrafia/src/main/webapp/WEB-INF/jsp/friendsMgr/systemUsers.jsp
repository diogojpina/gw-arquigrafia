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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/friends.css" />
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
	    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css" />
	    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/arq-common.css" />
	    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
	    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/know_more.css" />
	    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/forms.css"  />
	    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/plugins/sds/css/smoothDivScroll.css" />
	    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/bay.css" />
	    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/footer.css" />
	    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/jquery.css" />
	    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/tagcloud.css" />
	    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/image_wall.css" />
	    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/boxy.css" />
	    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.custom.min.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/plugins/sds/js/scroll.js"></script>
	    <script  type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.boxy.js"></script>
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
        </script>
        
        <script type="text/javascript">
            function aviso() {
                alert("Seu convite foi enviado.");
            }
        </script>
    </head>
    <body>
    	<arq:header2 photoInstance="${photoMgr}" />
    	<div style="margin-top: 20px;background: white; width:100%; height:500px; min-height: 300px; margin-top: 0px;padding-top:0px;overflow: auto;">
    	<br />
    	<span class="big_black_title" style="text-align: right;" >Usu&aacute;rios do sistema</span>
    	<br />
            <c:if test="${userMgr.collablet.enabled}">
                <c:forEach items="${userMgr.allElements}" var="u">
                    <c:if test="${u.login != userLogin.login}">
						<div style="float: left; margin: 20px auto; padding: 10px;" >
							<div class="linha">
                            	<a href="${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/show/${u.id}"><img class="imagem_user" src="<c:out value="${u.photoURL}" />" alt="Foto do usu&aacute;rio" /></a>
                            	&nbsp;
                            	<div class="coluna"> 
                            		<div class="linha">
	                            		<a class="blue_link" href="${pageContext.request.contextPath}/groupware-workbench/friends/${friendsMgr.id}/show/${u.id}">
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
        	<div style="height: 30px; background-color: #fff"></div>
            <arq:footer photoInstance="${photoMgr}" />
		</div>
    </body>
</html>