/*!
 * 
 * 提示（字段提示、亮灯提示、提交提示）
 * @author sunxuelong
 * @version 2017-1-19
 */
var prompt = {
	// 解析字段提示
	/**
	 * @param url
	 */
	fiParse : function(url) {
		$.get(url, function(result) {
			$("select").focus(function() {
				$("#alert").text("");
			});
			$.each(result, function(key, value) {
//				$("#fi_" + key).hide().css("text-decoration","underline").css("cursor","pointer").attr("tip", value).show();
				if(key == "a0114a" || key.length == 5){
					key = "ryxx."+key;
				}
				else if(key == undefined){
					key = "";
				}
				$("input[name='"+key+"']").focus(function() {
					$("#alert").text(value);
				});
				$("input[name='"+key+"']").blur(function(){
					$("#alert").text("");
				});
				$("textarea[name='"+key+"']").focus(function() {
					$("#alert").text(value);
				});
				$("textarea[name='"+key+"']").blur(function(){
					$("#alert").text("");
				});
			});
			$.each(result, function(key,value){
				if(key == "a0114a" || key.length <= 5){
					key = "ryxx."+key;
				}
				else if(key == undefined){
					key = "";
				}
//				select框的提示信息显示
				$("select[name='"+key+"']").focus(function() {
					$("#alert").text(value);
				});
				$("select[name='"+key+"']").blur(function() {
					$("#alert").text("");
				});
			});
		});
	},
	// 解析亮灯
	liParse : function(url) {
		$.get(url, function(result) {
			$.each(result, function(key, value) {
				if(key == "redMap"){
					$.each(value, function(tkey, tvalue) {
						$("#red_" + tkey).hide().attr("tip", tvalue).show();
					});
				}
				if(key == "yellowMap"){
					$.each(value, function(tkey, tvalue) {
						$("#yellow_" + tkey).hide().attr("tip", tvalue).show();
					});
				}
			});
		});
	},
	// 鼠标移入字段提示符
	init : function(url) {
		var text = $("#alert").text();
		$(".redSpan").mouseover(function() {
			$("#alert").removeClass().addClass("alert alert-error tishixinxi").text($(this).attr("tip"));
		});
		$(".yellowSpan").mouseover(function() {
			$("#alert").removeClass().addClass("alert tishixinxi").text($(this).attr("tip"));
		});
		$(".redSpan").mouseout(function() {
			$("#alert").removeClass().addClass("alert alert-success tishixinxi").text(text);
		});
		$(".yellowSpan").mouseout(function() {
			$("#alert").removeClass().addClass("alert alert-success tishixinxi").text(text);
		});
	}
}