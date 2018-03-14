<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>年度重点任务督查</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treetable.jsp"%>
<script type="text/javascript" src="${ctxStatic}/common/ywgl.js"></script>
<link rel="stylesheet" href="${ctxStatic}/common/css/common.css">
<script type="text/javascript">
	function addYearTask() {
		$.jBox("iframe:${ctx}/ywgl/yearTask/singleYearTaskForm", {
			title : "新增目标任务",
			width : 600,
			height : 400,
			buttons : {
				'保存' : 1,
				'保存并分解任务' : 2
			},
			dragLimit : true,
			submit : function(v, h, f) {
				
				var formData = $("#jbox-iframe").contents()
						.find("#addYearTask").serialize();
				var addYearTask = $("#jbox-iframe").contents().find(
						"input[name='taskYear'").val();
				var sort = $("#jbox-iframe").contents().find("#sort").val();
				if (v == 1) {
					if (addYearTask == null || addYearTask == "") {
						alert("年度不能为空！");
						$("#jbox-iframe").contents().find(
								"input[name='taskYear'").focus();
						return false;
					}
					if (sort == null || sort == "") {
						$("#jbox-iframe").contents().find("input[name='sort'")
								.focus();
						alert("序号不能为空！");
						return false;
					}
					$.ajax({
						type : "post",
						data : formData,
						url : "${ctx}/ywgl/yearTask/saveYearTask",
						cache : false,
						success : function(data) {
							$.jBox.close();
							alert("恭喜您保存成功！");
							return true;
						},
						error : function(res) {
							$.jBox.close();
							alert("保存失败，请重试！");
							return true;
						}
					})
				}
				if (v == 2) {
					if (addYearTask == null || addYearTask == "") {
						alert("年度不能为空！");
						$("#jbox-iframe").contents().find(
								"input[name='taskYear'").focus();
						return false;
					}
					if (sort == null || sort == "") {
						$("#jbox-iframe").contents().find("input[name='sort'")
								.focus();
						alert("序号不能为空！");
						return false;
					}
					$.ajax({
						type : "post",
						data : formData,
						url : "${ctx}/ywgl/yearTask/saveYearTaskAndExplain",
						cache : false,
						success : function(id) {
							location.href = "${ctx}/ywgl/yearTask/form?id="
									+ id;
							$.jBox.close();
							return true;
						},
						error : function(res) {
							$.jBox.close();
							alert("保存失败，请重试！");
							return true;
						}
					})
				}

			},
			// 点击状态按钮后的回调函数，返回true时表示关闭窗口，    
			//参数有三个，v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
			// opacity: 0, /* 窗口隔离层的透明度,如果设置为0,则不显示隔离层，即遮罩层，设置为0时，
			//点击弹框意外位置不会关闭弹窗，有弹窗时无法操作弹窗外的内容。*/
			persistent : true
		/*在显示隔离层的情况下，点击隔离层时，是否坚持窗口不关闭 */
		});
	}
</script>
<script type="text/javascript">
	$(function() {
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
							url : '${ctx}/ywgl/yearTask/list',
							sortName : 'UPDATE_DATE',
							sortOrder : 'desc',
							queryParams : 'queryParams',
							columns : [
									[
											{
												field : 'state',
												checkbox : true,
												colspan : 1,
												rowspan : 2
											},
											{
												field : 'id',
												visible : false,
												colspan : 1,
												rowspan : 2
											},
											{
												field : 'sort',
												title : "序号",
												valign : "middle",
												align : "center",
												colspan : 1,
												rowspan : 2,
												formatter : function nameFormatter(
														value, row) {
													return "<a href='${ctx}/ywgl/yearTask/form?id="
															+ row.id
															+ "'>"
															+ value + "</a>";
												}
											},
											{
												field : 'targetTask',
												title : "目标任务",
												valign : "middle",
												align : "center",
												colspan : 1,
												rowspan : 2,
												formatter : function nameFormatter(
														value, row) {
													return "<a href='${ctx}/ywgl/yearTask/form?id="
															+ row.id
															+ "'>"
															+ value + "</a>";
												}
											}, {
												field : 'leadOfficeNames',
												title : "牵头单位",
												valign : "middle",
												align : "center",
												colspan : 1,
												rowspan : 2
											}
											, {
												field : 'leadOfficeChargePersons',
												title : "牵头单位责任人",
												valign : "middle",
												align : "center",
												colspan : 1,
												rowspan : 2
											}, {
												field : 'dutyOfficeNames',
												title : "责任单位",
												valign : "middle",
												align : "center",
												colspan : 1,
												rowspan : 2
											}, {
												field : 'chargeOfficeChargePersons',
												title : "分管区领导",
												valign : "middle",
												align : "center",
												colspan : 1,
												rowspan : 2
											}, {
												field : 'taskState',
												title : "目标任务状态",
												valign : "middle",
												align : "center",
												colspan : 1,
												rowspan : 2
											}, {
												title : "进度安排",
												valign : "middle",
												align : "center",
												colspan : 4,
												rowspan : 1
											}, {
												title : "完成情况",
												valign : "middle",
												align : "center",
												colspan : 4,
												rowspan : 1
											}, {
												field : '',
												title : "分解状态",
												valign : "middle",
												align : "center",
												colspan : 1,
												rowspan : 2
											}, {
												field : 'updateDate',
												title : "更新时间",
												valign : "middle",
												align : "center",
												colspan : 1,
												rowspan : 2
											} ], [ {
										field : 'firstQuarterTaskPlan',
										title : '一季度',
										valign : "middle",
										align : "center"
									}, {
										field : 'secondQuarterTaskPlan',
										title : '二季度',
										valign : "middle",
										align : "center"
									}, {
										field : 'thirdQuarterTaskPlan',
										title : '三季度',
										valign : "middle",
										align : "center"
									}, {
										field : 'fourthQuarterTaskPlan',
										title : '四季度',
										valign : "middle",
										align : "center"
									}, {
										field : 'firstQuarterTaskExecution',
										title : '一季度',
										valign : "middle",
										align : "center"
									}, {
										field : 'secondQuarterTaskExecution',
										title : '二季度',
										valign : "middle",
										align : "center"
									}, {
										field : 'thirdQuarterTaskExecution',
										title : '三季度',
										valign : "middle",
										align : "center"
									}, {
										field : 'fourthQuarterTaskExecution',
										title : '四季度',
										valign : "middle",
										align : "center"
									} ],

							],
							onClickRow : function(row, $element, field) {
								$('#table').bootstrapTable('uncheckAll');
								$('#table').bootstrapTable('check',
										$element[0].rowIndex - 1);
							},
							onLoadSuccess : function(data) {
								var data = $('#table').bootstrapTable(
										'getData', true);
								//合并单元格
								mergeCells(data, "sort,targetTask,leadOfficeNames,dutyOfficeNames,chargeOfficeChargePersons,taskState","dataId", 1, $('#table'));
							},
						});

		//重置
		$("#clear").click(function() {
			
			var a = $('#searchForm').find('input[name]');
			$('#searchForm').find('input[name]').each(function() {
				$(this).val("");
				$('#table').bootstrapTable('refresh');
			});
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
								if (confirm('确认要对选中信息删除吗？')) {
									resetTip();
									window.location.href = "${ctx}/ywgl/yearTask/listToDelete?ids="
											+ ids;
								}
							}
						});
	});

	function queryParams(params) {
		return params;
	}
