<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#no").focus();
			$("#inputForm").validate({
				rules: {
					loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
				},
				messages: {
					loginName: {remote: "用户登录名已存在"},
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				},
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
		textarea:focus{
			outline:none;
		}
		input:focus{
			outline:none!important;
		}
		select{
			width:220px;
			padding-right:0;
			padding-left:0;
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
	<li><a href="${ctx}/sys/user">用户管理列表</a> </li>
        <li class="active"><span class="divider">/</span>用户<shiro:hasPermission name="sys:user:edit">${not empty user.id?'修改':'添加'}</shiro:hasPermission>
	   <shiro:lacksPermission name="sys:user:edit">查看</shiro:lacksPermission></li>
    </ul><br/>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">所属单位:</label>
			<div class="controls">
                <sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}"
					title="单位" url="/sys/office/treeData"  isAll="true" cssClass="required" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户名:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">登录名:</label>
			<div class="controls">
				<input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
				<form:input path="loginName" htmlEscape="false" maxlength="50" class="required userName"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">密码:</label>
			<div class="controls">
				<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="${empty user.id?'required':''}"/>
				<c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
				<c:if test="${not empty user.id}"><span class="help-inline">若不修改密码，请留空。</span></c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">确认密码:</label>
			<div class="controls">
				<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" class="${empty user.id?'required':''}" equalTo="#newPassword"/>
				<c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否允许登录:</label>
			<div class="controls">
				<form:select path="stateFlag">
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="chname" itemValue="enname" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"> “是”代表此账号允许登录，“否”则表示此账号不允许登录</span>
			</div>
		</div>
		 <%-- <div class="control-group">
			<label class="control-label">用户类型:</label>
			<div class="controls">
				<form:select path="type">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('sys_user_type')}" itemLabel="chname" itemValue="enname" htmlEscape="false"/>
				</form:select>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">用户角色:</label>
			<div class="controls">
				<form:checkboxes path="roleIdList" items="${allRoles}" itemLabel="name" itemValue="id" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
			</div>
		</div>
		<c:if test="${not empty user.id}">
			<div class="control-group">
				<label class="control-label">创建时间:</label>
				<div class="controls">
					<label class="lbl"><fmt:formatDate value="${user.createDate}" type="both" dateStyle="full"/></label>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">最后登陆:</label>
				<div class="controls">
					<label class="lbl">IP: ${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.loginDate}" type="both" dateStyle="full"/></label>
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<shiro:hasPermission name="sys:user:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" style="outline:none;"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)" style="outline:none;"/>
		</div>
	</form:form>
</body>
</html>