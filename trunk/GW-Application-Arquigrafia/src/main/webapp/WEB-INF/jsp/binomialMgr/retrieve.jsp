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
        <title>Bin&ocirc;mios</title>
        <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/images/favicon.ico" />"/>
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
        </script>
    </head>
    <body>
        <arq:header2 photoMgr="${photoMgr}" />
        <w:conteudoPagina titulo="Bin&ocirc;mios">
            <form method="post" action="<c:url value="/groupware-workbench/binomials/${binomialMgr.id}" />" accept-charset="UTF-8">
                <input type="hidden" name="binomial.id" value="<c:out value="${binomial.id}" />" />

                <div class="form_1">
                    <div>
                        <ul class="field_line_f1">
                            <li class="label_f1"><span>1&ordm; Bin&ocirc;mio:</span></li>
                            <li class="input_f1"><input type="text" name="binomial.firstName" value="<c:out value="${binomial.firstName}" />" /></li>
                        </ul>
                    </div>
                    <div>
                        <ul class="field_line_f1">
                            <li class="label_f1"><span>Descri&ccedil;&atilde;o:</span></li>
                            <li class="input_f1"><input type="text" name="binomial.firstDescription" value="<c:out value="${binomial.firstDescription}" />" /></li>
                        </ul>
                    </div>
                    <div>
                        <ul class="field_line_f1">
                            <li class="label_f1"><span>Link:</span></li>
                            <li class="input_f1"><input type="text" name="binomial.firstLink" value="<c:out value="${binomial.firstLink}" />" /></li>
                        </ul>
                    </div>
                    <div>
                        <ul class="field_line_f1">
                            <li class="label_f1"><span>2&ordm; Bin&ocirc;mio:</span></li>
                            <li class="input_f1"><input type="text" name="binomial.secondName" value="<c:out value="${binomial.secondName}" />" /></li>
                        </ul>
                    </div>
                    <div>
                        <ul class="field_line_f1">
                            <li class="label_f1"><span>Descri&ccedil;&atilde;o:</span></li>
                            <li class="input_f1"><input type="text" name="binomial.secondDescription" value="<c:out value="${binomial.secondDescription}" />" /></li>
                        </ul>
                    </div>
                    <div>
                        <ul class="field_line_f1">
                            <li class="label_f1"><span>Link:</span></li>
                            <li class="input_f1"><input type="text" name="binomial.secondLink" value="<c:out value="${binomial.secondLink}" />" /></li>
                        </ul>
                    </div>
                    <div>
                        <ul class="field_line_f1">
                            <li class="label_f1"><span>Valor padr&atilde;o:</span></li>
                            <li class="input_f1"><input type="text" name="binomial.defaultValue" value="<c:out value="${binomial.defaultValue}" />" /></li>
                        </ul>
                    </div>
                    <div>
                        <ul class="bt_line_f1">
                            <li class="bt_cell_submit">
                                <input type="submit" class="botao" value="Ok" />
                            </li>
                        </ul>
                    </div>
                </div>
            </form>
            <div class="barra_botoes">
                <w:voltar collabletInstance="${binomialMgr.collablet}" />
            </div>
	    	<div>
            	<div style="height: 30px; background-color: #fff"></div>
            </div>
        </w:conteudoPagina>
        <div>
            <div style="height: 30px; background-color: #fff"></div>
            <arq:footer photoMgr="${photoMgr}" />
        </div>
    </body>
</html>