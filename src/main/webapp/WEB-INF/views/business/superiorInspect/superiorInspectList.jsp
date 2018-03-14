<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>

<head>
<title>上级来我区督查列表</title>
<meta name="decorator" content="default" />
<link rel="stylesheet" href="${ctxStatic}/common/css/common.css">
<script type="text/javascript">
	$(function() {
		//年度
		var date = new Date();
		$("#taskYear").val(date.getFullYear());
		$('#search').click(function() {
			$('#table').bootstrapTable('refresh');
		});
		$('#searchInput').keydown(function(event) {
			if (event.keyCode == 13) {
				$('#search').click();
			}
		});
		$('#table')
				.tfkjTable(
						{
							url : '${ctx}/ywgl/superiorInspect/list',
							queryParams : 'queryParams',
							columns : [
									{
										field : 'state',
										checkbox : true,

									},
									{
										field : 'id',
										visible : false,

									},
									{
										field : '',
										title : "序号",
										valign : "middle",
										align : "center",
										width : 40,
										formatter : function(value, row, index) {
											//return index+1; //序号正序排序从1开始
							                var pageSize=$('#table').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
							                var pageNumber=$('#table').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
							                return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
							            }

									},
									{
										field : 'parentOfficeNamesText',
										title : "上级单位",
										valign : "middle",
										align : "center",
										width : 70,
									},
									{
										field : 'inspectMatter',
										title : "督查事项",
										valign : "middle",
										align : "center",
										formatter : function(value, row, index) {
											if(value==null){
                                                value="-";
                                            }
											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ "<a href='${ctx}/ywgl/superiorInspect/form?id="+ row.id+ "'>"+ value+ "</a>"+ "</nobr></div>";
										}
									},
									{
										field : 'inspectTime',
										title : "督查时间",
										valign : "middle",
										align : "center",
										sortable : true,
						                sortName : 'INSPECT_TIME_START',
						                width: 200,

									},
									{
										field : 's0003',
										title : "分管区领导",
										valign : "middle",
										align : "center",

										formatter : function nameFormatter(
												value, row) {

											var manager = "";
											if (value) {
												var array = value
														.split(/[,，、]/);
												var length = array.length;
												if (array.length >= 2) {
													manager = array[0] + "等"
															+ length + "位领导";
												} else {
													manager = array[0];
												}
											}
											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + manager + "'><nobr>"
					                        + manager + "</nobr></div>";
										}

									},
									{
										field : 's0004',
										title : "对接协调单位",
										valign : "middle",
										align : "center",
										formatter : function nameFormatter(
												value, row) {

											var manager = "";

											if (value) {
												var array = value
														.split(/[,，、]/);
												var length = array.length;
												if (array.length >= 2) {
													manager = array[0] + "等"
															+ length + "家单位";
												} else {
													manager = array[0];
												}
											}
											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + manager + "'><nobr>"
					                        + manager + "</nobr></div>";
										}

									},
									{
										field : 's0005',
										title : "承办单位",
										valign : "middle",
										align : "center",
										formatter : function nameFormatter(
												value, row) {

											var manager = "";

											if (value) {
												var array = value
														.split(/[,，、]/);
												var length = array.length;
												if (array.length >= 2) {
													manager = array[0] + "等"
															+ length + "家单位";
												} else {
													manager = array[0];
												}
											}
											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + manager + "'><nobr>"
					                        + manager + "</nobr></div>";
										}

									}, {
										field : 'checkContent',
										title : "督查要求",
										valign : "middle",
										align : "center",
										formatter : function(value, row) {
											if(value==null){
                                                value="-";
                                            }
											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ value + "</nobr></div>";
										}
									}, {
										field : 'resultSituation',
										title : "落实情况",
										valign : "middle",
										align : "center",
										formatter : function(value, row) {
											if(value==null){
                                                value="-";
                                            }
											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ value + "</nobr></div>";
										}

									}, {
										field : 'taskStateText',
										title : "状态",
										valign : "middle",
										align : "center",
										width : 60,

									}, {
										field : 's0002',
										title : "落实时间",
										valign : "middle",
										align : "center",
										width :100,
									} ],

							onClickRow : function(row, $element, field) {
								$('#table').bootstrapTable('uncheckAll');
								$('#table').bootstrapTable('check',
										$element[0].rowIndex - 1);
							},
						});

		//重置
		 $("#clear").click(function() {

                $('#searchForm').find('input[name]').each(function() {
                    $(this).val("");
                });
                $('#searchForm').find('select[name]').each(function() {
                	$(this).val("");
        		});
              //年度
        		var date = new Date();
        		$("#taskYear").val(date.getFullYear());
            });
		// 删除
		$("#delBtn")
				.click(
						function() {
							var rows = $("#table").bootstrapTable(
									"getSelections");
							ids = [], i = 0;
							if (rows != null && rows.length > 0) {
								for (; i < rows.length; i++) {
									ids.push(rows[i].id);
								}
							}
							if (ids.length == 0) {
								alertx("请选择要删除的信息!");
								return;
							} else {
								confirmx('确认要删除吗？',"${ctx}/ywgl/superiorInspect/listToDelete?ids="
										+ ids);
							}
						});

	});

	function queryParams(params) {
		$('#searchForm').find('input[name]').each(function() {
			params[$(this).attr('name')] = $(this).val();
		});
		$('#searchForm').find('select[name]').each(function() {
			params[$(this).attr('name')] = $(this).val();
		});
		return params;
	}

	//导出excel
    function exportExcel() {
        confirmx('确认要导出数据吗？',function(){
             var rows=$("#table").bootstrapTable("getSelections"),
             ids=[],
             i = 0;
         if(rows!=null && rows.length>0){
             for (; i < rows.length; i++) {
                 ids.push(rows[i].id);
             }
         }
         var obj = {};
         $('#searchForm').find('input[name]').each(function () {
             obj[$(this).attr('name')] = $(this).val();
         });
         $('#searchForm').find('select[name]').each(function () {
             obj[$(this).attr('name')] = $(this).val();
         });
         var par = $.param(obj);
         var decodeParams = decodeURIComponent(par);
         window.location.href="${ctx}/ywgl/superiorInspect/exportExcel?ids="+ids+"&"+decodeParams;
        },'')
    }
