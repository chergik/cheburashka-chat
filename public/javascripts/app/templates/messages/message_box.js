define(["jade"],function(jade){

return function template(locals) {
var buf = [];
var jade_mixins = {};
var jade_interp;

buf.push("<form name=\"send_message\" method=\"post\"><input type=\"text\" name=\"message\"/><input type=\"submit\" value=\"say\"/></form>");;return buf.join("");
};

});
