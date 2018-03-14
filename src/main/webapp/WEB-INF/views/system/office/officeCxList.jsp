<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>单位管理</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treetable.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {

	});
	$(function() {
		// 批量更新
		$("#batchUpdateBtn").click(function() {
			loading('请稍等...');
			$("#searchList").attr("action", "${ctx}/sys/office/batchUpdate");
			$("#searchList").submit();
		});
		// 查询
		$("#searchBtn")
				.click(
						function() {
							/* 原有逻辑再次点击查询时IE下会报错
							if ($("#name").val().trim() == ""
								&& $("#gfjc").val().trim() == ""
								&& $("#jgxz").val() == ""
								&& $("#version").val() == ""
								&& $("#stateFlag").val() == "") {

								$("#searchForm").attr("action", "${ctx}/sys/office/cxlist");
							}
							$("#searchForm").submit(); */
							var name = $("#name").val();
							var gfjc = $("#gfjc").val();
							var jgxz = $("#jgxz").val();
							var version = $("#version").val();
							var stateFlag = $("#stateFlag").val();
							window.location.href = "${ctx}/sys/office/cxlist?name="
									+ encodeURIComponent(name)
									+ "&gfjc="
									+ encodeURIComponent(gfjc)
									+ "&jgxz="
									+ jgxz
									+ "&version="
									+ version
									+ "&stateFlag=" + stateFlag;
						});
		// 导出列表
		$("#btnExport")
				.click(
						function() {
							if (confirm('确认要导出数据吗？')) {
								var rows = $("#table").bootstrapTable(
										"getSelections"), ids = [], i = 0;
								if (rows != null && rows.length > 0) {
									for (; i < rows.length; i++) {
										ids.push(rows[i].id);
									}
								}
								var name = $("#name").val();
								var gfjc = $("#gfjc").val();
								var jgxz = $("#jgxz").val();
								var version = $("#version").val();
								var stateFlag = $("#stateFlag").val();
								window.location.href = "${ctx}/sys/office/exportExcel?name="
										+ encodeURIComponent(name)
										+ "&gfjc="
										+ encodeURIComponent(gfjc)
										+ "&jgxz="
										+ jgxz
										+ "&version="
										+ version
										+ "&stateFlag="
										+ stateFlag
										+ "&exportListType=16";
							}
						});
	});
</script>
</head>
<body>
	<ul class="breadcrumb">
		<li class="active">
			<a href="${ctx}/sys/office/">单位列表</a>
		</li>
	</ul>
	<div id="toolbar">
		<ul class="nav nav-pills">

			<div id="importBox" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="importBoxLabel" aria-hidden="true">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
					<form id="importForm" action="${ctx}/sys/office/import" method="post" enctype="multipart/form-data" class="form-search" style="padding-left: 20px; text-align: center;"
						onsubmit="loading('正在导入，请稍等...');">
						<br />
						<input id="uploadFile" name="file" type="file" style="width: 330px" />
						<br />
						<br />
						<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   " />
						<a href="${ctx}/sys/office/import/template">下载模板</a>
					</form>
				</div>
			</div>
			</li>
		</ul>
	</div>
	<div id="searchbar" class="form-search breadcrumb">
		<form:form id="searchForm" modelAttribute="office" method="post" style="margin:0px;">
			<form:hidden path="id" value="" />
			<form:hidden path="sort" value="" />
			<div class="input-prepend">
				<span class="add-on">单位名称</span>
				<form:input path="name" htmlEscape="false" maxlength="50" />
			</div>
			<input id="searchBtn" class="btn btn-primary" type="button" value="查询" />
			<input onclick="javascript:window.location.href='${ctx}/sys/office'"  class="btn btn-primary" type="button" value="返回" />
	</div>
	<sys:message content="${message}" />
	</form:form>
	<table id="table"></table>
	<table id="treeTable" class="table table-striped table-bordered table-condensed"  style="width:60%">
		<thead>
			<tr>
				<th style="text-align: center;">单位名称</th>
				<th style="text-align: center;">排序</th>
				<th style="text-align: center;">操作</th>
			</tr>
		</thead>
		<tbody>
			<form:form id="searchList" modelAttribute="office" method="post" style="margin:0px;">
				<c:forEach items="${list}" var="entity">
					<tr id="${entity.id}">
						<td><a href="#">${entity.name}</a> <input type="hidden" name="id" value="${entity.id}" /></td>
						<td style="text-align: center;"><input name="sort" type="text" value="${entity.sort}" maxlength="10" style="width: 85px; margin: 0; padding: 0; text-align: center;">
						</td>
						<td><a href="${ctx}/sys/office/form?id=${entity.id}">修改</a>
						 <a href="${ctx}/sys/office/delete?id={{row.id}}">删除</a> 
						  <a href="${ctx}/sys/office/form?parent.id=${entity.id}">添加下级单位</a></td>
					</tr>
				</c:forEach>
			</form:form>
		</tbody>
	</table>
</body>
</html>