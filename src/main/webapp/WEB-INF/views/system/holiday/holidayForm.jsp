<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>节假日管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
	        $("#baocun").click(function() {
	        	var beginDate = $("input[name='beginDate']").val();
				var endDate = $("input[name='endDate']").val();
	        	if(endDate<beginDate){
		   		    alert("放假结束时间不能早于放假开始时间！");			 
		   			$("input[name='endDate']").focus();
		   			return;
		   		}
	            $("#inputForm").submit();
	        });
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
		});
	</script>
</head>
<body>
    <ul class="breadcrumb">
        <li><a href="${ctx}/system/holiday/">节假日列表</a></li>
        <li><span class="divider">/</span></li>
        <li class="active">${not empty holiday.id?'修改':'新增'}</li>
    </ul>
    <div id="toolbar">
        <ul class="nav nav-pills">
            <li><a id="baocun" href="javascript:void(0)"><i class="icon-save"></i>&nbsp;保存</a></li>
        <li><a href="javascript:history.go(-1)"><i class="icon-arrow-left"></i>&nbsp;返回</a></li>
        </ul>
    </div>
	<form:form id="inputForm" modelAttribute="holiday" action="${ctx}/system/holiday/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">节假日名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50" class="input-xlarge" 
				cssClass="required"
                    allowClear="true"
                    dataMsgRequired="必填信息"
                    notAllowSelectParent="false" style="text-align:center;"/>
                    <span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">年度：</label>
			<div class="controls">
			    <input name="year" type="text" maxlength="20" class="input-mini juzhong required" value="${holiday.year}"
			        cssClass="required"
                    allowClear="true"
                    dataMsgRequired="必填信息"
                    notAllowSelectParent="false"
                    onfocus="WdatePicker({dateFmt:'yyyy',autoUpdateOnChanged:true});"/>
                    <span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">放假时间：</label>
			<div class="controls">
                <input name="beginDate" type="text" maxlength="20" class="input-mini juzhong required"
                    value="<fmt:formatDate value="${holiday.beginDate}" pattern="yyyy-MM-dd"/>"
                    onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',autoUpdateOnChanged:true});"/>
                <span class="divider">至</span>
                <input name="endDate" type="text" maxlength="20" class="input-mini juzhong required"
                    value="<fmt:formatDate value="${holiday.endDate}" pattern="yyyy-MM-dd"/>"
                    onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',autoUpdateOnChanged:true});"/>
                    <span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">调休上班时间：</label>
			<div class="controls">
				<input name="exchangeDate1" type="text" maxlength="20" class="input-mini juzhong"
					value="<fmt:formatDate value="${holiday.exchangeDate1}" pattern="yyyy-MM-dd"/>"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',autoUpdateOnChanged:true});"/>
				<span class="divider">、</span>
                <input name="exchangeDate2" type="text" maxlength="20" class="input-mini juzhong"
                    value="<fmt:formatDate value="${holiday.exchangeDate2}" pattern="yyyy-MM-dd"/>"
                    onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',autoUpdateOnChanged:true});"/>
			</div>
		</div>
	</form:form>
</body>
</html>