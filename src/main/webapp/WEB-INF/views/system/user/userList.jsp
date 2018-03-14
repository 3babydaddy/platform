<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	//列表
	 $(function() {
	        $('#search').click(function() {
	            $('#table').bootstrapTable('refresh');
	        });
	        $('#table').tfkjTable({
	            url : '${ctx}/sys/user/list',
	            queryParams : 'queryParams',
	            columns : [ {
	                field : 'id',
	                visible : false
	            }, {
	                field : 'office.name',
	                title : '所属单位',
	                width : 230,
	                formatter : function(value,row){
                    	return "<div title="+value+">"+value+"</div>"
	                }
	            }, {
	                field : 'loginName',
	                title : '登录名',
	                width : 112,
                    formatter :  function(value, row) {
                        return '<a title='+value+' href="${ctx}/sys/user/form?id=' + row.id + '">' + value + '</a>';
                    },
                    cellStyle : function(value,row){
						return {
							css : {
								"text-align" : "center",
								"white-space" : "nowrap",
								"text-overflow" : "ellipsis",
								"overflow" : "hidden"
							}
						}
					}
	            }, {
	                field : 'name',
	                title : '用户名',
	                width : 230,
	                formatter : function(value,row){
                    	return "<div title="+value+">"+value+"</div>"
	                }
	            }, {
	                field : 'password',
	                title : '密码',
	                width : 130,
	                formatter : function(value,row){
                    	return "<div title="+value+">"+value+"</div>"
	                }
	            }, {
	                field : 'stateFlag',
	                title : '是否允许登录',
	                width : 167,
	                formatter : function(value,row){
                    	if(value=='1'){
                    		return "是";
                    	}
                    	if(value=='0'){
                    		return "否";
                    	}
                    	
	                }
	            }, {
                    field : 'loginDate',
                    title : '最后登录日期',
                    width : 200
	            }, {
	                title : '操作',
	                width : 118,
                    formatter :  function(value, row) {
                        return '<a href="${ctx}/sys/user/form?id=' + row.id + '">修改</a>';
                    }
	            /* &nbsp;<a href="${ctx}/sys/user/delete?id=' + row.id + '">删除</a> */
	            } ]
	        });

            // 删除 
            $("#del").click(function() {
                var delUser = $("#table").bootstrapTable("getSelections");
                if (delUser == null || delUser.length !== 1) {
                    alert("请选择一条数据");
                } else {
                    var id = delUser[0].id;
                    window.location.href = "${ctx}/sys/user/delete?id=" + id;
                }
            });
            // 修改 
            $("#update").click(function() {
                var updateUser = $("#table").bootstrapTable("getSelections");
                if (updateUser == null || updateUser.length !== 1) {
                    alert("请选择一条数据");
                } else {
                    var id = updateUser[0].id;
                    window.location.href = "${ctx}/sys/user/update?id=" + id;
                }
            });
            // 导出
            $("#daochu").click(function() {
                new jBox('Confirm', {
                    title : '系统提示',
                    content : '确认要导出用户数据吗？',
                    cancelButton : '取消',
                    confirmButton : '确认',
                    confirm : function() {
                        var params = {};
                        $.downloadfile({
                            url : "${ctx}/sys/user/export",
                            data : queryParams(params)
                        });
                    }
                }).open();
            });
            // 导入
            $("#daoru").click(function() {
                new jBox('Modal', {
                    title : '导入数据',
                    closeButton : 'title',
                    content : $("#importBox")
                }).open();
            });
        });
        function queryParams(params) {
            $('#searchbar').find('input[name]').each(function() {
                params[$(this).attr('name')] = $(this).val();
            });
            return params
        }
    </script>
<style type="text/css">
	#table{
		table-layout:fixed;
	}
	#table td div{
		text-overflow: ellipsis;
		white-space: nowrap; 
		overflow: hidden;
		text-align: center;
	}
</style>
</head>
<body>
	 <ul class="breadcrumb">
        <li class="active"><a href="${ctx}/sys/user">用户管理</a></li>
    </ul>
    <div id="toolbar">
        <ul class="nav nav-pills">
            <li><a id="add" href="${ctx}/sys/user/form"><i class="icon-plus"></i>&nbsp;新增</a></li>
        </ul>
    </div>
    <div id="searchbar" class="form-search breadcrumb">
        <div class="input-prepend">
          <span class="add-on">所属单位</span>
          <sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}" 
                title="单位" url="/sys/office/treeData"  isAll="true" cssClass="input-small" cssStyle="width:220px;" allowClear="true" notAllowSelectParent="false"/>
         </div>
        <div class="input-prepend">
          <span class="add-on">登录名</span>
          <input name="loginName" class="input-small" type="text" />
        </div>
        <div class="input-prepend">
          <span class="add-on">用户名</span>
          <input name="name" class="input-small" type="text" />
        </div>
        <input id="search" class="btn btn-primary" type="button" value="查询" />
    </div>
    <div id="content">
    <sys:message content="${message}"/>
    <table id="table"></table>
    </div>
    <div id="importBox" class="hide">
        <form id="importForm" action="${ctx}/sys/user/import" method="post" enctype="multipart/form-data"
            class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
            <input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
            <input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
            <a href="${ctx}/sys/user/import/template">下载模板</a>
        </form>
    </div>
</body>
</html>