<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单位管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
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
			$("textarea").attr("onkeyup","return isMaxLen(this)");
		});
		//在IE8下对textarea的字数长度限制的函数
		function isMaxLen(o){
			var nMaxLen=o.getAttribute ? parseInt(o.getAttribute("maxlength")) : "";  
			if(o.getAttribute && o.value.length>nMaxLen){  
				o.value=o.value.substring(0,nMaxLen)  
			}
		}
	</script>
	<style type="text/css">
		select{
			width:220px;
			padding-right:0;
			padding-left:0;
		}
		textarea:focus{
			outline:none;
		}
		input:focus{
			outline:none!important;
		}
		select:focus{
			outline:none;
		}
		.form-actions{
			border-top:none;
			margin-top:0;
		}
	</style>
</head>
<body>
	<ul class="breadcrumb">
		<li><a href="${ctx}/sys/office/list?id=${office.parent.id}&parentIds=${office.parentIds}">单位列表</a></li>
		<li><span class="divider">/</span></li>
		<li class="active"><a href="${ctx}/sys/office/form?id=${office.id}&parent.id=${office.parent.id}">单位<shiro:hasPermission name="sys:office:edit">${not empty office.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:office:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="office" action="${ctx}/sys/office/save" method="post" class="form-horizontal">
	
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级单位:</label>
			<div class="controls">
                <sys:treeselect id="office" name="parent.id" value="${office.parent.id}" labelName="parent.name" labelValue="${office.parent.name}"
					title="单位" url="/sys/office/treeData" isAll="true" extId="${office.id}" cssClass="" allowClear="true"/>
			</div>
		</div>
		 <div class="control-group">
			<label class="control-label">单位名称:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序:</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" maxlength="50" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<%--
		<div class="control-group">
			<label class="control-label">单位性质:</label>
			<div class="controls">
				<form:select path="jgxz">
					<form:options items="${fns:getDictList('YW_JGXZ')}" itemLabel="chname" itemValue="enname" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
        <div class="control-group">
            <label class="control-label">规范简称:</label>
            <div class="controls">
                <form:input path="gfjc" htmlEscape="false" maxlength="50" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">组织人事部门:</label>
            <div class="controls">
                <form:input path="zzrsbm" htmlEscape="false" maxlength="50" />
            </div>
        </div>
        <div class="control-group">
			<label class="control-label">使用版本:</label>
			<div class="controls">
				<form:select path="version">
					<form:options items="${fns:getDictList('DWYH_VERSION')}" itemLabel="chname" itemValue="enname" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
        <div class="control-group">
			<label class="control-label">是否可用:</label>
			<div class="controls">
				<form:select path="stateFlag">
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="chname" itemValue="enname" htmlEscape="false"/>
				</form:select>
				<span class="help-inline">“是”代表此账号允许登陆，“否”则表示此账号不允许登陆</span>
			</div>
		</div>
		 --%>
		<div class="control-group">
			<label class="control-label">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:office:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" style="outline:none;"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)" style="outline:none;"/>
		</div>
	</form:form>
</body>
</html>