
var LINE_HEIGHT = "30";
function generateComponentContents(id, name, setters, getters) {
	var c_header = '<div class="canvas_component_header" style="line-height:' + LINE_HEIGHT + 'px" ><h3>' + name + '</h3></div>';
	var c_lines = '';
	for (i = 0; i < setters.length; i++) {
		c_lines += '<div class="canvas_component_line" style="line-height:' + LINE_HEIGHT + 'px">' + setters[i] + '</div>';
	}
	for (i = 0; i < getters.length; i++) {
		c_lines += '<div class="canvas_component_line" style="line-height:' + LINE_HEIGHT + 'px">' + getters[i] + '</div>';
	}
	$("#" + id).html(c_header + c_lines);
}

var MAX_X = 4000;
var MAX_Y = 4000;
var Component = function(id, container, position, constraints, name, setters, getters, type) {
	this.id = id;

	// Create the main component div
	this.el = WireIt.cn('div', {id: this.id, className: "canvas_component"});
	$("#" + container).append(this.el);
	$(this.el).attr("title", name);
	//document.getElementById(container).appendChild(this.el);

	generateComponentContents(this.id, name, setters, getters);

	this.terminals = [];
	var offset = 1;
	var terminals_index = 0;
	// Create head terminals
	//this.terminals[0] = new WireIt.Terminal(this.el, {wireConfig: { drawingMethod: "straight"}, direction: [0,1], offsetPosition: [-15, 0]});
	//this.terminals[1] = new WireIt.Terminal(this.el, {wireConfig: { drawingMethod: "straight"}, direction: [0,1], offsetPosition: [135, 0]});
	for (i = 0; i < setters.length; i++) {
		this.terminals[terminals_index] = new WireIt.Terminal(this.el,
											{wireConfig: { drawingMethod: "straight"},
											fakeDirection: [1,0],
											offsetPosition: [-15, 0 + (LINE_HEIGHT * offset)],
											ddConfig: { type: "setter", allowedTypes: ["getter"]}});
		if (type == 1) {
			this.terminals[terminals_index].eventAddWire.subscribe(onAddWire1, this);
			this.terminals[terminals_index].eventRemoveWire.subscribe(onRemoveWire1, this);
		}
		else if (type == 2) {
			this.terminals[terminals_index].eventAddWire.subscribe(onAddWire2, this);
			this.terminals[terminals_index].eventRemoveWire.subscribe(onRemoveWire2, this);
		}
		terminals_index++;
		offset++;
	}
	for (i = 0; i < getters.length; i++) {
		this.terminals[terminals_index] = new WireIt.Terminal(this.el,
											{wireConfig: { drawingMethod: "straight"},
											fakeDirection: [0,1],
											offsetPosition: [135, 0 + (LINE_HEIGHT * offset)],
											ddConfig: { type: "getter", allowedTypes: ["setter"]}});
		terminals_index++;
		offset++;
	}

	var DD =  new WireIt.util.DD(this.terminals,this.el);
	DD.setXConstraint(constraints[0], MAX_X, 1);
	DD.setYConstraint(position[1] - constraints[1], MAX_Y, 1);

	// Position the component
	if(position) {
		YAHOO.util.Dom.setXY(this.el, position);
	}
	componentContainer = new WireIt.ImageContainer({}, canvasLayer);
	alert("opa");
	$(componentComtainer.el).append(this.el);


};


var Ncomponents = 0;
var canvasLayer = new WireIt.Layer({layerMap:false});
function createComponent(id, container, position, constraints, name, setters, getters, type) {
	return new Component(id, container, position, constraints, name, setters, getters, type);
};
