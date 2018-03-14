<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">	
	//将页面中所有input标签设为只读
	$(function() {
		$("input").attr({ readonly: 'true' });
	})
	</script>
</head>
<body>
	<ul class="breadcrumb">
	<li><a href="${ctx}/sys/log">日志列表</a> <span class="divider">/</span></li>
        <li class="active">日志<shiro:hasPermission name="sys:log:edit">查看</shiro:hasPermission>
    </ul>
	<form:form id="inputForm" modelAttribute="log" action="${ctx}/sys/log/form" method="post" class="form-horizontal" >
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">操作菜单:</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="50" class="required"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">登录名:</label>
			<div class="controls">
				<form:input path="createBy.loginName" htmlEscape="false" maxlength="50" class="required"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">所在单位:</label>
			<div class="controls">
				<form:input path="createBy.office.name" htmlEscape="false" maxlength="50" class="required abc"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">操作路径:</label>
			<div class="controls">
				<form:input path="requestUri" htmlEscape="false" maxlength="50" class="required"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">提交方式:</label>
			<div class="controls">
				<form:input path="method" htmlEscape="false" maxlength="11" class="required digits"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">操作内容:</label>
			<div class="controls">
				<form:input path="detail" htmlEscape="false" maxlength="11" class="required digits"  />
			</div>
		</div><div class="control-group">
			<label class="control-label">操作者IP:</label>
			<div class="controls">
				<form:input path="ip" htmlEscape="false" maxlength="11" class="required digits"  />
			</div>
		</div><div class="control-group">
			<label class="control-label">操作时间:</label>
			<div class="controls">
				<fmt:formatDate value="${log.createDate}" type="both" dateStyle="full"  />
			</div>
		</div><div class="control-group">
			<label class="control-label">参数:</label>
			<div class="controls">
				<form:input path="params" htmlEscape="false" maxlength="11" class="required digits"  />
			</div>
		</div><div class="control-group">
			<label class="control-label">异常:</label>
			<div class="controls">
				<form:input path="exception" htmlEscape="false" maxlength="11" class="required digits"  />
			</div>
		</div>
		
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>