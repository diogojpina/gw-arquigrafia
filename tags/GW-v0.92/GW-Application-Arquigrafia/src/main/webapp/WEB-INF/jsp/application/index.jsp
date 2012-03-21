<%--
    Description: Holds the header, the footer, and the tabs of the site.
    Created By: Gustavo H. Braga (gustavo.henrick@gmail.com)
    Date: 08/08/2010
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
        <!-- BASIC CSS -->
        <link type="text/css" href="${pageContext.request.contextPath}/management/assets/css/reset.css" rel="stylesheet" />
        <!-- YUI -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/management/assets/external/fonts-min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/management/assets/external/yui/reset/reset-min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/management/assets/css/Wire_it.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/management/assets/css/basic_layout.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/management/assets/css/canvas_components.css" />
        <!--  MORE BASIC CSS -->
        <link type="text/css" href="${pageContext.request.contextPath}/management/assets/css/themes/sunny/jquery-ui-1.8.2.custom.css" rel="stylesheet" />
        <link type="text/css" href="${pageContext.request.contextPath}/management/assets/css/basic_layout.css" rel="stylesheet" />
        <link type="text/css" href="${pageContext.request.contextPath}/management/assets/css/instances.css" rel="stylesheet" />
        <!--  SUPPORT JS  -->
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/external/utilities.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/external/container-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/external/json-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/external/inputex.js"></script>

        <!-- Excanvas -->
        <!--[if IE]>
            <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/external/excanvas.js"></script>
        <![endif]-->

        <!-- BASIC JS -->
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/js/layout.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/js/animations.js"></script>
        <!-- WireIt -->
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/js/wireit/WireIt.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/js/wireit/CanvasElement.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/js/wireit/Wire.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/js/wireit/Terminal.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/js/wireit/util/DD.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/js/wireit/util/DDResize.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/js/wireit/Container.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/js/wireit/Layer.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/js/wireit/ImageContainer.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/js/canvas_components.js" ></script>
        <!-- SPECIFIC CONFIGURATION: LAYOUT -->
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/js/specific_configuration_layout.js" ></script>
        <!-- SPECIFIC CONFIGURATION: ANIMATIONS -->
        <script type="text/javascript" src="${pageContext.request.contextPath}/management/assets/js/specific_configuration_animations.js" ></script>
        <style type="text/css">
            div.WireIt-Layer {
                height: 1000px;
            }
        </style>

        <script type="text/javascript">
            $(document).ready(function() {
                $("#main_content").load(
                    '<c:out value="${pageContext.request.contextPath}" />/groupware-workbench/manager/<c:out value="${manager.id}" />/main'
                );
            });

            function onMoved(id, canvasId, pos_x, pos_y) {
                $.post('<c:out value="${pageContext.request.contextPath}" />/groupware-workbench/manager/<c:out value="${manager.id}" />/set-position/' + id + '/on-canvas/' + canvasId + '/' + pos_x + '/' + pos_y);
            }

            function handleWire(args, callback) {
                var wire = args[0];
                //alert($(args[0].terminal1.parentEl).attr("id"));
                var terminal1 = wire.terminal1;
                var terminal2 = wire.getOtherTerminal(terminal1);
                if ($(terminal2.parentEl).attr("id") == null) return;

                var source;
                var target;
                var terminal1Type = terminal1.options.ddConfig.type;
                var terminal2Type = terminal2.options.ddConfig.type;
                if (terminal1Type == "setter" && terminal2Type == "getter") {
                    source = terminal1;
                    target = terminal2;
                } else if (terminal1Type == "getter" && terminal2Type == "setter") {
                    source = terminal2;
                    target = terminal1;
                } else {
                    alert("Invalid connection.");
                    terminal1.removeWire(wire);
                    return;
                }
                callback(source, target);
            }

            function onAddWire1(event, args) {
                handleWire(args, function(source, target) {
                    var sourceId = $(source.parentEl).attr("id");
                    var targetId = $(target.parentEl).attr("id");
                    $.post('<c:out value="${pageContext.request.contextPath}" />/groupware-workbench/manager/<c:out value="${manager.id}" />/subordinate/' + targetId + '/to/' + sourceId,
                        function(data) {
                            $("#status").text($(source.parentEl).attr("title") + " subordina " + $(target.parentEl).attr("title"));
                        }
                    );
                });
            }

            function onRemoveWire1(event, args) {
                handleWire(args, function(source, target) {
                    var sourceId = $(source.parentEl).attr("id");
                    var targetId = $(target.parentEl).attr("id");
                    $.post('<c:out value="${pageContext.request.contextPath}" />/groupware-workbench/manager/<c:out value="${manager.id}" />/unsubordinate/' + targetId + '/from/' + sourceId,
                        function(data) {
                            $("#status").text($(source.parentEl).attr("title") + " não mais subordina " + $(target.parentEl).attr("title"));
                        }
                    );
                });
            }

            function onAddWire2(event, args) {
                handleWire(args, function(source, target) {
                    var sourceId = $(source.parentEl).attr("id");
                    var targetId = $(target.parentEl).attr("id");
                    $.post('<c:out value="${pageContext.request.contextPath}" />/groupware-workbench/manager/<c:out value="${manager.id}" />/add-dependency/' + targetId + '/of/' + sourceId,
                        function(data) {
                            $("#status").text($(source.parentEl).attr("title") + " é dependência de " + $(target.parentEl).attr("title"));
                        }
                    );
                });
            }

            function onRemoveWire2(event, args) {
                handleWire(args, function(source, target) {
                    var sourceId = $(source.parentEl).attr("id");
                    var targetId = $(target.parentEl).attr("id");
                    $.post('<c:out value="${pageContext.request.contextPath}" />/groupware-workbench/manager/<c:out value="${manager.id}" />/remove-dependency/' + targetId + '/of/' + sourceId,
                        function(data) {
                            $("#status").text($(source.parentEl).attr("title") + " não mais é dependência de " + $(target.parentEl).attr("title"));
                        }
                    );
                });
            }

            function remove(numModel, name, type) {
                $("#inst_details" + numModel).html("");
                $("#inst_details" + numModel).css("height", "0px");
                $.post('<c:out value="${pageContext.request.contextPath}" />/groupware-workbench/manager/<c:out value="${manager.id}" />/disable/' + name + '/' + type,
                    function(data) {}
                );
            }

            var numModel = 0;
            function getInstanceModel(name, type, description, id) {
                numModel++;
                // TODO: Achar um jeito melhor de fazer isto.
                var model =
                    '<div class="instance_input" id="inst_details' + numModel + '" >' +
                        '<div class="instance_toggle_details basic_button">' +
                            '<a href="#" id="details_bt_' + numModel + '" >' +
                                '<img id="bullet1_' + numModel + '" src="${pageContext.request.contextPath}/management/assets/images/bullet.png" alt="Detalhes" style="padding-top: 3px" />' +
                                '<img id="bullet2_' + numModel + '" src="${pageContext.request.contextPath}/management/assets/images/bullet2.png" alt="Detalhes" style="padding-top: 3px" />' +
                            '</a>' +
                        '</div>' +
                        '<' + 'script type="text/javascript">' +
                            '$("#bullet2_' + numModel + '").hide();' +
                            '$("#bullet1_' + numModel + '").click(function() { ' +
                                '$("#bullet1_' + numModel + '").hide();' +
                                '$("#bullet2_' + numModel + '").show();' +
                                '$("#instance_details_' + numModel +'").toggle("slow");' +
                                'pageResize();' +
                                'pageResize();' +
                            '});' +
                            '$("#bullet2_' + numModel + '").click(function() { ' +
                                '$("#bullet2_' + numModel + '").hide();' +
                                '$("#bullet1_' + numModel + '").show();' +
                                '$("#instance_details_' + numModel +'").toggle("slow");' +
                                'pageResize();' +
                                'pageResize();' +
                            '});' +
                        '<' + '/script>' +
                        '<div id="remove_bt_' + numModel + '" class="instance_remove_button basic_button ui-state-default ui-corner-all" title="remover instância">' +
                            '<a href="#"><span class="ui-icon ui-icon-closethick"></span></a>' +
                        '</div>' +
                        '<' + 'script type="text/javascript">' +
                            '$("#remove_bt_' + numModel + '").click(function() {' +
                                'remove(' + numModel + ',"' + name + '", "' + type + '");' +
                            '});' +
                        '</' + 'script>' +
                        '<div class="instance_input_field">' +
                            '<input type="text" value="' + name + '" name="instance_input_text" />' +
                        '</div>' +
                    '</div>' +
                    '<div class="instance_details" id="instance_details_' + numModel + '">' +
                        '<fieldset>' +
                            '<label for="instance_description_field">Descrição</label>' +
                            '<textarea name="instance_description_field" id="instance_description_field" class="ui-widget-content ui-corner-all instance_description_field">' + description + '</textarea>' +
                        '</fieldset>' +
                    '</div>';
                return model;
            }

            function addInstance(name, type, description, id) {
                $("#instance_list").append(getInstanceModel(name, type, description, id));
                pageResize();
            }

            $.fn.clearForm = function() {
                return this.each(function() {
                    var type = this.type, tag = this.tagName.toLowerCase();
                    if (tag == 'form') {
                        return $(':input', this).clearForm();
                    }
                    if (type == 'text' || type == 'password' || tag == 'textarea') {
                        this.value = '';
                    } else if (type == 'checkbox' || type == 'radio') {
                        this.checked = false;
                    } else if (tag == 'select') {
                        this.selectedIndex = -1;
                    }
                 });
             };
        </script>
    </head>
    <body>
        <div id="wrapper">
            <div id="header">
                <img src="${pageContext.request.contextPath}/management/assets/images/app_logo.png" alt="App Assembler" />
            </div>
            <div id="header_tabs">
                <ul>
                    <li><a href="#h_tabs-1"><c:out value="${first_tab}" /></a></li>
                    <li><a href="#h_tabs-2">Backdoor</a></li>
                </ul>

                <div id="h_tabs-1">
                    <!-- Will hold all content for this tab, see js in the header -->
                    <div id="main_content">
                        Carregando...
                    </div>
                </div>

                <div id="h_tabs-2"></div>
            </div>
        </div>
    </body>
</html>
