<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>单位管理</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treetable.jsp"%>
<script type="text/javascript">
    $(function() {
    	// 批量更新
		$("#batchUpdateBtn").click(function() {
			loading('请稍等...');
			$("#listForm").attr("action", "${ctx}/sys/office/batchUpdate");
			$("#listForm").submit();
		});
        var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
        var data = ${fns:toJson(list)}, rootId = "${not empty office.id ? office.id : '10000000000E10'}";
        addRow("#treeTableList", tpl, data, rootId, true);
        $("#treeTable").treeTable({expandLevel : 5});
        // 保存排序
		$("#updateSortBtn").click(function(){
	         loading('正在提交，请稍等...');
	         $("#listForm").attr("action", "${ctx}/sys/office/updateSort");
             $("#listForm").submit();
		});

        // 导入
        $("#daoru").click(function() {
            new jBox('Modal', {
                title : '导入数据',
                closeButton : 'title',
                content : $("#importBox")
            }).open();
        });

        // 查询
        $("#searchBtn").click(function() {
        	$("#searchForm").submit();
        });
    });
    function addRow(list, tpl, data, pid, root){
    	
        for (var i=0; i<data.length; i++){
        	
            var row = data[i];
            if ((${fns:jsGetVal('row.parentId')}) == pid){
            	
                $(list).append(Mustache.render(tpl, {
                    dict: {
                        jgxz: getDictChname(${fns:toJson(fns:getDictList('YW_JGXZ'))}, row.jgxz),
                        version: getDictChname(${fns:toJson(fns:getDictList('DWYH_VERSION'))}, row.version),
                        stateFlag: getDictChname(${fns:toJson(fns:getDictList('yes_no'))}, row.stateFlag)
                    }, pid: (root?0:pid), row: row
                  
                }));
                addRow(list, tpl, data, row.id);
            }
        }
    }
</script>
</head>
<body>
    <ul class="breadcrumb">
        <li class="active"><a href="${ctx}/sys/office/">单位列表</a></li>
    </ul>
	<div id="toolbar">
		<ul class="nav nav-pills">
			<li>
				<a id="batchUpdateBtn" href="javascript:void(0)">
					<i class="icon-wrench"></i>&nbsp;更新排序
				</a>
			</li>

		</ul>
	</div>
	<div id="searchbar" class="form-search breadcrumb">
		<form:form id="searchForm" modelAttribute="office" action="${ctx}/sys/office/cxlist" method="post" style="margin:0px;" >
	        <div class="input-prepend">
	      		<span class="add-on">单位名称</span>
	        	<form:input path="name" htmlEscape="false" maxlength="50" />
	        </div>
	        
        	<input id="searchBtn" class="btn btn-primary" type="button" value="查询" />
        </form:form>
    </div>
    <sys:message content="${message}" />
    <form id="listForm" method="post">
    <table id="treeTable" class="table table-striped table-bordered table-condensed" style="width:60%">
        <thead>
            <tr>
                <th style="text-align:center;">单位名称</th>
                <th style="text-align:center;">排序</th>
                <shiro:hasPermission name="sys:office:edit">
                    <th style="text-align:center;">操作</th>
                </shiro:hasPermission>
            </tr>
        </thead>
        <tbody id="treeTableList"></tbody>
    </table>
    </form>
    <div id="importBox" class="hide">
        <form id="importForm" action="${ctx}/sys/office/import" method="post" enctype="multipart/form-data"
            class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
            <input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
            <input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
            <a href="${ctx}/sys/office/import/template">下载模板</a>
        </form>
    </div>
    <script type="text/template" id="treeTableTpl">
        <tr id="{{row.id}}" pId="{{pid}}">
            <td><a href="${ctx}/sys/office/form?id={{row.id}}">{{row.name}}</a></td>
            
            <td style="text-align:center;">
				<input type="hidden" name="ids" value="{{row.id}}"/>
				<input name="sorts" type="text" value="{{row.sort}}" onblur="positive(this)" maxlength="10" style="width:85px;margin:0;padding:0;text-align:center;">
			</td>
			<td>
                <a href="${ctx}/sys/office/form?id={{row.id}}">修改</a>
				<a href="${ctx}/sys/office/delete?id={{row.id}}">删除</a>
                 <a href="${ctx}/sys/office/form?parent.id={{row.id}}">添加下级单位</a> 
            </td>
        </tr>
    </script>
</body>
</html>