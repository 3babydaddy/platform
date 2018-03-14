<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default" />
</head>
<body>
	<div style="padding: 20px;">
		<form:form id="addYearTask" modelAttribute="yearTaskTableData" action="" method="post">
			<div>
				<span style="margin-left:20px;">年度</span>
				<fmt:parseDate value="${taskYear}" var="taskYear" pattern="yyyy"   />
				<input style="width:55px; margin-left:5px;" type="text" name="taskYear" value="<fmt:formatDate value="${taskYear}" pattern="yyyy" />" onfocus="WdatePicker({dateFmt:'yyyy'})" />
				<span >序号</span>
				<form:input style="width:55px; margin-left:5px;" htmlEscape="false" path="sort" />
			</div>
			<div>
				<span>目标任务</span>
				<form:textarea path="targetTask" htmlEscape="false" cssClass="input-xxlarge" style="width:400px;" rows="6" maxlength="300" />
			</div>
			<div>
				<span>牵头单位</span>
				<form:input htmlEscape="false" path=""  />
				<span style="margin-left: 5px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;责任人</span>
				<form:input htmlEscape="false" path="" style="width:80px;" />
			</div>
			<div>
				<span>责任单位</span>
				<form:input htmlEscape="false" path=""    />
				<span>分管区领导</span>
				<form:input htmlEscape="false" path=""  style="width:80px;"  />
			</div>
		</form:form>
	</div>
</body>
</html>