<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>系统填报有关提示管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	
	$(document).ready(function() {
	//alert("${dataTypeSearch}");
});
    $(function() {
    	init();
        $('#search').change(function() {
            $('#table').bootstrapTable('refresh');
        });
        $('#table').tfkjTable({
            url : "${ctx}/system/fieldInstruction/list",
            queryParams: 'queryParams',
            columns : [
                {
                    field : 'fieldName',
                    title : '字段名',
                    width : 220,
                    formatter : function(value,row){
						return "<div title="+value+">"+value+"</div>"
					}
                },{
                    field : 'instruction',
                    title : '提示信息',
                    width : 720,
                    formatter : function(value,row){
						return "<div title="+value+">"+value+"</div>"
					}
                },{
                    field : 'updateDate',
                    title : '更新时间',
                    width : 200,
                    formatter : function(value,row){
						return "<div title="+value+" style='text-align:center;'>"+value+"</div>"
					}
                }, {
                    title : '操作',
                    width : 60,
                    formatter : function(value, row) {
                        return "<a title='修改' class=\"icon-pencil\" href=\"${ctx}/system/fieldInstruction/form?id=" + row.id + "\"></a>&nbsp;" // 修改
                       /*  +"<a title='删除' class=\"icon-remove\" href=\"${ctx}/system/fieldInstruction/delete?id=" + row.id + "\"></a>"; // 删除 */
                    }
                }]
        });
        // 模块类型切换联动
        $("#dataTypeSearch").change(function(){
        	init();
        });
     // 导出列表
        $("#btnExport").click(function() {
            if(confirm('确认要导出数据吗？')){
            	var rows=$("#table").bootstrapTable("getSelections"),
                ids=[],
                i = 0;
                if(rows!=null && rows.length>0){
                    for (; i < rows.length; i++) {
                        ids.push(rows[i].id);
                    }}
                var dataType = "${dataTypeSearch}";
                var moduleType = "${moduleTypeSearch}";
                var s = $("#dataTypeSearch").val();
                //alert(s);
                // alert(dataType+"~~"+moduleType);
               //var name = $("#fieldInstruction.dataTypeSearch").val();
               // window.location.href="${ctx}/system/fieldInstruction/exportExcel?dataTypeSearch="+name+"&moduleTypeSearch="+name;
                window.location.href="${ctx}/system/fieldInstruction/exportExcel";
            }
        });
    });
    //设置传入参数
    function queryParams(params) {
        $('#searchbar').find('select[name]').each(function () {
            params[$(this).attr('name')] = $(this).val();
        });
        return params
    }
    function init(){
    	if($("#dataTypeSearch").val() == "01"){
    		$("#moduleTypeSearch").show();
    	}else{
    		$("#moduleTypeSearch").hide();
    	}
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
			text-align: left;
			text-indent:14px;
		}
	</style>
</head>
<body>
    <ul class="breadcrumb">
        <li class="active"><a href="${ctx}/system/fieldInstruction/">系统填报有关提示列表</a></li>
    </ul>
    <div id="toolbar">
    	 
    	 	
	     <div id="searchbar" class="input-prepend">
		    <div>
			    <ul class="nav nav-pills">
			    	<li><a id="btnExport"><i class="icon-download"></i>&nbsp;导出列表</a></li>
			    	<!-- <li><a id="daoru"><i class="icon-download"></i>&nbsp;导入列表</a></li> -->
		            <li>
		            	<a href="#importBox" data-toggle="modal" role="button"><i class="icon-download"></i>导入列表</a>
							<div id="importBox" class="modal hide fade" tabindex="-1" role="dialog"
								aria-labelledby="importBoxLabel" aria-hidden="true">
								<div class="modal-header">
									<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">数据导入</button> -->
									<b style="font-size:20px;">数据导入</b>
								</div>
								<div class="modal-body">
									<form id="importForm" action="${ctx}/system/fieldInstruction/import" method="post" enctype="multipart/form-data"
							           class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
							           <input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
							           <input id="btnImportSubmit" style=" margin-right:285px;" class="btn btn-primary" type="submit" value="   导    入   "/>
							       </form> 
								</div>
							</div>
		            </li>
			    </ul>
		    </div>
		    <div id="search" class="input-prepend">
		        <span class="add-on">所属模块</span>
		        <form:select path="fieldInstruction.dataTypeSearch">
	            	<form:options items="${fns:getDictList('YW_SJLX')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
	            </form:select>
		        <form:select path="fieldInstruction.moduleTypeSearch">
	            	<form:options items="${fns:getDictList('YW_MKLX')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
	            </form:select>
		        <!-- <input id="search" class="btn btn-primary" type="button" value="查询" style="margin-left:6px;"/> -->
	        </div>
	    </div> 
    </div>
    <sys:message content="${message}"/>
    <table id="table"></table>
</body>
</body>
</html>