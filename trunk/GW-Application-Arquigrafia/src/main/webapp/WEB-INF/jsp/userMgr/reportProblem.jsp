<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>
<%@ taglib prefix="photo" uri="http://www.groupwareworkbench.org.br/widgets/photomanager" %>
<%@ taglib prefix="arq" tagdir="/WEB-INF/tags" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Sugest&otilde;es e cr&iacute;ticas</title>
        <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/images/favicon.ico" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/reset.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/arq-common.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/header.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/know_more.css" />"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/forms.css"  />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/plugins/sds/css/smoothDivScroll.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/bay.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/footer.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/jquery.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/tagcloud.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/image_wall.css" />"/>
        <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/boxy.css" />"/>
        <script type="text/javascript" src="<c:url value="/js/jquery.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/js/jquery-ui-1.8.custom.min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/jquery.smoothDivScroll-0.9-min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/plugins/sds/js/scroll.js"/>"></script>
        <script type="text/javascript">
            $(document).ready(function() {
            	$('span#msg').hide();
            	$('span#subjectMsg').hide();
            	
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

            function validaForm() {
                d = document.formulario;
            	if (d.subject.value == "") {
                    $('span#subjectMsg').show();
            	    d.subject.focus();
            	    return false;
                }
                if (d.message.value == "") {
                    $('span#msg').show();
                    d.message.focus();
                    return false;
                }
                return true;
            }
        </script>
        <script src="<c:url value="/js/chili-1.7.pack.js"/>" type="text/javascript" ></script>
        <script src="<c:url value="/js/jquery.easing.js"/>" type="text/javascript"></script>
        <script src="<c:url value="/js/jquery.dimensions.js"/>" type="text/javascript"></script>
        <script src="<c:url value="/js/jquery.accordion.js"/>" type="text/javascript"></script>
        <script src="<c:url value="/js/bay.js"/>" type="text/javascript"></script>
        <script src="<c:url value="/js/jquery.boxy.js"/>" type="text/javascript"></script>
    </head>
    <body>
        <div id="wrap">
            <arq:header2 photoMgr="${photoMgr}" />
                <div id="corpo" class="default_div">
                <form id="form1" class="cmxform" name="formulario" method="POST" action="<c:url value="/user/${userMgr.id}/sendEmail/${userLogin.id}" />" accept-charset="UTF-8" onSubmit="return validaForm()" autocomplete="off">
                    <div id="info" class="default_info">
                	<span class="tituloPrincipal"> Reportar problemas:</span>
                        <ul class="field_line_f1">
                            <li class="label_f1"><span>Nome:</span></li>
                            <li class="input_f1"><c:out value="${sessionScope.userLogin.name}" /></li>
                        </ul>
                        <ul class="field_line_f1">
                            <li class="label_f1"><span>Assunto</span></li>
                            <li class="input_f1">
                                <input id="subject" type="text" name="subject" value="" />
                                <span id="subjectMsg">O campo Assunto tem que ser preenchido</span>
                            </li>
                        </ul>
                        <ul class="field_line_f1">
                            <li class="label_f1"><span>Reporte o problema:</span></li>
                            <li class="input_f1">
                                <input type="hidden" id="reason" name="reason" value="Reporte de problema: " />
                                <textarea rows="4" cols="60" id="message" name="message"> </textarea>
                                <span id="msg">O campo tem que ser preenchido </span>
                            </li>
                        </ul>
                        <br />
                    </div>
                    <div style="text-align: center;">
                        <input type="submit" class="botao" value="Enviar" />
                    </div>
                </form>
            </div>
            <div style="height: 30px; background-color: #fff"></div>
            <arq:footer photoMgr="${photoMgr}" />
        </div>
    </body>
</html>