</script>
<style type="text/css">
.navbar .nav>li>a {
	float: none;
	padding: 10px 15px 10px;
	color: #dd4814;
	text-decoration: none;
}

.navbar {
	margin-bottom: 5px;
	margin-left: 10px;
}

.navbar .nav li.dropdown.open>.dropdown-toggle, .navbar .nav li.dropdown.active>.dropdown-toggle,
	.navbar .nav li.dropdown.open.active>.dropdown-toggle {
	color: #ffffff;
	background-color: #dd2014;
}
</style>
<style type="text/css">
#table {
	table-layout: fixed;
}

/* 列表长度超出部分以省略号显示样式控制*/
#table td div {
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
	text-align: left;
	text-indent: 14px;
}

/* 列表长度超出部分以省略号显示样式控制 */
</style>
</head>

<body>
	<ul class="breadcrumb">
		<li class="active">上级来我区督查列表</li>
	</ul>
	<div>
		<form:form id="searchForm" modelAttribute="superiorInspect" action="${ctx}/superiorInspect/list" method="post">
			<div class="controls controls-row">

				<div class="search-div input-prepend input-append">
					<span class="add-on">督查事项</span>
					<form:input cssClass="search-input-medium" path="inspectMatter" htmlEscape="false" maxlength="50" />
				</div>
				<div class="search-div input-prepend input-append margin-left-2">
					<span class="add-on">督查要求</span>
					<form:input cssClass="search-input-medium" path="checkContent" htmlEscape="false" maxlength="50" />
				</div>
				<div class="search-div input-prepend input-append margin-left-1">
					<span class="add-on">督查时间</span>
					<input class="search-input-mini" type="text" name="inspectTimeStart" value="<fmt:formatDate value="${inspectTimeStart}" pattern="yyyy-MM-dd" />"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
					<span class="add-on">至</span>
					<input class="search-input-mini" type="text" name="inspectTimeEnd" value="<fmt:formatDate value="${inspectTimeEnd}" pattern="yyyy-MM-dd" />"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
				</div>
				<div class="search-div input-prepend input-append">
					<span class="add-on">状态</span>
					<form:select path="taskState" class="search-select-mini">
						<option value="">全部</option>
						<form:options items="${fns:getDictList('YW_DCLSQK')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
					</form:select>
				</div>
			</div>
			<div class="controls controls-row">
				<div class="search-div input-prepend input-append ">
					<span class="add-on">承办单位</span>
					<sys:treeselect id="dutyOfficeIds" name="dutyOfficeIds" value="${superiorInspect.dutyOfficeIds}" labelName="s0005" labelValue="${superiorInspect.s0005}" title="单位"
						url="/sys/office/treeData" notAllowSelectParent="true" cssClass="required"  hideBtn="true" />
				</div>
				<div class="search-div input-prepend input-append margin-left-2">
					<span class="add-on">落实情况</span>
					<form:input cssClass="search-input-medium" path="resultSituation" htmlEscape="false" maxlength="50" />
				</div>

				<div class="search-div input-prepend input-append margin-left-1">
					<span class="add-on">落实时间</span>
					<input class="search-input-mini" type="text" name="s0002Start" value="<fmt:formatDate value="${s0002Start}" pattern="yyyy-MM-dd" />"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
					<span class="add-on">至</span>
					<input class="search-input-mini" type="text" name="s0002End" value="<fmt:formatDate value="${s0002End}" pattern="yyyy-MM-dd" />" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
				</div>
				<div class="search-div input-prepend input-append">
					<span class="add-on">年度</span>
					<fmt:parseDate value="${yearTaskTableData.taskYear}" var="taskYear" pattern="yyyy" />
					<input class="search-input-mini" type="text" id="taskYear" name="taskYear" value="<fmt:formatDate value="${taskYear}" pattern="yyyy" />"
						onfocus="WdatePicker({dateFmt:'yyyy'})" />
				</div>
			</div>
			<div class="controls controls-row">
				<div class="search-div input-prepend input-append">
					<span class="add-on">上级单位</span>
					<form:select path="parentOfficeIds" class="search-select-medium">
						<option value="">全部</option>
						<form:options items="${fns:getDictList('YW_SJDW')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
					</form:select>
				</div>
				<div class="search-div input-prepend input-append ">
					<span class="add-on">对接协调单位</span>
					<sys:treeselect id="cohereOfficeIds" name="cohereOfficeIds" value="${superiorInspect.cohereOfficeIds}" labelName="s0004" labelValue="${superiorInspect.s0004}" title="单位"
						url="/sys/office/treeData" cssClass="required"  allowClear="true" notAllowSelectParent="true" hideBtn="true" />
				</div>

				<div class="search-div input-prepend input-append">
					<span class="add-on">分管区领导</span>
					<sys:treeselect id="chargeOfficeIds" name="chargeOfficeIds" value="${superiorInspect.s0003}" labelName="s0003" labelValue="${superiorInspect.s0003}" title="领导"
						url="/sys/leader/leaderTree?type=01" cssClass="required"  allowClear="true" notAllowSelectParent="fasle" hideBtn="true" />
				</div>


				<input id="search" class="btn btn-primary" type="button" value="查询" />
				<input id="clear" class="btn btn-primary" type="button" value="重置" />
			</div>
		</form:form>
	</div>
	<div id="toolbar">
		<ul class="nav nav-pills">
			<li>
				<a id="addBtn" href="${ctx}/ywgl/superiorInspect/form">
					<i class="icon-plus"></i> &nbsp;新增
				</a>
			</li>
			<li>
				<a id="delBtn" href="javascript:void(0)">
					<i class="icon-trash"></i> &nbsp;删除
				</a>
			</li>
			<li>
				<a id="exportExcel" onclick="exportExcel()">
					<i class="icon-download"></i> &nbsp;导出台账
				</a>
			</li>
		</ul>
	</div>

	<sys:message content="${message}" />
	<div id="content">
		<table id="table"></table>
	</div>
</body>

</html>