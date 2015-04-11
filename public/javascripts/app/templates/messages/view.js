define(["jade"],function(jade){

return function template(locals) {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (message, username) {
buf.push("<li class=\"message\"><span class=\"username\">" + (jade.escape(null == (jade_interp = username) ? "" : jade_interp)) + "</span><span class=\"message\">" + (jade.escape(null == (jade_interp = message) ? "" : jade_interp)) + "</span></li>");}.call(this,"message" in locals_for_with?locals_for_with.message:typeof message!=="undefined"?message:undefined,"username" in locals_for_with?locals_for_with.username:typeof username!=="undefined"?username:undefined));;return buf.join("");
};

});
