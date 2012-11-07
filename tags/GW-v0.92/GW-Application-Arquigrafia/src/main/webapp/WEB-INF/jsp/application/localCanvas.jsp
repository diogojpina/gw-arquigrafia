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
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
    </head>
    <body>
        <div style="width: 100%; height: 100%">
            <div id="local_canvas<c:out value="${canvasType.ordinal}" />_menu" style="height: 70px; width: 100%; border-bottom: #666 1px solid; background-color: #FFE897; z-index: 100; overflow: scroll; overflow-x: auto; overflow-y: auto;">
                <c:forEach var="extcol" items="${extCollabletInstanceList}">
                    <div class="draggable" style="float: left; padding: 5px; opacity: 0.7" title="<c:out value="${extcol.componentTypeName}" />" id="big_icon_<c:out value="${extcol.id}" />">
                        <img src="${pageContext.request.contextPath}/management/assets/images/<c:out value="${extcol.componentTypeName}" />_big.png" alt="<c:out value="${extcol.description}" />" />
                        <div style="max-width: 48px; text-align: center; overflow: hidden;">
                            <c:out value="${extcol.componentTypeName}" />
                        </div>
                    </div>

                    <div id="dialog_inst_<c:out value="${extcol.componentTypeName}" /><c:out value="${canvasType.ordinal}" />">
                        Selecione uma inst&acirc;ncia:<br />
                        <select id="sel_inst_<c:out value="${extcol.componentTypeName}" /><c:out value="${canvasType.ordinal}" />">
                            <c:forEach var="instance" items="${extcol.collablets}">
                                <option value="<c:out value="${instance.id}" />" ><c:out value="${instance.name}" /></option>
                            </c:forEach>
                        </select>
                    </div>

                    <script type="text/javascript">
                        $('#dialog_inst_<c:out value="${extcol.componentTypeName}" /><c:out value="${canvasType.ordinal}" />').dialog({
                            autoOpen: false,
                            modal: true,
                            buttons: {
                                'Selecionar': function() {
                                    createComponent({
                                        id: $('#sel_inst_<c:out value="${extcol.componentTypeName}" /><c:out value="${canvasType.ordinal}" />').val(),
                                        container: "local_canvas<c:out value="${canvasType.ordinal}" />",
                                        position: [$("#coord_left").val(), $("#coord_top").val()],
                                        constraints: [$("#local_canvas<c:out value="${canvasType.ordinal}" />").offset().left, $("#local_canvas<c:out value="${canvasType.ordinal}" />").offset().top],
                                        name: $('#sel_inst_<c:out value="${extcol.componentTypeName}" /><c:out value="${canvasType.ordinal}" />').text(),
                                        setters: [],
                                        getters: ["<c:out value="${canvasType.edgeText}" />", "<c:out value="${canvasType.edgeText}" />"],
                                        type: <c:out value="${canvasType.ordinal}" />
                                    });
                                    $(this).dialog('close');
                                },
                                'Cancelar': function() {
                                    $(this).dialog('close');
                                }
                            }
                        });
                    </script>
                </c:forEach>
            </div>
            <div class="droppable" id="local_canvas<c:out value="${canvasType.ordinal}" />" style="background-color: #FFF; overflow: scroll; overflow-x: auto; overflow-y: auto; "></div>
        </div>

        <form>
            <input type="hidden" id="coord_left" value="0" />
            <input type="hidden" id="coord_top" value="0" />
        </form>

        <script type="text/javascript">
            $(document).ready(function() {
                $('.draggable').draggable({ scroll: false, revert: false, helper: 'clone' });
                $('.draggable').disableSelection();

                var comp_x;
                var comp_y;
                $(".droppable").droppable({
                    accept: '.draggable',
                    drop: function(event, ui) {
                        $("#coord_left").val(ui.offset.left);
                        $("#coord_top").val(ui.offset.top);
                        $("#dialog_inst_" + ui.draggable.attr("title") + "<c:out value="${canvasType.ordinal}" />").dialog('open');
                    }
                });
            });
        </script>
    </body>
 </html>