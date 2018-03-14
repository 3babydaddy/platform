//设置inoput框最大输入100个字
$(function(){
	$('input').attr("maxlength","100");
})
//验证自然数
function checknaturalnumber(num){
  	if(/^[0-9]+$/.test(num)){
	    return false;
	}else{
		return true;
	}
}

//正整数字段验证的方法
function positive(element){
	if(element.value!="" && checknaturalnumber(element.value)){
	 alert("请输入正整数！");
	 element.value="";
	 element.focus();
	}
	else{
		var posNum = "";
		if(element.value==""){
			posNum = ""
		}
		else{
			posNum = Number(element.value);
			element.value=posNum;
		}
	}
}

//在IE8下对textarea的字数长度限制的函数
function isMaxLen(o){
	var nMaxLen=o.getAttribute ? parseInt(o.getAttribute("maxlength")) : "";
	if(o.getAttribute && o.value.length>nMaxLen){
		o.value=o.value.substring(0,nMaxLen)
	}
}