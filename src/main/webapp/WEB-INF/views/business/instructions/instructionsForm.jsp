<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>批示件编辑</title>
<meta name="decorator" content="default" />
<style type="text/css">
.benjieCon {
	border: 2px solid #e9ecf1;
	width: 70%;
	padding-left: 10px;
	padding-top: 10px;
	padding-bottom: 10px;
	margin-left: 11px;
	margin-bottom: 11px;
	float: left;
}

#down {
	width: 0;
	height: 0;
	border: 15px solid transparent;
	border-top-color: red;
	/*position: relative;*/
}

#indown {
	width: 0;
	height: 0;
	border: 40px solid transparent;
	border-top-color: white;
	/* position: absolute;*/
	margin-top: -45px;
	margin-left: -40px;
}

#up {
	width: 0;
	height: 0;
	border: 15px solid transparent;
	border-bottom: 15px solid red;
	margin-bottom: 80px;
	margin-top: 150px
}

#inup {
	width: 0;
	height: 0;
	border: 20px solid transparent;
	border-bottom-color: white;
	/* position: absolute;*/
	margin-top: -15px;
	margin-left: -20px;
}

.clearfix:after {
	content: "";
	display: table;
	height: 0;
	visibility: both;
	clear: both;
}

.clearfix {
	*zoom: 1; /* IE/7/6*/
}
</style>

<script type="text/javascript" src="${ctxStatic}/jquery-form/ajaxfileupload.js?version=3.2.6"></script>
<script type="text/javascript" src="${ctxStatic}/common/tableFormValidation.js"></script>
<script type="text/javascript">
	$(function() {

		function changeColor() {
			$(this).parents('.benjieCon').css("border", "2px solid red");
		}

		//内容变化恢复颜色
		$('input,textarea').on('change ', function(e) {
			$(this).parents('.benjieCon').css("border", "2px solid red");
		});
		//添加
		$("#addLeaderBtn").click(function() { // 按钮的id\
			var newDiv = $("#hideLeaderDiv").clone(true);
			newDiv.show();
			$(this).parent().before(newDiv);
			//排序

		});
		$("#addOfficeBtn").click(function() { // 按钮的id
			var newDiv = $("#hideOfficeDiv").clone(true);
			newDiv.show();
			$(this).parent().before(newDiv);
			//排序

		});
		$("#delOfficeDivBtn").click(function() { // del为删除input的id
			$(this).parent().parent().remove();

		});
		//删除
		$("#delLeaderDivBtn").click(function() { // del为删除input的id
			$(this).parent().parent().remove();

		});
		//返回
		function back() {
			location.href = "${ctx}/ywgl/instructions/list";
		}
		// 保存
		$("#saveBtn").click(function() {

			var a = $("input[name='in0001']").val();
			var b = $("input[name='in0002']").val();
			if ($("input[name='in0001']").val() == "") {
				alertx("请输入文件名！");
				$("input[name='in0001']").focus();
				return;
			}
			if ($("input[name='in0002']").val() == "") {
				alertx("请输入文件号！");
				$("input[name='in0002']").focus();
				return;
			}
			confirmx("您确认信息已填写完毕?", function() {
				$.ajax({
					type : "post",
					data : $("#inputForm").serialize(),
					url : "${ctx}/ywgl/instructions/save",
					cache : false,
					success : function(res) {
						window.location.href = '${ctx}/ywgl/instructions/index'
						alertx("保存成功！");
					},
					error : function(res) {
						alertx("保存失败！");
					}
				});
			});

		});
	})
