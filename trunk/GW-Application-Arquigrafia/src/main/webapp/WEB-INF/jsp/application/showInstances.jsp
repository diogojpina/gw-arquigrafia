<!--
    Description: Holds the list of components, plus the canvases and all associated structures. 
    Created By: Gustavo H. Braga (gustavo.henrick@gmail.com)
    Date: 08/09/2010
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.groupwareworkbench.org.br/widgets/commons" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="Cache-Control" content="no-cache" />
        <title>showInstance</title>
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
    </head>
    <body>
        <div id='create_instance_dialog_<c:out value="${extCollablet.componentTypeName}" />'class="create_instance_dialog" title="${extCollablet.componentTypeName} - Nova Inst&acirc;ncia">
            <form id="instance_form_<c:out value="${extCollablet.componentTypeName}" />">
                <input type="hidden" name="manager.register.className" value="<c:out value="${extCollablet.componentClassName}" />" />
                <fieldset class="ui-helper-reset">
                    <label for="instance_name">Nome*:</label>
                    <input type="text" name="manager.register.name" id="instance_name_<c:out value="${extCollablet.componentTypeName}" />" value="" class="ui-widget-content ui-corner-all" />
                    <label for="instance_description">Descri&ccedil;&atilde;o:</label>
                    <textarea name="manager.register.description" id="instance_description_<c:out value="${extCollablet.componentTypeName}" />" class="ui-widget-content ui-corner-all"></textarea>
                </fieldset>
            </form>
        </div>

        <div id="instance_list_wrapper">
            <div id="instance_list"></div>
            <div>
                <div style="height: 30px">
                    <div id="instance_create_button" class="basic_button ui-state-default ui-corner-all" title="remover instância">
                        <a href="#"><span class="ui-icon ui-icon-plusthick"></span></a>
                    </div>
                    <div id="instance_create">
                        Criar Nova Inst&acirc;ncia
                    </div>
                </div>
            </div>
        </div>

        <div id="dummy_pos"></div>
        <div id="dummy_rel"></div>

        <script type="text/javascript">
            $(document).ready(function() {
                <c:forEach var="instance" items="${extCollablet.collablets}">
                    addInstance('<c:out value="${instance.name}" />', '<c:out value="${extCollablet.componentTypeName}" />', '<c:out value="${instance.description}" />', '<c:out value="${instance.id}" />');
                </c:forEach>
				
                function popSubordinates() {
                    $("#local_canvas2").html("");
                    <c:forEach var="instance" items="${extCollablet.collablets}">
                        $.get(
                            '<c:out value="${pageContext.request.contextPath}" />/groupware-workbench/manager/<c:out value="${manager.id}" />/get-position/<c:out value="${instance.id}" />/on-canvas/<c:out value="${extCollablet.subordinations.id}" />',
                            function(data) {
                                $("#dummy_pos").html(data);
                                var x = $('#coord_x_<c:out value="${instance.id}" />').val();
                                var y = $('#coord_y_<c:out value="${instance.id}" />').val();
                                $.get(
                                    '<c:out value="${pageContext.request.contextPath}" />/groupware-workbench/manager/<c:out value="${manager.id}" />/get-relation/<c:out value="${instance.id}" />/on-canvas/<c:out value="${extCollablet.subordinations.id}" />',
                                    function(data) {
                                        $("#dummy_rel").html(data);
                                        var subSetters = new Array("subordina");
                                        var relTo = new Array();
                                        var count  = -1;

                                        do {
                                            count = count + 1;
                                            relTo[count] = $('#rel_from_<c:out value="${instance.id}" />_' + count).val();
                                            subSetters[count + 1] = relTo[count];
                                        } while (relTo[count] != null);

                                        createComponent(
                                            '<c:out value="${instance.id}" />',
                                            "local_canvas",
                                            [x, y],
                                            [$("#local_canvas").offset().left, $("#local_canvas").offset().top],
                                            '<c:out value="${instance.name}" />',
                                            subSetters,
                                            ["subordinado a", "subordinado a"],
                                            1,
                                            <c:out value="${extCollablet.subordinations.id}" />
                                        );
                                    }
                                );
                            }
                        );
                    </c:forEach>
                }

                function popDependences() {
                    $("#local_canvas").html("");
                    <c:forEach var="instance" items="${extCollablet.collablets}">
                        $.get(
                            '<c:out value="${pageContext.request.contextPath}" />/groupware-workbench/manager/<c:out value="${manager.id}" />/get-position/<c:out value="${instance.id}" />/on-canvas/<c:out value="${extCollablet.dependencies.id}" />',
                            function(data) {
                                $("#dummy_pos").html(data);
                                var x = $('#coord_x_<c:out value="${instance.id}" />').val();
                                var y = $('#coord_y_<c:out value="${instance.id}" />').val();
                                createComponent(
                                    '<c:out value="${instance.id}" />',
                                    "local_canvas2",
                                    [x, y],
                                    [$("#local_canvas2").offset().left, $("#local_canvas2").offset().top],
                                    '<c:out value="${instance.name}" />',
                                    ["dependence", "dependence"],
                                    ["depends", "depends"],
                                    2
                                );
                                $.get(
                                    '<c:out value="${pageContext.request.contextPath}" />/groupware-workbench/manager/<c:out value="${manager.id}" />/get-relation/<c:out value="${instance.id}" />/on-canvas/<c:out value="${extCollablet.dependencies.id}" />',
                                    function(data) {
                                        $("#dummy_rel").html(data);
                                        var from = $('#rel_from_<c:out value="${instance.id}" />').val();
                                    }
                                );
                            }
                        );
                    </c:forEach>
                }

                $("#canvas_tabs").show();
                $("#canvas_tabs").tabs({
                    select: function(event, ui) {
                        if (ui.panel.id == "c_tabs-2") {
                            // popDependences();
                        }
                        if (ui.panel.id == "c_tabs-1") {
                            popSubordinates();
                        }
                    }
                });

                var $dialog = $('#create_instance_dialog_<c:out value="${extCollablet.componentTypeName}" />').dialog({
                    autoOpen: false,
                    modal: true,
                    buttons: {
                        'Criar': function() {
                            addInstance($('#instance_name_<c:out value="${extCollablet.componentTypeName}" />').val(), '<c:out value="${extCollablet.componentTypeName}" />', $('#instance_description_<c:out value="${extCollablet.componentTypeName}" />').val());
                            formData = $('#instance_form_<c:out value="${extCollablet.componentTypeName}" />').serialize();
                            $.post(
                                '<c:out value="${pageContext.request.contextPath}" />/groupware-workbench/manager/<c:out value="${manager.id}" />/addInstance',
                                formData,
                                function(data) {
                                    $('#instance_form_<c:out value="${extCollablet.componentTypeName}" />').clearForm();
                                    //$("#main_content").html(data);
                                }
                            );
                            $(this).dialog('close');
                        },
                        'Cancelar': function() {
                            $(this).dialog('close');
                        }
                    },
                    open: function() {
                        $('#instance_name_<c:out value="${extCollablet.componentTypeName}" />').focus();
                    },
                    close: function() {
                        $('#instance_form_<c:out value="${extCollablet.componentTypeName}" />').reset();
                    }
                });

                $("#instance_create_button").click(function() {
                    $dialog.dialog('open');
                });

                $("#local_canvas").html("");
                $("#local_canvas2").html("");

                popSubordinates();
            });
        </script>
    </body>
 </html>