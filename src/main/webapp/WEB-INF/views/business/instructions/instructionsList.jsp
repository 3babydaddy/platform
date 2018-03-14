<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>批示件列表</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treetable.jsp"%>
<link rel="stylesheet" href="${ctxStatic}/common/css/common.css">
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
.style_input_width_small {
	width: 100px;
}

.style_select_width_small {
	width: 140px;
}

.style_date_width_small {
	width: 80px
}
</style>
<script type="text/javascript">
	$(function() {
		//年度
		var date = new Date();
		$("#taskYear").val(date.getFullYear());
		$('#searchInput').keydown(function(event) {
			if (event.keyCode == 13) {
				$('#search').click();
			}
		});
		//关联按钮
		$("#addRelateBtn").click(
				function() {
					var rows = $("#table").bootstrapTable("getSelections");
					ids = [], i = 0;
					if (rows != null && rows.length > 0) {
						for (; i < rows.length; i++) {
							ids.push(rows[i].dataId);
						}
					}
					if (ids.length == 0) {
						alertx("请选择要关联的信息!");
						return;
					}
					$.jBox(
							"iframe:${ctx}/ywgl/instructions/addSpecialReportList?ids="
									+ ids, {
								title : "添加关联任务",
								width : 800,
								height : 550,

								buttons : {}, // no buttons
								showScrolling : false,
								dragLimit : true,
								submit : function(v, h, f) {

								},
								// 点击状态按钮后的回调函数，返回true时表示关闭窗口，    参数有三个，v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
								// opacity: 0, /* 窗口隔离层的透明度,如果设置为0,则不显示隔离层，即遮罩层，设置为0时，点击弹框意外位置不会关闭弹窗，有弹窗时无法操作弹窗外的内容。*/
								closed : function() {
									isRelation();

								},
								persistent : true
							/*在显示隔离层的情况下，点击隔离层时，是否坚持窗口不关闭 */
							});
				});
		// 删除
		$("#delBtn").click(
				function() {

					var rows = $("#table").bootstrapTable("getSelections");
					ids = [], i = 0;
					if (rows != null && rows.length > 0) {
						for (; i < rows.length; i++) {
							ids.push(rows[i].dataId);
						}
					}
					if (ids.length == 0) {
						alertx("请选择要删除的信息!");
						return;
					} else {
						confirmx('确认要删除吗？',
								"${ctx}/ywgl/instructions/listToDelete?ids="
										+ ids);
					}
				});
		$('#table')
				.tfkjTable(
						{
							url : '${ctx}/ywgl/instructions/list',
							sortOrder : 'desc',
							queryParams : 'queryParams',
							columns : [
									{
										field : 'state',
										checkbox : true,
									},
									{
										field : 'dataId',
										visible : false,
									},
									{
										field : 'num',
										title : "序号",
										valign : "middle",
										align : "center",
										width : 40,

									},
									{
										field : 'parentIn0016Text',
										title : "文件类型",
										valign : "middle",
										align : "center",
									},
									{
										field : 'parentIn0017Text',
										title : "来源",
										valign : "middle",
										align : "center",
									},
									{
										field : 'parentIn0001',
										title : "文件名",
										valign : "middle",
										align : "center",
										width : 100,
										formatter : function(value, row) {
											var strB = "";

											if (row.parentIn0019 == ''
													|| row.parentIn0019 == null) {
												strB = "<a href='${ctx}/ywgl/instructions/form?id="
														+ row.dataId + "' >"
														+ value + "</a>"
											}
											if (row.parentIn0019 == '01') {
												strB =  ""
														+ "<a  href='${ctx}/ywgl/instructions/form?id="
														+ row.dataId + "' >"
														+"<i class='icon-exclamation-sign' title='重点关注'></i>"
														+ value + " </a>"
											}
											if (row.parentIn0019 == '02') {
												strB = ""
														+ "<a href='${ctx}/ywgl/instructions/form?id="
														+ row.dataId + "' >"
														+"<i class='icon-star' title='报送领导'></i>"
														+ value + "</a>"
											}
											if (row.parentIn0019 == '01,02') {
												strB = ""
														+ "<a href='${ctx}/ywgl/instructions/form?id="
														+ row.dataId + "' >"
														+"<i class='icon-exclamation-sign' title='重点关注'></i>"
														+"<i class='icon-star' title='报送领导'></i>"
														+ value + "</a>"
											}
											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
											+ strB + "</nobr></div>";
										}
									},
									{
										field : 'parentIn0002',
										title : "文件号",
										valign : "middle",
										align : "center",
										formatter : function(value, row) {
											if (value == null) {
												value = "-";
											}
											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ value + "</nobr></div>";
										}

									},
									{
										field : 'parentIn0003Text',
										title : "批示内容及日期",
										valign : "middle",
										align : "center",
										colspan : 1,
										formatter : function(value, row) {

											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ value + "</nobr></div>";
										}

									},
									{
										field : 'parentIn0005',
										title : "收件日期",
										valign : "middle",
										align : "center",
										sortable : true,
						                sortName : 'a.in0005',
										formatter : function(value, row) {
											if (value == null) {
												value = "-";
											}
											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ value + "</nobr></div>";
										}

									},
									{
										field : 'parentIn0006Text',
										title : "按轻重分类",
										valign : "middle",
										align : "center",
										formatter : function(value, row) {
											if (value == null) {
												value = "-";
											}
											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ value + "</nobr></div>";
										}

									},
									{
										field : 'parentIn0007Text',
										title : "按要求分类",
										valign : "middle",
										align : "center",
										formatter : function(value, row) {
											if (value == null) {
												value = "-";
											}
											return "<div style='width: 110px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ value + "</nobr></div>";
										}

									},
									{
										field : 'parentIn0008Text',
										title : "按内容分类",
										valign : "middle",
										align : "center",
										formatter : function(value, row) {
											if (value == null) {
												value = "-";
											}
											return "<div style='width: 130px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ value + "</nobr></div>";
										}

									},
									{
										field : 'parentIn0018',
										title : "备注",
										valign : "middle",
										align : "center",
										formatter : function(value, row) {
											if (value == null) {
												value = "-";
											}
											return "<div style='width: 130px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ value + "</nobr></div>";
										}

									},
									{
										field : 'parentIn0010Text',
										title : "责任领导",
										valign : "middle",
										align : "center",
										formatter : function(value, row) {
											if (value == null) {
												value = "-";
											}
											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ value + "</nobr></div>";
										}

									},
									{
										field : 'parentIn0009Text',
										title : "承办单位",
										valign : "middle",
										align : "center",
										formatter : function(value, row) {

											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ value + "</nobr></div>";
										}
									},
									{
										field : 'parentIn0011',
										title : "催办日期",
										valign : "middle",
										align : "center",
										formatter : function(value, row) {
											if (value == null) {
												value = "-";
											}
											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ value + "</nobr></div>";
										}
									},
									{
										field : 'parentIn0013Text',
										title : "是否超期",
										valign : "middle",
										align : "center",
										formatter : function(value, row) {
											if (value == null) {
												value = "-";
											}
											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ value + "</nobr></div>";
										}
									},
									{
										field : 'parentIn0012Text',
										title : "办理情况",
										valign : "middle",
										align : "center",
										formatter : function(value, row) {
											if (value == null) {
												value = "-";
											}
											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ value + "</nobr></div>";
										}
									},
									{
										field : 'parentIn0014',
										title : "落实及上报情况",
										valign : "middle",
										align : "center",
										formatter : function(value, row) {
											if (value == null) {
												value = "-";
											}
											return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
													+ value + "</nobr></div>";
										}
									},
									{
										field : 'parentIn0020Text',
										title : "专报",
										valign : "middle",
										align : "center",
										   formatter: function (value, row) {
					                            var manager = "";
					                            if(value==null || value==''){
					                            	return manager;
					                            }
					                            if (value.length>5){
					                                manager = value.substring(0,5)+"...";
					                                return "<nobr>" +
					                                    "<a title = '"+value+"' href='${ctx}/specialReport/form?id=" + row.parentIn0020Id + "'>" + manager + "</a>"
					                                    + "</nobr>"
					                            }else{
					                                return "<nobr>" +
					                                    "<a href='${ctx}/specialReport/form?id=" + row.parentIn0020Id + "'>" + value + "</a>"
					                                    + "</nobr>"
					                            }

					                        }
									}

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
								mergeCells(
										data,
										"num,state,parentIn0016Text,parentIn0017Text,parentIn0001,parentIn0002,in0003Text,parentIn0005,parentIn0006Text,parentIn0007Text,parentIn0008Text,parentIn0003Text,parentIn0018Text,parentIn0018,parentIn0020Text",
										"dataId", 1, $('#table'));

							},
						});
		//查询
		$("#searchButton").click(function() {
			$('#table').bootstrapTable('refresh');
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
	})

	/**
	 * 合并单元格
	 * @param data  原始数据（在服务端完成排序）
	 * @param fieldName 合并属性名称
	   @param flagName  标记属性名称
	 * @param colspan   合并列
	 * @param target    目标表格对象
	 */
	function mergeCells(data, fieldName, flagName, colspan, target) {
		//声明一个map计算相同属性值在data对象出现的次数和
		var sortMap = {};
		for (var i = 0; i < data.length; i++) {
			for ( var prop in data[i]) {

				if (prop == flagName) {
					var key = data[i][prop]
					if (sortMap.hasOwnProperty(key)) {
						sortMap[key] = sortMap[key] * 1 + 1;
					} else {
						sortMap[key] = 1;
					}
					break;
				}
			}
		}
		/*  for(var prop Rin sortMap){
		     console.log(prop,sortMap[prop])
		 } */
		//获取每页显示的数量
		var pageSize = $(target).bootstrapTable('getOptions').pageSize;
		//获取当前是第几页
		var pageNumber = $(target).bootstrapTable('getOptions').pageNumber;
		var i = pageSize * (pageNumber - 1) + 1;
		var index1 = 0;
		for ( var prop in sortMap) {
			var count = sortMap[prop] * 1;
			$(target).bootstrapTable('updateRow', {
				index : index1,
				row : {
					num : i
				}
			});
			index1 += count;
			i++;
		}
		//合并单元格
		var index = 0;
		for ( var prop in sortMap) {
			var count = sortMap[prop] * 1;
			$(target).bootstrapTable('mergeMulCells', {
				index : index,
				field : fieldName,
				colspan : colspan,
				rowspan : count
			});
			index += count;
			i++;
		}

	}
	function queryParams(params) {
		$('#searchForm').find('input[name]').each(function() {
			params[$(this).attr('name')] = $(this).val();
		});
		$('#searchForm').find('select[name]').each(function() {
			params[$(this).attr('name')] = $(this).val();
		});
		return params;
	}

	function urge() {
        var rows = $("#table").bootstrapTable("getSelections"),
            ids = [], i = 0;
        if (rows != null && rows.length > 0) {
            for (; i < rows.length; i++) {
                ids.push(rows[i].dataId);
            }
        }
        if(rows.length>0){
            $.jBox("iframe:${ctx}/reminders/addUrge?ids="+ids, {
                title: "催办",
                width: 300,
                height:300,

                buttons: { }, // no buttons
                showScrolling : false,
                dragLimit: true,
                submit: function (v, h, f) {

                },
                // 点击状态按钮后的回调函数，返回true时表示关闭窗口，    参数有三个，v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
                // opacity: 0, /* 窗口隔离层的透明度,如果设置为0,则不显示隔离层，即遮罩层，设置为0时，点击弹框意外位置不会关闭弹窗，有弹窗时无法操作弹窗外的内容。*/
                closed:function (){
                    $('#table').bootstrapTable('refresh');
                },
                persistent: true /*在显示隔离层的情况下，点击隔离层时，是否坚持窗口不关闭 */
            });
        }else{
            alertx("请选择！");
        }

    }
	//导出excel
	  function exportExcel() {
          confirmx('确认要导出数据吗？',function(){
               var rows=$("#table").bootstrapTable("getSelections"),
               ids=[],
               i = 0;
           if(rows!=null && rows.length>0){
               for (; i < rows.length; i++) {
                   ids.push(rows[i].dataId);
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
           window.location.href="${ctx}/ywgl/instructions/exportExcel?ids="+ids+"&"+decodeParams;
          },'')
      }

</script>
</head>
<body>
	<ul class="breadcrumb">
		<li class="active">批示件列表</li>
	</ul>
	<div>
		<form:form id="searchForm" modelAttribute="query">
			<input name="type" id="type" type="hidden" />
			<div class="controls controls-row ">
				<div class="search-div input-prepend input-append margin-left-1">
					<span class="add-on">文件名</span>
					<form:input cssClass="search-input-medium style_input_width_small" path="in0001" htmlEscape="false" maxlength="50" />
				</div>
				<div class="search-div input-prepend input-append ">
					<span class="add-on">批示时间</span>
					<input class="search-input-small style_date_width_small" type="text" name="in0004Start" onfocus="WdatePicker()" />
					<span class="add-on">至</span>
					<input class="search-input-small style_date_width_small" type="text" name="in0004End" onfocus="WdatePicker()" />
				</div>

				<div class="search-div input-prepend input-append ">
					<span class="add-on">按轻重分类</span>
					<form:select path="in0006" class="search-select-mini style_select_width_small">
						<option value="">全部</option>
						<form:options items="${fns:getDictList('YW_PS_FL_QZ')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
					</form:select>
				</div>

				<div class="search-div input-prepend input-append margin-left-2">
					<span class="add-on">备注</span>
					<form:input cssClass="search-input-medium style_input_width_small" path="in0018" htmlEscape="false" maxlength="50" />
				</div>
				<div class="search-div input-prepend input-append ">
					<span class="add-on">文件类型</span>
					<form:select path="in0016" class="search-select-mini style_select_width_small">
						<option value="">全部</option>
						<form:options items="${fns:getDictList('YW_PS_WJLX')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
					</form:select>
				</div>

			</div>

			<div class="controls controls-row ">
				<div class="search-div input-prepend input-append margin-left-1">
					<span class="add-on">文件号</span>
					<form:input cssClass="search-input-medium style_input_width_small" path="in0002" htmlEscape="false" maxlength="50" />
				</div>
				<div class="search-div input-prepend input-append ">
					<span class="add-on">收件时间</span>
					<input class="search-input-small style_date_width_small" type="text" name="in0005Start" onfocus="WdatePicker()" />
					<span class="add-on">至</span>
					<input class="search-input-small style_date_width_small" type="text" name="in0005End" onfocus="WdatePicker()" />
				</div>

				<div class="search-div input-prepend input-append ">
					<span class="add-on">按要求分类</span>
					<form:select path="in0007" class="search-select-mini style_select_width_small">
						<option value="">全部</option>
						<form:options items="${fns:getDictList('YW_PS_FL_YQ')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
					</form:select>
				</div>
				<div class="search-div input-prepend input-append ">
					<span class="add-on">责任领导</span>
					<sys:treeselect id="in0009" cssStyle="width: 100px;" name="leaderIds" value="" labelName="in0009" labelValue="${query.in0009Text}" title="领导" url="/sys/leader/leaderTree?type=01"
						cssClass="required" allowClear="true" notAllowSelectParent="fasle" hideBtn="true" />

				</div>

				<div class="search-div input-prepend input-append ">
					<span class="add-on">是否超期</span>
					<form:select path="in0012" class="search-select-mini style_select_width_small">
						<option value="">全部</option>
						<form:options items="${fns:getDictList('YW_SF')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
					</form:select>
				</div>
			</div>
			<div class="controls controls-row ">
				<div class="search-div input-prepend input-append ">
					<span class="add-on">批示内容</span>
					<form:input cssClass="search-input-medium style_input_width_small" path="in0003" htmlEscape="false" maxlength="50" />
				</div>
				<%--<div class="search-div input-prepend input-append ">--%>
					<%--<span class="add-on">催办日期</span>--%>
					<%--<input class="search-input-small style_date_width_small" type="text" name="in0011Start" onfocus="WdatePicker()" />--%>
					<%--<span class="add-on">至</span>--%>
					<%--<input class="search-input-small style_date_width_small" type="text" name="in0011End" onfocus="WdatePicker()" />--%>
				<%--</div>--%>
				<div class="search-div input-prepend input-append margin-left-2">
					<span class="add-on">专报</span>
					<form:input cssStyle="width:200px" cssClass="search-input-medium style_input_width_small" path="in0020" htmlEscape="false" maxlength="50" />
				</div>
				<div class="search-div input-prepend input-append ">
					<span class="add-on">按内容分类</span>
					<form:select path="in0008" class="search-select-mini style_select_width_small">
						<option value="">全部</option>
						<form:options items="${fns:getDictList('YW_PS_FL_NR')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
					</form:select>
				</div>
				<div class="search-div input-prepend input-append ">
					<span class="add-on">承办单位</span>
					<sys:treeselect id="in0010" cssStyle="width: 100px;" name="officeIds" value="" labelName="in0010" labelValue="${query.in0010Text}" title="单位" url="/sys/office/treeData"
						cssClass="required" allowClear="true" notAllowSelectParent="true" hideBtn="true" />
				</div>
				<div class="search-div input-prepend input-append ">
					<span class="add-on">办理情况</span>
					<form:select path="in0013" class="search-select-mini style_select_width_small">
						<option value="">全部</option>
						<form:options items="${fns:getDictList('YW_PS_BLQK')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
					</form:select>
				</div>


				<div class="controls controls-row ">

					<div class="search-div input-prepend input-append  input-append margin-left-2 ">
						<span class="add-on">年度</span>
						<fmt:parseDate value="${query.taskYear}" var="taskYear" pattern="yyyy" />
						<input class="search-input-mini" style="width: 100px" type="text" id="taskYear" name="taskYear" value="<fmt:formatDate value="${taskYear}" pattern="yyyy" />"
							onfocus="WdatePicker({dateFmt:'yyyy'})" />
					</div>

					<div class="search-div input-prepend">
						<span class="add-on">落实及上报情况</span>
						<form:input cssStyle="width:158px;" cssClass="search-input-medium style_input_width_small" path="in0014" htmlEscape="false" maxlength="50" />
					</div>
					<div class="search-div input-prepend input-append ">
						<span class="add-on">标记</span>
						<form:select path="in0019" class="search-select-mini style_select_width_small">
							<option value="">全部</option>
							<form:options items="${fns:getDictList('YW_PS_BJ')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
						</form:select>
					</div>

					<div class="search-div input-prepend input-append input-append margin-left-3">
						<span class="add-on">来源</span>
						<form:select path="in0017" class="search-select-mini style_select_width_small">
							<option value="">全部</option>
							<form:options items="${fns:getDictList('YW_PS_LY')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
						</form:select>
					</div>

					<input id="searchButton" class="btn btn-primary" type="button" value="查询" />
					<input id="clear" class="btn btn-primary" type="button" value="重置" />
				</div>
			</div>
		</form:form>
		<div id="toolbar">
			<ul class="nav nav-pills">
				<li>
					<a id="addBtn" href="${ctx}/ywgl/instructions/form">
						<i class="icon-plus"></i> &nbsp;新增
					</a>
				</li>
				<li>
					<a id="delBtn" href="javascript:void(0)">
						<i class="icon-copy"></i> &nbsp;删除
					</a>
				</li>
				<li>
					<a id=""  onclick="urge()">
						<i class="icon-edit"></i> &nbsp;催办
					</a>
				</li>
				<li>
					<a id="addRelateBtn" href="javascript:void(0)">
						<i class="icon-edit"></i> &nbsp;关联专报
					</a>
				</li>
				<li>
					<a id="exportExcel" onclick="exportExcel()" >
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