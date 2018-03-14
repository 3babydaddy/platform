/*!
 * 业务管理
 * 
 * @author sunxuelong
 * @version 2017-2-8
 */
/**
	 * 合并单元格
	 * @param data  原始数据（在服务端完成排序）
	 * @param fieldName 合并属性名称
	   @param flagName  标记属性名称
	 * @param colspan   合并列
	 * @param target    目标表格对象
	 */
	function mergeCells(data,fieldName,flagName,colspan,target){
	    //声明一个map计算相同属性值在data对象出现的次数和
	    var sortMap = {};
	    for(var i = 0 ; i < data.length ; i++){
	        for(var prop in data[i]){
	            if(prop == flagName){
	                var key = data[i][prop]
	                if(sortMap.hasOwnProperty(key)){
	                    sortMap[key] = sortMap[key] * 1 + 1;
	                } else {
	                    sortMap[key] = 1;
	                }
	                break;
	            }
	        }
	    }
	    for(var prop in sortMap){
	        console.log(prop,sortMap[prop])
	    }
	    var index = 0;
	    for(var prop in sortMap){
	        var count = sortMap[prop] * 1;
	        var fieldNames=fieldName.split(",");
	        $.each(fieldNames,function(i,v){
	        	 $(target).bootstrapTable('mergeCells',{index:index, field:v, colspan: colspan, rowspan: count});
	        });
	        index += count;
	    }
	}
//清除ajax缓存兼容
$(function(){
	$.ajaxSetup({ cache: false });
})
