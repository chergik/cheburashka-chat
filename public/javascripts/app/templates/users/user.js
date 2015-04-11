define(["jade"],function(jade){

return function template(locals) {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (user) {
var jade_indent = [];
buf.push("\n<li class=\"user\">" + (jade.escape(null == (jade_interp = user) ? "" : jade_interp)) + "</li>");}.call(this,"user" in locals_for_with?locals_for_with.user:typeof user!=="undefined"?user:undefined));;return buf.join("");
};

});
