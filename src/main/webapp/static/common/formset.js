//设置input以及textare框长度
$(function(){
	$("input").attr("maxlength","40");
	$("textarea").attr("maxlength","100");
})

//文本框获得焦点改变底色
function inputStyle1(obj) {
	obj.style.background = '#E1F8FD';
	document.all.meizzDateLayer.style.display = "none";

}
function inputStyle2(obj) {
	obj.style.background = '#FFFFFF';

}

function inputStyle1d(obj) {
	obj.style.background = '#E1F8FD';
	//HS_setDate(obj);
	setday(obj);

}

//检测字符串字节数
function checktextlength(objvalue, maxlen) {
	if (objvalue.replace(/[^\x00-\xff]/gi, "--").length > maxlen) {
		return true;

	} else {
		return false;
	}
}
//js的trim
String.prototype.Trim = function()
{
    return this.replace(/(^\s*)|(\s*$)/g, "");
}
//验证身份证号码是否有效
function checkIdcard(idcard){    
  var Errors=new Array("ok","身份证号码位数不对!","身份证号码出生日期超出范围或含有非法字符!","身份证号码校验错误!","身份证地区非法!");    
  var area={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"}    
  var idcard,Y,JYM;    
  var S,M;    
  var idcard_array = new Array();    
   idcard_array = idcard.split("");    
  if(area[parseInt(idcard.substr(0,2))]==null) return Errors[4];    
  switch(idcard.length){    
    case 15:    
      if ((parseInt(idcard.substr(6,2))+1900) % 4 == 0 || ((parseInt(idcard.substr(6,2))+1900) % 100 == 0 && (parseInt(idcard.substr(6,2))+1900) % 4 == 0 )){    
         ereg = /^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$/;//测试出生日期的合法性    
       }    
      else{    
         ereg = /^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$/;//测试出生日期的合法性    
       }    
      if(ereg.test(idcard))    
        return Errors[0];    
      else   
        return Errors[2];    
    break;    
  case 18:    
    if ( parseInt(idcard.substr(6,4)) % 4 == 0 || (parseInt(idcard.substr(6,4)) % 100 == 0 && parseInt(idcard.substr(6,4))%4 == 0 )){    
       ereg = /^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$/;//闰年出生日期的合法性正则表达式    
     }    
    else{    
     ereg = /^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$/;//平年出生日期的合法性正则表达式    
     }    
    if(ereg.test(idcard)){    
       S = (parseInt(idcard_array[0]) + parseInt(idcard_array[10])) * 7 + (parseInt(idcard_array[1]) + parseInt(idcard_array[11])) * 9 + (parseInt(idcard_array[2]) + parseInt(idcard_array[12])) * 10 + (parseInt(idcard_array[3]) + parseInt(idcard_array[13])) * 5 + (parseInt(idcard_array[4]) + parseInt(idcard_array[14])) * 8 + (parseInt(idcard_array[5]) + parseInt(idcard_array[15])) * 4 + (parseInt(idcard_array[6]) + parseInt(idcard_array[16])) * 2 + parseInt(idcard_array[7]) * 1 + parseInt(idcard_array[8]) * 6 + parseInt(idcard_array[9]) * 3 ;    
       Y = S % 11;    
       M = "F";    
       JYM = "10X98765432";    
       M = JYM.substr(Y,1);    
      if(M == idcard_array[17])    
        return Errors[0];    
      else   
        return Errors[3];    
     }    
    else   
      return Errors[2];    
    break;    
  default:    
    return Errors[1];    
    break;    
   }    
}    
//验证自然数
function checknaturalnumber(num){
  	if(/^[0-9]+$/.test(num)){
	    return false;
	}else{
		return true;
	}
}
//验证正整数
function checkpositiveInteger(num){
	if(/^[1-9]*[1-9][0-9]*$/.test(num)){
		return false;
	}else{
		return true;
	}
}
//验证正浮点数，最多保留两位小数
function checkNotNegative(num){
  	if(/^[0-9]+(.[0-9]{1,2})?$/.test(num)){
	    return false;
	}else{
		return true;
	}
}
//验证日期
function checkDate(idate){
  	if(/^\d{4}-\d{2}-\d{2}$/.test(idate)){
		if(/^((^((1[8-9]\d{2})|([2-9]\d{3}))([-\/\._])(10|12|0?[13578])([-\/\._])(3[01]|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))([-\/\._])(11|0?[469])([-\/\._])(30|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))([-\/\._])(0?2)([-\/\._])(2[0-8]|1[0-9]|0?[1-9])$)|(^([2468][048]00)([-\/\._])(0?2)([-\/\._])(29)$)|(^([3579][26]00)([-\/\._])(0?2)([-\/\._])(29)$)|(^([1][89][0][48])([-\/\._])(0?2)([-\/\._])(29)$)|(^([2-9][0-9][0][48])([-\/\._])(0?2)([-\/\._])(29)$)|(^([1][89][2468][048])([-\/\._])(0?2)([-\/\._])(29)$)|(^([2-9][0-9][2468][048])([-\/\._])(0?2)([-\/\._])(29)$)|(^([1][89][13579][26])([-\/\._])(0?2)([-\/\._])(29)$)|(^([2-9][0-9][13579][26])([-\/\._])(0?2)([-\/\._])(29)$))$/.test(idate)){
	        return false;
		}else{
		    return true;	
		}
	}else{
		return true;
	}
}
//获得上传文件大小
function getFileSize(filePath){
	 var image=new Image();
	 image.dynsrc=filePath;
	 return image.fileSize;
}
//验证非负实数
function checkrealnumber(num){
  	if(/^(\d{1,10}.\d{1,10}|\d{1,10})$/.test(num)){
	    return false;
	}else{
		return true;
	}
}

