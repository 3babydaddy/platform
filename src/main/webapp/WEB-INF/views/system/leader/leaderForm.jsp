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
		<li><a href="${ctx}/sys/leader/list?id=${leader.parent.id}&parentIds=${leader.parentIds}">领导信息列表</a></li>
		<li><span class="divider">/</span></li>
		<li class="active"><a href="${ctx}/sys/leader/form?id=${leader.id}&parent.id=${leader.parent.id}">领导信息<shiro:hasPermission name="sys:leader:edit">${not empty leader.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:leader:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="leader" action="${ctx}/sys/leader/save" method="post" class="form-horizontal">
	
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">所属部门:</label>
			<div class="controls">
                <sys:treeselect id="leader" name="parent.id" value="${leader.parent.id}" labelName="parent.l001" labelValue="${leader.parent.l001}"
					title="单位" url="/sys/leader/leaderTree?type=00"  extId="${leader.id}" cssClass="" allowClear="true"/>
			</div>
		</div>
		 <div class="control-group">
			<label class="control-label">姓名:</label>
			<div class="controls">
				<form:input path="l001" htmlEscape="false" maxlength="50" class="required"/>
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
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" style="outline:none;"/>
			<input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)" style="outline:none;"/>
		</div>
	</form:form>
</body>
</html>