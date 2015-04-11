define(["jade"],function(jade){

return function template(locals) {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (username) {
buf.push("<li class=\"user\">" + (jade.escape(null == (jade_interp = username) ? "" : jade_interp)) + "</li>");}.call(this,"username" in locals_for_with?locals_for_with.username:typeof username!=="undefined"?username:undefined));;return buf.join("");
};

});
