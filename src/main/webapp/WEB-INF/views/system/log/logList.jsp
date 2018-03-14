<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>日志管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

	//列表
	 $(function() {
	        $('#search').click(function() {
	            $('#table').bootstrapTable('refresh');
	        });
	        $('#table').bootstrapTable({
	        	method: "get",
	            url : '${ctx}/sys/log/list',
	            pagination : true,
	            paginationDetailHAlign : 'right',
	            paginationHAlign : 'left',
	            paginationPreText : '上一页',
	            paginationNextText : '下一页',
	            sidePagination : 'server',
	            sortName : 'a.create_date',
	            sortOrder : 'desc',
	            clickToSelect : true,
	            pageSize : 10,
	            pageNumber : 1,
	            pageList: [5, 10, 15, 20, 25],  //记录数可选列表 
	            queryParams : 'queryParams',
	            detailView : true,
	            detailFormatter:'detailFormatter',
	            columns : [ 
	             {
	                field : 'id',
	                visible : false
	            }, {
	                field : 'title',
	                title : '操作菜单',
	                	formatter :  function nameFormatter(value, row) {
		                    return '<a href="${ctx}/sys/log/form?id=' + row.id + '">' + value + '</a>';
		                }
	            }, {
	                field : 'createBy.name',
	                title : '用户名'
	            }, {
	                field : 'createBy.office.name',
	                title : '所在单位',
	            },  {
	                field : 'requestUri',
	                title : '操作路径'
	            }, {
	                field : 'method',
	                title : '提交方式'
	            }, {
	                field : 'detail',
	                title : '操作内容'
	            }, {
	                field : 'ip',
	                title : '操作者IP'
	            }, {
	                field : 'createDate',
	                title : '操作时间'
	            } ]
	           
	        });
	 });
	//设置传入参数
	//依次遍历上下文所有的含有name属性的input标签 
	//each就表示每一个,
	//可以用$(this)来代表当前正选中的那一个控件
	 function queryParams(params) {
		 $('#searchbar').find('input[name]').each(function() {
            params[$(this).attr('name')] = $(this).val();
	        });
		 $('#labelbar').find('input[name]').each(function() {
	            params[$(this).attr('name')] = $(this).val();
		        });
		 //当checkbox为选中状态时赋值
		 if($('#exception').prop("checked")){
       		params.exception='1';
		 }
	   return params;
	 }

        function detailFormatter(index, row) {
            var html = [];
            $.each(row, function(key, value) {
                html.push('<p><b>' + key + ':</b> ' + value + '</p>');
            });
            return html.join('');
        }
    </script>
</head>
<body>
	
	<ul class="breadcrumb">
        <li class="active">日志列表</li>
    </ul>
    
    <div id="searchbar" class="form-search breadcrumb">
        <div class="input-prepend">
          <span class="add-on">操作菜单：</span>
          <input name="title" class="input-small" type="text" />
        </div>
       <div class="input-prepend">
          <span class="add-on">用户名：</span>
          <input name="createBy.name" class="input-small" type="text" />
        </div>
        <div class="input-prepend">
          <span class="add-on">所在单位：</span>
          <input name="createBy.office.name" class="input-small" type="text" />
        </div>
        <div class="input-prepend">
          <span class="add-on">操作用户IP：</span>
          <input name="ip" class="input-small" type="text" />
        </div></div>
        <div>
    <div id="labelbar" class="form-search breadcrumb">
          <span class="add-on">操作时间：</span>
	<input id="beginDate" name="beginDate" type="text" readonly="readonly" maxlength="20" class="input-mini Wdate"
			value="<fmt:formatDate value="${logDate.beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
	<label>--</label>
	<input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20" class="input-mini Wdate"
			value="<fmt:formatDate value="${logDate.endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
	
	<label for="exception"><input id="exception"  type="checkbox" value=''/>只查询异常信息</label>
	<input id="search" class="btn btn-primary" type="button" value="查询" />
	
	</div>
		
	<sys:message content="${message}"/>
	<div id="content">
        <table id="table"></table>
    </div>
</body>
</html>