//计算年限
function computeyears(obj,date1,date2){
	if(!(checkDate(date1)||checkDate(date2))){
	    var date1s = date1.split("-");
		var date2s = date2.split("-");
		var y1 = parseInt(date1s[0],10);
		var m1 = parseInt(date1s[1],10);
		var d1 = parseInt(date1s[2],10);
		var y2 = parseInt(date2s[0],10);
		var m2 = parseInt(date2s[1],10);
		var d2 = parseInt(date2s[2],10);
		var nian = y1-y2;
		var yue = m1-m2;
		var ri = d1-d2;
		
		if(yue==0){
			if(ri<0){
				nian = nian-1;
			}
		}
		if(yue<0){
			nian = nian-1; 			   
		}	
		
		if(nian>=0){
			obj.value = nian;
		}
		
	}
}

function computeyearsfor4(obj,date1,date2,date3,date4){
	var nian=0;
	var yue = 0;
	var ri = 0;
	if(!(checkDate(date1)||checkDate(date2))){
	    var date1s = date1.split("-");
		var date2s = date2.split("-");
		var y1 = parseInt(date1s[0],10);
		var m1 = parseInt(date1s[1],10);
		var d1 = parseInt(date1s[2],10);
		var y2 = parseInt(date2s[0],10);
		var m2 = parseInt(date2s[1],10);
		var d2 = parseInt(date2s[2],10);
		nian = y1-y2;
		yue = m1-m2;
		ri = d1-d2;
	}	
	if(!(checkDate(date3)||checkDate(date4))){
		var date3s = date3.split("-");
		var date4s = date4.split("-");
		var y3 = parseInt(date3s[0],10);
		var m3 = parseInt(date3s[1],10);
		var d3 = parseInt(date3s[2],10);
		var y4 = parseInt(date4s[0],10);
		var m4 = parseInt(date4s[1],10);
		var d4 = parseInt(date4s[2],10);
		nian = nian + y3-y4;
		yue = yue + m3-m4;
		ri = ri + d3-d4;
	}
	if(ri<0){
		yue = yue-1;
	}
	if(ri>31){
		yue=yue+1;
	}
	if(yue<0){
		nian = nian-1; 			   
	}
	if(yue>=12){
		nian = nian + 1;
	}
	if(nian>=0){
		obj.value = nian;
	}
	else{
		obj.value=0;
	}
}

//日期比较
function comparedate(date1,date2){
	if(!(checkDate(date1)||checkDate(date2))){
	    var date1s = date1.split("-");
		var date2s = date2.split("-");
		var y1 = parseInt(date1s[0],10);
		var m1 = parseInt(date1s[1],10);
		var d1 = parseInt(date1s[2],10);
		var y2 = parseInt(date2s[0],10);
		var m2 = parseInt(date2s[1],10);
		var d2 = parseInt(date2s[2],10);
		v1 = new Date(y1,m1,d1);
		v2 = new Date(y2,m2,d2)
		if(v1>v2){
			return true;
		}else{
			return false;
		}
	}else{
		return false;
	}
}
//获取当前日期，格式化成xxxx-xx-xx的格式(根据情况补零)
function getNowFormatDate()
{
   var day = new Date();

   var Year = 0;
   var Month = 0;
   var Day = 0;
   var CurrentDate = "";
   //初始化时间
   //Year       = day.getYear();//有火狐下2008年显示108的bug
   Year       = day.getFullYear();//ie火狐下都可以
   Month      = day.getMonth()+1;
   Day        = day.getDate();
   
   CurrentDate += Year + "-";
   
   if (Month >= 10 )
   {
    CurrentDate += Month + "-";
   }
   else
   {
    CurrentDate += "0" + Month + "-";
   }
   if (Day >= 10 )
   {
    CurrentDate += Day ;
   }
   else
   {
    CurrentDate += "0" + Day ;
   }

   return CurrentDate;
}