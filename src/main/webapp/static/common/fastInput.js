/*!
 * 套录
 *
 * @author sunxuelong
 * @version 2017-2-6
 */
var fastInput = {
	URL : {
		ryxx : function(){
			return ctx + '/ywgl/ryxx/findRyxx';
		},
		//记时登记套入八项基本信息和任职资格信息
	    lastJsdj: function(){
			return ctx + '/ywgl/jsdj/findLastJsdj';
		},
		textRefresh: function(){
			return ctx + '/ywgl/common/textRefresh';
		}
	},
	// 确认后的操作
	ok : function(result){
		$("input[name='ryxx.a0101']").val(result.a0101);
		$("input[name='ryxx.a0101']").attr("readonly",true);
		$("select[name='ryxx.a0104']").val(result.a0104);
		//$("select[name='ryxx.a0104']").attr("disabled",true);
		$("input[name='ryxx.a0107']").val(result.a0107);
		//$("input[name='ryxx.a0107']").attr("disabled",true);
		$("select[name='ryxx.a0117']").val(result.a0117);
		//$("select[name='ryxx.a0117']").attr("disabled",true);
		$("input[name='ryxx.a0111']").val(result.a0111);
		//$("input[name='ryxx.a0111']").attr("readonly",true);
		$("input[name='ryxx.a0114a']").val(result.a0114a);
		//$("input[name='ryxx.a0114a']").attr("readonly",true);
		$("input[name='ryxx.a0134']").val(result.a0134);
		//$("input[name='ryxx.a0134']").attr("disabled",true);
		$("input[name='ryxx.a0184']").attr("readonly",true);
	},
	//记时登记中确认后操作
	jsdjOk:function(result){
		$("input[name='ryxx.a0184']").attr("readonly",true);
		$("input[name='ryxx.a0101']").val(result.ryxx.a0101);
		$("input[name='ryxx.a0101']").attr("readonly",true);
		$("select[name='ryxx.a0104']").val(result.ryxx.a0104);
		//$("select[name='ryxx.a0104']").attr("disabled",true);
		$("input[name='ryxx.a0107']").val(result.ryxx.a0107);
		//$("input[name='ryxx.a0107']").attr("disabled",true);
		$("select[name='ryxx.a0117']").val(result.ryxx.a0117);
		//$("select[name='ryxx.a0117']").attr("disabled",true);
		$("input[name='ryxx.a0111']").val(result.ryxx.a0111);
		//$("input[name='ryxx.a0111']").attr("readonly",true);
		$("input[name='ryxx.a0114a']").val(result.ryxx.a0114a);
		//$("input[name='ryxx.a0114a']").attr("readonly",true);
		$("input[name='ryxx.a0134']").val(result.ryxx.a0134);
		//$("input[name='ryxx.a0134']").attr("disabled",true);
		$("input[name='a52z101']").val(result.a52z101);
		$("select[name='a52z104']").val(result.a52z104);
		$("input[name='a52z107']").val(result.a52z107);
		$("select[name='a52z111']").val(result.a52z111);
	},
	// 不套录的操作
	cancel : function(){
		//清空基本信息框
		$("input[name='ryxx.a0184']").val("");//身份证输入框
		$("input[name='ryxx.a0101']").val("");
		$("select[name='ryxx.a0104']").val("0");
		$("input[name='ryxx.a0107']").val("");
		$("select[name='ryxx.a0117']").val("");
		$("input[name='ryxx.a0111']").val("");
		$("input[name='ryxx.a0114a']").val("");
		$("input[name='ryxx.a0134']").val("");
		fastInput.removeDisUse();

	},
	removeDisUse : function(){
		//取消禁用基本信息框

		$("input[name='ryxx.a0184']").removeAttr("readonly");//身份证输入框
		$("input[name='ryxx.a0101']").removeAttr("readonly");
		$("select[name='ryxx.a0104']").removeAttr("disabled");
		$("input[name='ryxx.a0107']").removeAttr("disabled");
		$("select[name='ryxx.a0117']").removeAttr("disabled");
		$("input[name='ryxx.a0111']").removeAttr("readonly");
		$("input[name='ryxx.a0114a']").removeAttr("readonly");
		$("input[name='ryxx.a0134']").removeAttr("disabled");
	},
	// 套录八项基本信息
	findRyxx : function(data) {
		$.get(fastInput.URL.ryxx(), data, function(result) {
			if(result != null && result !=""){
				if(result.a0107 == null){
					result.a0107 = "";
				}
				if (confirm("本身份证对应人员：" + result.a0101 + "，" + result.a0104Text + "，" + result.a0117Text + "，出生日期 " + result.a0107 + "\n\n该人员已存在" + "\n\n是否继续登记信息?")){
					fastInput.ok(result);
				}else{
					fastInput.cancel();
				}
			}else{
				fastInput.removeDisUse();
			}
		});
	},
	//套录八项基本信息和任职资格四项信息
	findLastJsdj : function(data) {
		$.get(fastInput.URL.lastJsdj(), data, function(result) {
			if(result != null && result !=""){
				if(result.ryxx.a0107 == null){
					result.ryxx.a0107 = "";
				}
				if (confirm("本身份证对应人员：" + result.ryxx.a0101 + "，" + result.ryxx.a0104Text + "，" + result.ryxx.a0117Text + "，出生日期 " + result.ryxx.a0107+ "，上次提拔(晋升)时间 " + (result.a52z101==null ? "":result.a52z101)+ "，上次提拔任职是否实行试用期制度 " +(result.a52z104=='w' ? "不涉及":result.a52z104Text) + "，上次任职试用期结束时间 " + (result.a52z107==null ? "":result.a52z107)+ "，上次是否在任职年限上破格提拔或越级提拔 " +(result.a52z111=="w"? "不涉及":result.a52z111Text) + "\n\n该人员已存在" + "\n\n是否继续登记信息?")){
					fastInput.jsdjOk(result);
				}else{
					fastInput.cancel();
				}
			}else{
				fastInput.removeDisUse();
			}
		});
	},
	// 套录八项基本信息 刷新
	findRyxxRefresh : function(data){
		$.get(fastInput.URL.ryxx(), data, function(result) {
			if(result != null && result !=""){
				if(result.a0107 == null){
					result.a0107 = "";
				}
				if (confirm("本身份证对应人员：" + result.a0101 + "，" + result.a0104Text + "，" + result.a0117Text + "，出生日期 " + result.a0107 + "\n\n该人员已存在" + "\n\n是否继续登记信息?")){
					fastInput.ok(result);
				}else{
					fastInput.cancel();
				}
			}else{
				alert("已与管控平台同步！");
			}
		});
	},
	// 重要情况记实 刷新
	textRefresh : function(data){
		$.get(fastInput.URL.textRefresh(), data, function(result) {
			if(result =="success"){
				alert("已将数据更新！");
			}else{
				alert("数据更新失败！");
			}
		});
	}
}