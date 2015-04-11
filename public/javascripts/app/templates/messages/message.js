define(["jade"],function(jade){

return function template(locals) {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (message, user) {
var jade_indent = [];
buf.push("\n<li class=\"message\"><span class=\"username\">" + (jade.escape((jade_interp = user) == null ? '' : jade_interp)) + ":&nbsp;</span><span class=\"message\">" + (jade.escape(null == (jade_interp = message) ? "" : jade_interp)) + "</span></li>");}.call(this,"message" in locals_for_with?locals_for_with.message:typeof message!=="undefined"?message:undefined,"user" in locals_for_with?locals_for_with.user:typeof user!=="undefined"?user:undefined));;return buf.join("");
};

});
