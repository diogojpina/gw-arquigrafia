var LINE_HEIGHT = "30";

var MAX_X = 4000;
var MAX_Y = 4000;

var canvasLayer = new WireIt.Layer({layerMap: false});

function createComponent(params) {

    var id = params.id;
    var container = params.container;
    var position = params.position;
    var constraints = params.constraints;
    var name = params.name;
    var setters = params.setters;
    var getters = params.getters;
    var type = params.type;

    var generateComponentContents = function() {
        var cHeader = '<div class="canvas_component_header" style="line-height: ' + LINE_HEIGHT + 'px"><h3>' + name + '</h3></div>';
        var cLines = '';
        for (var i = 0; i < setters.length; i++) {
            cLines += '<div class="canvas_component_line" style="line-height: ' + LINE_HEIGHT + 'px">' + setters[i] + '</div>';
        }
        for (var i = 0; i < getters.length; i++) {
            cLines += '<div class="canvas_component_line" style="line-height: ' + LINE_HEIGHT + 'px">' + getters[i] + '</div>';
        }
        $("#" + id).html(cHeader + cLines);
    };

    var scope = {};

    // Create the main component div
    scope.el = WireIt.cn('div', {id: id, className: "canvas_component"});
    $("#" + container).append(scope.el);
    $(scope.el).attr("title", name);
    //document.getElementById(container).appendChild(this.el);

    generateComponentContents();

    scope.terminals = [];
    var offset = 1;
    var terminalsIndex = 0;

    // Create head terminals
    //this.terminals[0] = new WireIt.Terminal(this.el, {wireConfig: { drawingMethod: "straight"}, direction: [0,1], offsetPosition: [-15, 0]});
    //this.terminals[1] = new WireIt.Terminal(this.el, {wireConfig: { drawingMethod: "straight"}, direction: [0,1], offsetPosition: [135, 0]});
    for (var i = 0; i < setters.length; i++) {
        scope.terminals[terminalsIndex] = new WireIt.Terminal(scope.el, {
            wireConfig: { drawingMethod: "straight", xtype: "WireIt.ArrowWire" },
            fakeDirection: [1, 0],
            offsetPosition: [-15, 0 + (LINE_HEIGHT * offset)],
            ddConfig: { type: "setter", allowedTypes: ["getter"]}
        });
        if (type == 0) {
            scope.terminals[terminalsIndex].eventAddWire.subscribe(onAddWire1, scope);
            scope.terminals[terminalsIndex].eventRemoveWire.subscribe(onRemoveWire1, scope);
        } else if (type == 1) {
            scope.terminals[terminalsIndex].eventAddWire.subscribe(onAddWire2, scope);
            scope.terminals[terminalsIndex].eventRemoveWire.subscribe(onRemoveWire2, scope);
        }
        terminalsIndex++;
        offset++;
    }

    for (var i = 0; i < getters.length; i++) {
        scope.terminals[terminalsIndex] = new WireIt.Terminal(scope.el, {
            wireConfig: { drawingMethod: "straight"},
            fakeDirection: [0, 1],
            offsetPosition: [135, 0 + (LINE_HEIGHT * offset)],
            ddConfig: { type: "getter", allowedTypes: ["setter"]}
        });
        terminalsIndex++;
        offset++;
    }

    var DD = new WireIt.util.DD(scope.terminals, scope.el);
    DD.setXConstraint(constraints[0], MAX_X, 1);
    DD.setYConstraint(position[1] - constraints[1], MAX_Y, 1);

    // Position the component
    if (position) {
        YAHOO.util.Dom.setXY(scope.el, position);
    }

    var componentContainer = new WireIt.ImageContainer({}, canvasLayer);
    $(componentContainer.el).append(scope.el);
}
