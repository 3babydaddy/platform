<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典类型管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#chname").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="breadcrumb">
	   <li>字典</li>
       <li class="active">字典<shiro:hasPermission name="sys:dictType:edit">${not empty dict.id?'修改':'添加'}</shiro:hasPermission>
    </ul>
	<form:form id="inputForm" modelAttribute="dictType" action="${ctx}/sys/dictType/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">分类:</label>
			<div class="controls">
				<form:input path="parent.chname" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">名称:</label>
			<div class="controls">
				<form:input path="chname" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保存值:</label>
			<div class="controls">
				<form:input path="enname" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
        <div class="control-group">
            <label class="control-label">类型:</label>
            <div class="controls">
                <form:radiobuttons path="type" items="${fns:getDictList('sys_dict_type')}" itemLabel="chname" itemValue="enname" htmlEscape="false" class="required" />
            </div>
        </div>
        <div class="control-group">
			<label class="control-label">排序:</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" maxlength="11" class="required digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:dict:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>