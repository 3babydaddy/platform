<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>上级督查</title>
<meta name="decorator" content="default" />
<script type="text/javascript" src="${ctxStatic}/jquery-form/ajaxfileupload.js"></script>
<style type="text/css">
.benjieCon {
	display: inline-block;
	border: 2px solid #e9ecf1;
	width: 70%;
	padding-left: 10px;
	padding-top: 10px;
	padding-bottom: 10px;
	margin-left: 11px;
	margin-bottom: 11px;
	align: center;
	overflow: auto;
}

.input1 {
	margin-bottom: 0px;
	margin-left: 80px;
	margin-right: 10px;
	width: 10%;
}
</style>

<script language="javascript">
	$(
			function() {
				//督查类型单选
				$('input[type=radio][name=inspectType]').change(
						function() {
							if (this.value == '01') {
								//显示全部
								$(".specialStyle").css("display", "");
								/* delInputFile('blendFile');
								delOfficeTreeFile('blendOfficeTreeFile');
								delInputMultiFile('blendMulFile'); */
							}
							if (this.value == '02') {
								//分管区领导,对接协调单位,落实显示
								$('.specialStyle').find('input[name]').each(
										function() {
											$(this).val("");
										});
								$('.specialStyle input[name]').each(
										function() {
											$(this).val("");
										});
								$('.specialStyle').find('select[name]').each(
										function() {
											$(this).val("");
										});
								$('.specialStyle').find('textarea[name]').each(
										function() {
											$(this).val("");
										});
								
								$(".specialStyle").css("display", "none");
							}
						});
				// 保存
				$("#saveBtn")
						.click(
								function() {
									if ($("textarea[name='inspectMatter']")
											.val() == "") {
										alertx("请输入督查事项！");
										$("textarea[name='inspectMatter']")
												.focus();
										return;
									}
									if ($("input[name='inspectTimeStart']")
											.val() == "") {
										alertx("请输入督查时间！");
										$("input[name='inspectTimeStart']")
												.focus();
										return;
									}
									confirmx(
											"您确认信息已填写完毕?",
											function() {
												$
														.ajax({
															type : "post",
															data : $(
																	"#inputForm")
																	.serialize(),
															url : "${ctx}/ywgl/superiorInspect/save",
															cache : false,
															success : function(
																	res) {

																window.location.href = '${ctx}/ywgl/superiorInspect/index'
																alertx("保存成功！");
															},
															error : function(
																	res) {
																alertx("保存失败！");
															}
														});
											});

								});
				//根据督查类型显示
				if ("${superiorInspect.inspectType}" == "02") {

					$(".specialStyle").css("display", "none");
				}

			})