</script>
</head>
<body>
	<div>
		<form:form id="searchForm" modelAttribute="yearTaskTableElement" action="${ctx}/sys/office/cxlist" method="post" style="margin:0px;">
			<div class="form-search breadcrumb">
				<div class="input-prepend">
					<span class="add-on">牵头单位</span>
					<form:input path="leadOfficeNames" htmlEscape="false" maxlength="50" />
				</div>
				<div class="input-prepend">
					<span class="add-on">分管区领导</span>
					<form:input path="chargeOfficeNames" htmlEscape="false" maxlength="50" />
				</div>
				<div class="input-prepend">
					<span class="add-on">进度安排</span>
					<form:input path="taskPlan" htmlEscape="false" maxlength="50" />
				</div>
				<div class="input-prepend">
					<span class="add-on">目标任务状态</span>
					<form:select path="targetTaskState" style="width:100px;">
						<option value=""></option>
						<form:options items="${fns:getDictList('YW_RWZT')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
					</form:select>
				</div>
				<div class="input-prepend" style="float:right;width:140px;">
					<span class="add-on">年度</span>
					<fmt:parseDate value="${taskYear}" var="taskYear" pattern="yyyy" />
					<input style="width: 50px;" class="input1" type="text" name="taskYear" value="<fmt:formatDate value="${taskYear}" pattern="yyyy" />" onfocus="WdatePicker({dateFmt:'yyyy'})" />
				</div>
			</div>
			<div class="form-search breadcrumb">
				<div class="input-prepend">
					<span class="add-on">责任单位</span>
					<form:input path="dutyOfficeNames" htmlEscape="false" maxlength="50" />
				</div>
				<div class="input-prepend">
					<span class="add-on" style="margin-left: 28px;">责任人</span>
					<form:input path="dutyOfficeChargePersons" htmlEscape="dutyOffice.chargePerson" maxlength="50" />
				</div>
				<div class="input-prepend">
					<span class="add-on">完成情况</span>
					<form:input path="taskExecution" htmlEscape="false" maxlength="50" />
				</div>
				<div class="input-prepend">
					<span class="add-on">分解任务状态</span>
					<form:select path="taskState" style="width:100px;">
						<option value=""></option>
						<form:options items="${fns:getDictList('YW_RWZT')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
					</form:select>
				</div>
				<input id="search" class="btn btn-primary" type="button" value="查询" />
				<input id="clear" class="btn btn-primary" type="button" value="重置" />
			</div>
		</form:form>
	</div>
	<div id="toolbar">
		<ul class="nav nav-pills">
			<li>
				<a id="addBtn" onclick="addYearTask()">
					<i class="icon-plus"></i> &nbsp;新增目标任务
				</a>
			</li>
			<li>
				<a id="delBtn" href="javascript:void(0)">
					<i class="icon-copy"></i> &nbsp;删除
				</a>
			</li>
			<li>
				<a id="saveSort" href="javascript:void(0)">
					<i class="icon-edit"></i> &nbsp;保存排序
				</a>
			</li>
			<li>
				<a id="exportExcel" href="javascript:void(0)">
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