</script>
</head>
<body>

	<div id="toolbar">
		<ul class="nav nav-pills">
			<li>
				<a id="saveBtn" href="#">
					<i class="icon-save"></i>&nbsp;保存
				</a>
			</li>
			<li>
				<a id="add" href="javascript:history.back(-1)">
					<i class="icon-reply"></i>&nbsp;返回
				</a>
			</li>
		</ul>
	</div>



	<!-- 表单 -->
	<div>
		<form:form id="inputForm" modelAttribute="entity" action="${ctx}/ywgl/instructions/save" method="post" class="form-horizontal">
			<form:hidden path="id" />
			<sys:message content="${message}" />
			<div class="control-group">
				<label class="control-label">标记</label>
				<div class="controls">
					<form:checkboxes  path="in0019List" items="${fns:getDictList('YW_PS_BJ')}" itemLabel="chname" itemValue="enname" htmlEscape="false" delimiter="&nbsp;" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">文件类型</label>
				<div class="controls">
					<form:radiobuttons path="in0016" items="${fns:getDictList('YW_PS_WJLX')}" itemLabel="chname" itemValue="enname" htmlEscape="false" delimiter="&nbsp;" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">来源</label>
				<div class="controls">
					<form:radiobuttons path="in0017" items="${fns:getDictList('YW_PS_LY')}" itemLabel="chname" itemValue="enname" htmlEscape="false" delimiter="&nbsp;" />
				</div>
			</div>
			<div class="control-group ">
				<label class="control-label">文件名</label>
				<div class="controls">
					<form:input path="in0001" htmlEscape="false" maxlength="300" cssClass='input-xxlarge'/>
				</div>
			</div>
			<div class="control-group ">
				<label class="control-label">文件号</label>
				<div class="controls">
					<form:input path="in0002" htmlEscape="false" maxlength="300" cssClass='input-xxlarge'/>
				</div>
			</div>
			<div class="control-group ">
				<label class="control-label">上传批示文件</label>
				<div class="controls">
					<sys:upFIle input="in0021" type="files" text="上传文件" name="in0021" value="${entity.in0021}" uploadPath="/file" selectMultiple="false" maxWidth="100"
						maxHeight="100" />
				</div>
			</div>
			<div class="control-group ">
				<label class="control-label">批示内容</label>
				<div class="controls">
					<form:textarea path="in0003" htmlEscape="false" cssClass="input-xxlarge" rows="6" maxlength="300" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">批示日期</label>
				<div class="controls">
					<input type="text" style="width: 100px" name="in0004" value="<fmt:formatDate value="${entity.in0004}" pattern="yyyy-MM-dd" />" onfocus="WdatePicker()" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">收件日期</label>
				<div class="controls">
					<input type="text" style="width: 100px" name="in0005" value="<fmt:formatDate value="${entity.in0005}" pattern="yyyy-MM-dd" />" onfocus="WdatePicker()" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">按轻重分类</label>
				<div class="controls">
					<form:select path="in0006">
						<option value=""></option>
						<form:options items="${fns:getDictList('YW_PS_FL_QZ')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
					</form:select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">按要求分类</label>
				<div class="controls">
					<form:select path="in0007">
						<option value=""></option>
						<form:options items="${fns:getDictList('YW_PS_FL_YQ')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
					</form:select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">按内容分类</label>
				<div class="controls">
					<form:select path="in0008">
						<option value=""></option>
						<form:options items="${fns:getDictList('YW_PS_FL_NR')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
					</form:select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">备注</label>
				<div class="controls">
						<form:textarea path="in0018" htmlEscape="false" cssClass="input-xxlarge" rows="6" maxlength="300" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" id="divLeaderLabl">责任领导</label>
				<div class="controls">
					<sys:InstructionsTag id="leaderElementList" type="1" value="${entity.leaderElementList}" leftText2="办理情况" leftText3="上传附件" rightText1="催办日期" rightText2="是否超期" isShowRightText1="true" isShowRightText2="true" name="leaderElementList"  title="领导"
                                        url="/sys/leader/leaderTree?type=01" isAll="true" checked="true"  allowInput="true" notAllowSelectParent="true" input="meeting${fns:getUuId()}" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" id="divOfficeLabl">承办单位</label>
				<div class="controls">
					<sys:InstructionsTag id="officeElementList"  type="2" value="${entity.officeElementList}" leftText2="办理情况" leftText3="上传附件" rightText1="催办日期"  rightText2="是否超期" isShowRightText1="true" isShowRightText2="true" name="officeElementList"  title="单位"
                                        url="/sys/office/treeData" checked="true"  allowInput="true" notAllowSelectParent="true" input="meeting${fns:getUuId()}" />
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