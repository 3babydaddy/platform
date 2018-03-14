<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>关联批示</title>
<meta name="decorator" content="default" />
<style type="text/css">
.style_input_width_small {
	width: 100px;
}
</style>
<script type="text/javascript">
	$(function() {
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
		$("#clear").click(function() {

			var a = $('#searchForm').find('input[name]');
			$('#searchForm').find('input[name]').each(function() {
				$(this).val("");
				$('#table').bootstrapTable('refresh');
			});
		});
		$('#table')
				.tfkjTable(
						{
							url : '${ctx}/ywgl/instructions/noPagelist',
							queryParams : 'queryParams',
							pagination : false,//分页
							columns : [
									[
											{
												field : 'state',
												checkbox : true,
												align : 'center',
												valign : 'middle',
												width : 35
											},
											{
												field : 'num',
												title : '序号',//标题  可不加
												width : 40,
												formatter: function (value, row, index) {
							                        return index+1;
							                    }
											},
											{
												field : 'id',
												visible : false
											},
											{
												field : 'in0004',
												title : "年度",
												valign : "middle",
												align : "center",
												formatter : function(value, row) {
													if (value == null) {
														value = "-";
													}else{
														var d = new Date(value);
														value=d.getFullYear();
													}

													return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
															+ value
															+ "</nobr></div>";
												}

											},
											{
												field : 'in0001',
												title : "文件名",
												valign : "middle",
												align : "center",
												width : 100,
												formatter : function(value, row) {
		                                            var strB = "";

		                                            if (row.in0019 == ''
		                                                    || row.in0019 == null) {
		                                                strB = "<a href='${ctx}/ywgl/instructions/form?id="
		                                                        + row.dataId + "' >"
		                                                        + value + "</a>"
		                                            }
		                                            if (row.in0019 == '01') {
		                                                strB =  ""
		                                                        + "<a  href='${ctx}/ywgl/instructions/form?id="
		                                                        + row.dataId + "' >"
		                                                        +"<i class='icon-exclamation-sign' title='重点关注'></i>"
		                                                        + value + " </a>"
		                                            }
		                                            if (row.in0019 == '02') {
		                                                strB = ""
		                                                        + "<a href='${ctx}/ywgl/instructions/form?id="
		                                                        + row.dataId + "' >"
		                                                        +"<i class='icon-star' title='报送领导'></i>"
		                                                        + value + "</a>"
		                                            }
		                                            if (row.in0019 == '01,02') {
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
												field : 'in0002',
												title : "文件号",
												valign : "middle",
												align : "center",
												formatter : function(value, row) {
													if (value == null) {
														value = "-";
													}
													return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
															+ value
															+ "</nobr></div>";
												}

											}, {
												field : 'in0003',
												title : "批示内容",
												valign : "middle",
												align : "center",
												colspan : 1,
												formatter : function(value, row) {
		                                            if (value == null) {
		                                                value = "-";
		                                            }
		                                            return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
		                                                    + value + "</nobr></div>";
		                                        }

											}, ],

							],
							onClickRow : function(row, $element, field) {
								$('#table').bootstrapTable('uncheckAll');
								$('#table').bootstrapTable('check',
										$element[0].rowIndex - 1);
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
	function select() {
		var rows = $("#table").bootstrapTable("getSelections"), ids = "", i = 0;
		var relationTask = self.parent.$("#relationTask").val();
		var relationTaskArray = self.parent.$("#relationTaskArray").val();
		var array = relationTask.split(",");
		if (rows.length > 0) {
			if (rows != null && rows.length > 0) {
				for (; i < rows.length; i++) {
					var flag = true;
					if (array.length > 0) {
						for (var j = 0; j < array.length; j++) {
							if (rows[i].id == array[j]) {
								flag = false;
							}
						}
					}
					if (flag) {
						var mydate = new Date();
						var uuid = "cms" + mydate.getDay() + mydate.getHours()
								+ mydate.getMinutes() + mydate.getSeconds()
								+ mydate.getMilliseconds()
								+ Math.round(Math.random() * 10000)
						var newRow = '<tr id="option'+uuid+'"><td class="oz-property" ><a  style="cursor: pointer;"  onclick=findTask("'
								+ rows[i].id
								+ '")>'
								+ rows[i].in0001
								+ '</a></td><td><a class="qtupload" onclick=delRow("'
								+ uuid
								+ '","'
								+ rows[i].id
								+ '")>删除</a></td></tr>';
						self.parent.$("#tableTask").append(newRow);
						ids += rows[i].id;

						if (i != rows.length - 1) {
							ids += ",";
						}
						relationTaskArray += newRow;
					}

					//                    source.push(rows[i].source);
				}
			}
			//            if (source){
			//                self.parent.$("#source").val(unescape(source));
			//            }

			self.parent.$("#relationTaskArray").val(relationTaskArray);
			self.parent.$("#isRelation").val("1");
			if (relationTask != '') {
				if (ids != '') {
					relationTask += "," + ids;
				}
				self.parent.$("#relationTask").val(relationTask);
			} else {
				self.parent.$("#relationTask").val(ids);
			}

			self.parent.$.jBox.close();
			self.parent.$.jBox.location.reload();
		} else {
			alertx("请选择要关联的任务！");
		}
	}
</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="query" action="${ctx}/instructions/relationlist" method="post" style="margin:0px;">
		<div class="controls controls-row">
			<input type="hidden" id="id" name="id" value="${id}">
			<div class="search-div input-prepend input-append">
				<span class="add-on">年度</span>
				<fmt:parseDate value="${taskYear}" var="taskYear" pattern="yyyy" />
				<input style="width: 100px;" class="input1" type="text" id="taskYear" name="taskYear" value="<fmt:formatDate value="${taskYear}" pattern="yyyy" />"
					onfocus="WdatePicker({dateFmt:'yyyy'})" />
			</div>
			<div class="search-div input-prepend input-append">
				<span class="add-on">文件名</span>
				<input id="in0001" name="in0001" class="input-large style_input_width_small" type="text" />

				</select>
			</div>
			<div class="search-div input-prepend input-append">
				<span class="add-on">文件号</span>
				<input id="in0002" name="in0002" class="input-large style_input_width_small" type="text" />

				</select>
			</div>
			<div class="search-div input-prepend input-append">
				<span class="add-on" style="width: 100px">批示内容</span>
				<input id="in0003" name="in0003" class="input-large style_input_width_small" type="text" />
			</div>
		<input id="search" class="btn btn-primary" type="button" value="查询" />
		</div>
		<%--<input id="clear" class="btn btn-primary" type="button" value="重置" />--%>
	</form:form>
	<div id="toolbar">
		<ul class="nav nav-pills">
			<li>
				<a onclick="select()">
					<i class="icon-plus"></i> &nbsp;添加关联
				</a>
			</li>

		</ul>
	</div>
	<div id="content" style="overflow: hidden; overflow-x: hidden; overflow-y: auto;">
		<table id="table"></table>
	</div>
</body>
</html>
