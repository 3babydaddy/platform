/**
 * 获得查询路径
 */
function getFindUrlInList(){
	//var likeContent= $('#searchInput').val();
	//var a= $('#table').bootstrapTable('getOptions');
	var pageNumber= $('#table').bootstrapTable('getOptions').pageNumber;
	var pageSize= $('#table').bootstrapTable('getOptions').pageSize;
	var sortName= $('#table').bootstrapTable('getOptions').sortName;
    var sortOrder= $('#table').bootstrapTable('getOptions').sortOrder;
	//window.localStorage.setItem("likeContent",likeContent);
    
	if(pageNumber && pageNumber != '1'){
	window.localStorage.setItem("pageNumber",pageNumber);
	}else{
		window.localStorage.setItem("pageNumber","");
	}
	window.localStorage.setItem("pageSize",pageSize);
	window.localStorage.setItem("sortName",sortName);
	window.localStorage.setItem("sortOrder",sortOrder);
}
function replenishParams (params){
	return params;
}
//记忆页码
function memoryPage(){
	// 页码  获取页码后不清除缓存，后面用到
	pageNum=window.localStorage.getItem("pageNumber")!=''&&window.localStorage.getItem("pageNumber")!=null?parseInt(window.localStorage.getItem("pageNumber")):1;
	//清除pageNumber缓存
	window.localStorage.setItem("pageNumber",'');
	//获取一页多少条数据
	pageSizeParam=window.localStorage.getItem("pageSize")!=''&&window.localStorage.getItem("pageSize")!=null?parseInt(window.localStorage.getItem("pageSize")):10;
	//清除pageSize缓存
	window.localStorage.setItem("pageSize",'');
	//排序
	var sortNameCathe	= window.localStorage.getItem("sortName");
	var sortOrderCathe	= window.localStorage.getItem("sortOrder");
	if(sortNameCathe){
		defaultSort= sortNameCathe;
	}else{
		defaultSort="defaultSort"
	}
	if(sortOrderCathe){
		order = sortOrderCathe;
	}else{
		order='desc';
	}
	window.localStorage.setItem("sortName",'');
	window.localStorage.setItem("sortOrder",'');
}