</script>
</head>
<body>
	<div id="toolbar">
		<ul class="nav nav-pills">
			<li>
				<a id="saveBtn" href="#">
					<i class="icon-save"></i> 保存
				</a>
			</li>
			<li>
				<a href="javascript:history.back(-1)">
					<i class="icon-reply"></i> 返回
				</a>
			</li>
		</ul>
	</div>

	<div>
		<form:form id="inputForm" modelAttribute="superiorInspect" action="${ctx}/ywgl/superiorInspect/save" method="post" class="form-horizontal">
			<form:hidden path="id" />
			<sys:message content="${message}" />
			<div class="control-group">
				<label class="control-label">上级单位</label>
				<div class="controls">
					<form:select path="parentOfficeIds">
						<option value=""></option>
						<form:options items="${fns:getDictList('YW_SJDW')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
					</form:select>
				</div>
			</div>
			<div class="control-group ">
				<label class="control-label">上传督查依据</label>
				<div class="controls">
					<sys:upFIle input="inspectFile" type="files" text="上传文件" name="inspectFile" value="${superiorInspect.inspectFile}" uploadPath="/file" selectMultiple="false" maxWidth="100"
						maxHeight="100" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">督查时间</label>
				<div class="controls">
					<input type="text" style="width: 100px" name="inspectTimeStart" value="<fmt:formatDate value="${superiorInspect.inspectTimeStart}" pattern="yyyy-MM-dd" />"
						onfocus="WdatePicker()" />
					<label>至</label>
					<input type="text" style="width: 100px" name="inspectTimeEnd" value="<fmt:formatDate value="${superiorInspect.inspectTimeEnd}" pattern="yyyy-MM-dd" />" onfocus="WdatePicker()" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">督查事项</label>
				<div class="controls">
					<form:textarea path="inspectMatter" htmlEscape="false" cssClass="input-xxlarge" rows="6" maxlength="300" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">督查类型</label>
				<div class="controls">
					<form:radiobuttons path="inspectType" items="${fns:getDictList('YW_DCLX')}" itemLabel="chname" itemValue="enname" htmlEscape="false" delimiter="&nbsp;" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">分管区领导</label>
				<div class="controls">
					<sys:treeselect cssStyle="width:540px" id="chargeOfficeIds" name="chargeOfficeIds" value="${superiorInspect.chargeOfficeIds}" labelName="s0003"
						labelValue="${superiorInspect.s0003}" title="分管区领导" url="/sys/leader/leaderTree?type=01" cssClass="required" checked="true" allowClear="true" notAllowSelectParent="true" />
				</div>
			</div>

			<div class="control-group">
				<label class="control-label">对接协调单位</label>
				<div class="controls">
					<sys:treeselect cssStyle="width:540px" id="cohereOfficeIds" name="cohereOfficeIds" value="${superiorInspect.cohereOfficeIds}" labelName="s0004"
						labelValue="${superiorInspect.s0004}" title="单位" url="/sys/office/treeData" cssClass="required" checked="true" allowClear="true" notAllowSelectParent="true" />
				</div>
			</div>
			<div class="control-group specialStyle">
				<label class="control-label">上传通知</label>
				<div class="controls">
					<sys:upFIle input="blendFile" type="files" text="上传文件" name="s0001" value="${superiorInspect.s0001}" uploadPath="/file" selectMultiple="false" maxWidth="100" maxHeight="100" />
				</div>
			</div>
			<div class="control-group specialStyle">
				<label class="control-label">完成时限</label>
				<div class="controls">
					<input type="text" style="margin-bottom: 0px; margin-left: 10px; width: 20%" name="finishTimeLimit"
						value="<fmt:formatDate value="${superiorInspect.finishTimeLimit}" pattern="yyyy-MM-dd HH:mm:ss" />"
						onfocus="WdatePicker({startDate:'%y-%M-01 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})" />
				</div>
			</div>
			<div class="control-group specialStyle">
				<label class="control-label">承办单位</label>
				<div class="controls">
					<sys:officeTreeFileTime id="dutyOfficeList" leftText2="上传专函" leftText3="上传自查报告" isShowEndTime="none" name="dutyOfficeList" value="${superiorInspect.dutyOfficeList}" title="单位"
						url="/sys/office/treeData" checked="true" notAllowSelectParent="true" input="blendOfficeTreeFile" />

				</div>
			</div>
			<div class="control-group specialStyle ">
				<label class="control-label">上传方案</label>
				<div class="controls">
					<sys:upFIle input="blendFile" type="files" text="上传文件" name="planOpinionFile" value="${superiorInspect.planOpinionFile}" uploadPath="/file" selectMultiple="false"
						maxWidth="100" maxHeight="100" />
				</div>
			</div>
			<div class="control-group specialStyle ">
				<label class="control-label">上传汇报材料</label>
				<div class="controls">
					<sys:upFIleMul input="blendMulFile" type="files" text="上传文件" name="tripPlanFile" value="${superiorInspect.tripPlanFile}" uploadPath="/file" selectMultiple="false"
						maxWidth="100" maxHeight="100" />
				</div>
			</div>
			<div class="control-group specialStyle ">
				<label class="control-label">上传点位介绍</label>
				<div class="controls">
					<sys:upFIleMul input="blendMulFile" type="files" text="上传文件" name="receiveSchemeFile" value="${superiorInspect.receiveSchemeFile}" uploadPath="/file"
						selectMultiple="false" maxWidth="100" maxHeight="100" />
				</div>
			</div>
			<div class="control-group specialStyle">
				<label class="control-label">督查要求简述</label>
				<div class="controls">
					<form:textarea path="checkContent" htmlEscape="false" cssClass="input-xxlarge" rows="6" maxlength="300" />
				</div>
			</div>
			<div class="control-group specialStyle ">
				<label class="control-label">上传督查要求</label>
				<div class="controls">
					<sys:upFIle input="blendFile" type="files" text="上传文件" name="checkContentFile" value="${superiorInspect.checkContentFile}" uploadPath="/file" selectMultiple="false"
						maxWidth="100" maxHeight="100" />
				</div>
			</div>
			<div class="control-group ">
				<label class="control-label">落实情况简述</label>
				<div class="controls">
					<form:textarea path="resultSituation" htmlEscape="false" cssClass="input-xxlarge" rows="6" maxlength="300" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">上传落实情况</label>
				<div class="controls">
					<sys:upFIle input="resultSituationFile" type="files" text="上传文件" name="resultSituationFile" value="${superiorInspect.resultSituationFile}" uploadPath="/file"
						selectMultiple="false" maxWidth="100" maxHeight="100" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">状态</label>
				<div class="controls">
					<form:radiobuttons path="taskState" items="${fns:getDictList('YW_DCLSQK')}" itemLabel="chname" itemValue="enname" htmlEscape="false" delimiter="&nbsp;" />
				</div>
			</div>
			<div>
				<label class="control-label">落实时间</label>
				<div class="controls">
					<input type="text" style="width: 100px" name="s0002" value="<fmt:formatDate value="${superiorInspect.s0002}" pattern="yyyy-MM-dd" />" onfocus="WdatePicker()" />
				</div>
			</div>
			<div>
				<label class="control-label">&nbsp;&nbsp;</label>
				<div class="controls">&nbsp;&nbsp;</div>
			</div>
		</form:form>
	</div>

</body>
</html>