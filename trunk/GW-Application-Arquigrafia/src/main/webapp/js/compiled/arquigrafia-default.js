function loadjscssfile(filename, filetype){
 if (filetype=="js"){ //if filename is a external JavaScript file
  var fileref=document.createElement('script')
  fileref.setAttribute("type","text/javascript")
  fileref.setAttribute("src", filename)
 }
 else if (filetype=="css"){ //if filename is an external CSS file
  var fileref=document.createElement("link")
  fileref.setAttribute("rel", "stylesheet")
  fileref.setAttribute("type", "text/css")
  fileref.setAttribute("href", filename)
 }
 if (typeof fileref!="undefined")
  document.getElementsByTagName("head")[0].appendChild(fileref)
}

loadjscssfile("../jquery-ui-1.8.custom.min.js","js");
loadjscssfile("../chili-1.7.pack.js","js");
loadjscssfile("../jquery.easing.js","js");
loadjscssfile("../jquery.dimensions.js","js");
loadjscssfile("../jquery.dimensions.js","js");
loadjscssfile("../bay.js","js");


