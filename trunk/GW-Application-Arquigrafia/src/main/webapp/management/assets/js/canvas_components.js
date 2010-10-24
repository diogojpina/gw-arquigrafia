// JavaScript Document
var LINE_HEIGHT = "30";
var SETTER_LINE_SUB = '<div class="canvas_component_line" style="line-height:' + LINE_HEIGHT + 'px">subordina</div>';
var GETTER_LINE_SUB = '<div class="canvas_component_line" style="line-height:' + LINE_HEIGHT + 'px">subordinado a</div>';
function generateComponentContents(id, name, setters, getters) {
	var c_header = '<div class="canvas_component_header" style="line-height:' + LINE_HEIGHT + 'px" ><h3>' + name + '</h3></div>';
	var c_lines = '';
	c_lines += '<div id="setters_' + id + '">';
	for (i = 0; i < setters.length; i++) {
		c_lines += '<div class="canvas_component_line" style="line-height:' + LINE_HEIGHT + 'px">' + setters[i] + '</div>';
	}
	c_lines += '</div>';
	c_lines += '<div id="getters_' + id + '">';
	for (i = 0; i < getters.length; i++) {
		c_lines += '<div class="canvas_component_line" style="line-height:' + LINE_HEIGHT + 'px">' + getters[i] + '</div>';
	}
	c_lines += '</div>';
	$("#" + id).html(c_header + c_lines);
}

var MAX_X = 4000;
var MAX_Y = 4000;
var Component = function(id, container, position, constraints, name, setters, getters, type, canvasId) {
	this.id = id;

	// Create the main component div
	this.el = WireIt.cn('div', {id: this.id, className: "canvas_component"});
	$("#" + container).append(this.el);
	$(this.el).attr("title", name);
	//document.getElementById(container).appendChild(this.el);
	
	generateComponentContents(this.id, name, setters, getters);
	
	this.terminals = [];
	var offset = 1;
	var index = 0;
	// Create head terminals
	//this.terminals[0] = new WireIt.Terminal(this.el, {wireConfig: { drawingMethod: "straight"}, direction: [0,1], offsetPosition: [-15, 0]});
	//this.terminals[1] = new WireIt.Terminal(this.el, {wireConfig: { drawingMethod: "straight"}, direction: [0,1], offsetPosition: [135, 0]});
	for (i = 0; i < setters.length; i++) {
		this.terminals[index] = new WireIt.Terminal(this.el,
											{wireConfig: { drawingMethod: "straight"},
											fakeDirection: [1,0],
											offsetPosition: [-15, 0 + (LINE_HEIGHT * offset)],
											ddConfig: { type: "setter", allowedTypes: ["getter"]}});
		if (type == 1) {
			this.terminals[index].eventAddWire.subscribe(onAddWire1, this);
			this.terminals[index].eventRemoveWire.subscribe(onRemoveWire1, this);
		}
		else if (type == 2) {
			this.terminals[index].eventAddWire.subscribe(onAddWire2, this);
			this.terminals[index].eventRemoveWire.subscribe(onRemoveWire2, this);
		}
		index++;
		offset++;
	}
	for (i = 0; i < getters.length; i++) {
		this.terminals[index] = new WireIt.Terminal(this.el,
											{wireConfig: { drawingMethod: "straight"},
											fakeDirection: [0,1],
											offsetPosition: [135, 0 + (LINE_HEIGHT * offset)],
											ddConfig: { type: "getter", allowedTypes: ["setter"]}});
		index++;
		offset++;
	}
	$(this.el).draggable({
		containment: "parent",
		scroll: true,
		scrollSpeed: 100,
		start: function() {
		},
		stop: function(event, ui) {
			onMoved(id, canvasId, ui.offset.left, ui.offset.top);
		}
	});
	$(".canvas_component").draggable({stack: ".canvas_component"});
	$(this.el).bind('mousedown.disableTextSelect', function() {
        return false;
    });
	
	// Position the component
	if(position) {
		YAHOO.util.Dom.setXY(this.el, position);
	}
	

};
 
var Ncomponents = 0;
var canvasLayer = new WireIt.Layer({layerMap:false});
function createComponent(id, container, position, constraints, name, setters, getters, type, canvasId) {
	return new Component(id, container, position, constraints, name, setters, getters, type, canvasId);
};

function connectSubComponents(from, to) {
	if (to != null) {
		$("#setters_" + from).append(SETTER_LINE_SUB);
		$("#getters_" + to).append(GETTER_LINE_SUB);
	}
}