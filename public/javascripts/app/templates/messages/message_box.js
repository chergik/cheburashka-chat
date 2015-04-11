define(["jade"],function(jade){

return function template(locals) {
var buf = [];
var jade_mixins = {};
var jade_interp;

var jade_indent = [];
buf.push("\n<form name=\"send_message\" method=\"post\">\n  <input type=\"text\" name=\"message\"/>\n  <input type=\"submit\" value=\"say\"/>\n</form>");;return buf.join("");
};

});
