<%--
    Description: Holds the list of components, plus the canvases and all associated structures.
    Created By: Gustavo H. Braga (gustavo.henrick@gmail.com)
    Date: 08/09/2010
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="Cache-Control" content="no-cache" />
        <title><c:out value="${Title}" /></title>
        <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/images/favicon.ico"/>"/>
    </head>
    <body>
        <div id="status_dialog"></div>

        <!-- Shows all available components in the system -->
        <div id="available_components" class="component_canvas">
            <div id="available_components_header" class="default_header">
                <h3>Collablets Dispon&iacute;veis</h3>
            </div>
            <div id="component_list">
                <c:set var="num" value="0"></c:set>
                <c:forEach var="extcol" items="${extCollabletInstanceList}">
                    <div>
                        <c:set var="num" value="${num + 1}" />
                        <h3>
                            <a id="instance-link-<c:out value="${num}" />" href="<c:out value="${extcol.componentTypeName}" />">
                                <img src="${pageContext.request.contextPath}/management/assets/images/${extcol.componentTypeName}_ico.png" class="acc_icon" alt="" />
                                <c:out value="${extcol.componentTypeName}" />
                            </a>
                        </h3>
                        <div>
                            <form id="comp_<c:out value="${extcol.id}" />">
                                <div>
                                    <input id="inst_<c:out value="${extcol.id}" />" type="checkbox" checked="<c:out value="${extcol.installed}" />" name="manager.eCRegister.installed" />
                                    <label for="inst_<c:out value="${extcol.id}" />">Instalado:</label>
                                </div>
                                <div>
                                    <textarea id="desc_<c:out value="${extcol.id}" />" rows="3" cols="35" name="manager.eCRegister.description"><c:out value="${extcol.description}" /></textarea>
                                </div>
                                <div>
                                    <input id="bt_mod_<c:out value="${extcol.id}" />" type="button" value="Modificar" />
                                    <script type="text/javascript">
                                        $(document).ready(function() {
                                            $("#bt_mod_<c:out value="${extcol.id}" />").click(function() {
                                                $.post(
                                                    '<c:out value="${pageContext.request.contextPath}" />/manager/<c:out value="${manager.id}" />/update/<c:out value="${extcol.componentTypeName}" />',
                                                    $('#comp_<c:out value="${extcol.id }" />').serialize(),
                                                    function(data) {
                                                        $("#status").text('O Collablet <c:out value="${extcol.componentTypeName}" /> foi modificado.');
                                                        $('#status_dialog').html('Collablet modificado!');
                                                        $("#status_dialog").dialog('open');
                                                    }
                                                );
                                            });
                                        });
                                    </script>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <script type="text/javascript">
                $(document).ready(function() {
                    $("#component_list").accordion({
                        header: "h3",
                        change: function(event, ui) {
                            var text = ui.newHeader.children("a").attr("href");
                            $.get('<c:out value="${pageContext.request.contextPath}" />/manager/<c:out value="${manager.id}" />/showInstances/' + text,
                                function(data) {
                                    $("#instances").html(data);
                                }
                            );
                        }
                    });
                });
            </script>
        </div>

        <!-- Shows installed components, widgets and relations among these components -->
        <div id="installed_components" class="component_canvas">
            <div id="left_installed_components">
                <div id="instance_selector">
                    <h3>Inst&acirc;ncias</h3>
                    <div id="instances"></div>
                </div>
                <div id="canvas_wrapper">
                    Listagem de widgets n&atilde;o dispon&iacute;vel
                </div>
            </div>
            <div style="padding-top: 5px;">
                <span>&nbsp;Status: <span id="status">Pronto</span></span>
            </div>

            <div id="canvas_tabs" style="margin: 5px; margin-left: 215px;">
                <ul style="height: 28px">
                    <li><a href="#c_tabs-1">Subordina&ccedil;&atilde;o</a></li>
                    <li><a href="#c_tabs-2">Depend&ecirc;ncia</a></li>
                </ul>

                <div id="c_tabs-1" class="canvas_tab" style="padding: 0px; margin: 0px; background-color: #FFF"></div>

                <div id="c_tabs-2" class="canvas_tab" style="padding: 0px; margin: 0px; background-color: #FFF"></div>
            </div>
        </div>

        <script type="text/javascript">
            $(document).ready(function() {
                $("#canvas_tabs").hide();
                $("#c_tabs-1").load(
                    '<c:out value="${pageContext.request.contextPath}" />/manager/<c:out value="${manager.id}" />/sub_canvas',
                    function(data) {
                        var selected = $("#instance-link-1").attr("href");
                        $.get(
                            '<c:out value="${pageContext.request.contextPath}" />/manager/<c:out value="${manager.id}" />/showInstances/' + selected,
                            function(data) {
                                $("#instances").html(data);
                            }
                        );
                        pageResize(); // TODO: Verificar se deveria estar dentro do callback do $.get.
                    }
                );
                //$("#c_tabs-2").load('<c:out value="${pageContext.request.contextPath}" />/manager/<c:out value="${manager.id}" />/dep_canvas');
                $('#status_dialog').dialog({
                    autoOpen: false,
                    modal: true,
                    buttons: {
                        'Ok': function() {
                            $(this).dialog('close');
                        }
                    }
                });
            });
        </script>
    </body>
</html>