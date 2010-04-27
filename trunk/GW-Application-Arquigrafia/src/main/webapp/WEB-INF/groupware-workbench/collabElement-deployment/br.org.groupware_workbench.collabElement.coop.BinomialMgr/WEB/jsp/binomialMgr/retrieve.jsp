<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.groupwareworkbench.org.br/widgets/commons" prefix="Widgets" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache">
        <title>Binômios</title>
		<link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
        <profile:ScriptProfile />
    </head>
    <body>
        <Widgets:Topo collabletInstance="${collabletInstance}" />
        <Widgets:ConteudoPagina titulo="">
            <h1>Binômios</h1>
            <center>
                <form method="post" action="<c:url value="/groupware-workbench/${param.collablet}/binomialMgr/${param.binomialMgr}" />" accept-charset="UTF-8">
                    <input type="hidden" name="binomial.id" value="<c:out value="${binomial.id}" />" />
                    <input type="hidden" name="binomial.idInstance" value="<c:out value="${param.binomialMgr}" />" />
                    <div class="form_1">
                        <div>
                        	<ul class="field_line_f1">
                            	<li class="label_f1"><span>1º Binômio:</span></li>
                            	<li class="input_f1"><input type="text" name="binomial.firstBinomial" value="<c:out value="${binomial.firstBinomial}" />" /></li>
                            </ul>
                        </div>
                        <div>
                        	<ul class="field_line_f1">
                            	<li class="label_f1"><span>2º Binômio:</span></li>
                            	<li class="input_f1"><input type="text" name="binomial.secondBinomial" value="<c:out value="${binomial.secondBinomial}" />" /></li>
                            </ul>
                        </div>
                        <div>
                        	<ul class="field_line_f1">
                            	<li class="label_f1"><span>Valor:</span></li>
                            	<li class="input_f1"><input type="text" name="binomial.value" value="<c:out value="${binomial.value}" />" /></li>
                            </ul>
                        </div>
                        <div>
                        	<ul class="bt_line_f1">
                        		<li class="bt_cell_submit">
                    				<input type="submit" class="botao" value="Ok"> &nbsp; &nbsp;
                    			</li>
                    			<li class="bt_cell_submit">
                    				<input type="button" class="botao" value="Cancela" onclick="history.back()">
                    			</li>
                    		</ul>
                    	</div>
                    </div>
                </form>
            </center>
        </Widgets:ConteudoPagina>
    </body>
</html>