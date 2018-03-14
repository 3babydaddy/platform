<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>年度重点任务督查</title>
<meta name="decorator" content="default" />
<style type="text/css">
.benjieCon {
	display: inline-block;
	border: 4px solid red;
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
				//还原边框颜色
				function recoveryColour(id) {
					$(id).parent().parent().css("border", "4px solid red");
				}
				//上移
				function topMove(id) {

					//当前元素
					var a = $(id).parent().parent().parent();
					//当前元素的前一个元素

					var b = $(id).parent().parent().parent().prev();
					var c = b.attr("class");
					if (c.indexOf('moveLimit') >= 0) {
						return;
					}
					a.insertBefore(b);
				}
				//下移
				function lowMove(id) {

					//当前元素
					var a = $(id).parent().parent().parent();
					//当前元素的后一个元素
					var b = $(id).parent().parent().parent().next();
					var c = b.attr("class");
					if (c.indexOf('moveLimit') >= 0) {
						return;
					}
					a.insertAfter(b);
				}
				//排序
				function updateDivSort(className) {
					var sort = 0;
					$(className).each(function() {
						sort++;
						$(this).find('input').last().val(sort);
					});
				}

				//div 默认排序
				updateDivSort('.benjieCon');
				//内容变化恢复颜色
				$('input,textarea,:radio,:checkbox').on(
						'input propertychange',
						function(e) {
							$(this).parents('.benjieCon').css("border",
									"4px solid red");
						});

				// 父级保存
				$("#saveParentBtn").click(function() {
					var test = confirm("您确认信息已填写完毕?");
					if (test) {
						/* loading('正在保存，请稍等...'); */
						$.ajax({
							type : "POST",
							url : "${ctx}/ywgl/yearTask/saveParent",
							data : $(this).closest("form").serialize(),// 要提交的表单 
							success : function() {
								$("#saveParentBtn").parent().parent().parent().css("border","4px solid #009F00");
							}
						});
					}
				});
				// 子级保存
				$(".saveChildBtn").click(function() {
					var div= $(this).closest("form").parent();
					var test = confirm("您确认信息已填写完毕?");
					if (test) {
						$.ajax({
							type : "POST",
							url : "${ctx}/ywgl/yearTask/saveChild",
							data : $(this).closest("form").serialize(),// 要提交的表单 
							success : function() {
								div.css("border","4px solid #009F00");
							}
						});
					}
				});

				// 上移
				$(".upChildBtn").click(function() {
					topMove(this);
					updateDivSort('.benjieCon');
				});
				// 下移
				$(".downChildBtn").click(function() {
					lowMove(this);
					updateDivSort('.benjieCon');
				});
				//添加分解任务
				$("#addTaskBtn").click(
						function() { // 按钮的id
							
							var divTest = $(this).parent().prev(); //获取div
							var newDiv = divTest.clone(true);
							newDiv.css("border-color", "red");
							newDiv.show();
							divTest.after(newDiv);
							//清空
							$(this).parent().prev().find('input').not(
									":button, :submit, :reset, :hidden")
									.val("").removeAttr("checked").remove(
											"selected");

							//排序
							updateDivSort('.benjieCon');
						});
				$(".delChildBtn").click(function() { // del为删除input的id
					$(this).parent().parent().parent().remove();
				});
				//新增一个隐藏的分解任务
				$("#addTaskBtn").click();
				$('#addTaskBtn').parent().prev().hide();

			})
</script>
</head>
<body>

	<div id="toolbar">
		<ul class="nav nav-pills">
			<li>
				<a id="add" href="javascript:history.back(-1)">
					<i class="icon-reply"></i> 返回
				</a>
			</li>
		</ul>
	</div>
	<div class="benjieCon moveLimit">
		<form:form id="inputForm" modelAttribute="yearTaskTableData" action="" method="post">
			<div style="text-align: right; margin-right: 10px;">
				<!-- <input id="saveParentBtn"  type="submit" value = "保存"/> -->
				<a id="saveParentBtn">保存</a>
			</div>
			<form:hidden path="id" />
			<sys:message content="${message}" />

			<div>
				<span>年度${taskYear}</span>
				<fmt:parseDate value="${yearTaskTableData.taskYear}" var="taskYear" pattern="yyyy" />
				<input class="input1" type="text" name="taskYear" value="<fmt:formatDate value="${taskYear}" pattern="yyyy" />" onfocus="WdatePicker({dateFmt:'yyyy'})" />
				<span>序号</span>
				<form:input htmlEscape="false" path="sort" class="input1" />
			</div>
			<div>
				<span>目标任务</span>
				<form:textarea path="targetTask" htmlEscape="false" cssClass="input-xxlarge" style="margin-left: 50px;" rows="6" maxlength="300" />
			</div>
			<div>
				<span>分管区领导</span>
				<form:input htmlEscape="false" path="chargeOfficeChargePersons" class="input1" name="" style="margin-left: 35px;" />
				<div>
					<span>牵头单位</span>
					<form:input htmlEscape="false" path="leadOfficeNames" class="input1" name="leadOfficeNames" style="margin-left: 50px;" />
					<span style="margin-left: 5px;">责任人</span>
					<form:input htmlEscape="false" path="leadOfficeChargePersons" class="input1" name="leadOfficeChargePersons" style="margin-left: 35px;" />
				</div>
				<div>
					<div>
						<span>责任单位</span>
						<sys:officeTree id="office" name="dutyOfficeList" input="dutyOfficeList" value="${dutyOfficeList}" title="单位" url="/sys/office/treeData" checked="true" />
					</div>
				</div>
				<div>
					<span>序号</span>
					<input class="input1" type="text" name="divSort" />
				</div>
			</div>
	</div>
	</form:form>
	<c:if test="${empty relateTaskList}">
		<div class="benjieCon">
			<form:form id="inputFormChild" modelAttribute="yearTaskTableElement" action="" method="post">
				<div style="text-align: right; margin-right: 10px;">
					<a class="upChildBtn" class="divRight">上移</a>
					<a class="downChildBtn" class="divRight">下移</a>
					<a class="saveChildBtn">保存</a>
					<a class="delChildBtn" style="margin-left: 5px;">删除</a>
				</div>
				<form:hidden path="id" />
				<form:hidden path="dataId" value="${yearTaskTableData.id}"/>
				<sys:message content="${message}" />
				<div>
					<span>状态</span>
					<form:radiobuttons path="taskState" items="${fns:getDictList('YW_RWZT')}" itemLabel="chname" itemValue="enname" htmlEscape="false" delimiter="&nbsp;"
						style="margin-left: 80px;" />
				</div>
				<div>
					<span>季度</span>
					<form:checkboxes path="taskQuarter" items="${fns:getDictList('YW_RWJD')}" itemLabel="chname" itemValue="enname" htmlEscape="false" delimiter="&nbsp;"
						style="margin-left: 40px;" />

				</div>
				<div>
					<span>进度安排</span>
					<form:textarea path="taskPlan" htmlEscape="false" cssClass="input-xxlarge" style="margin-left: 50px;" rows="6" maxlength="300" />
				</div>
				<div>
					<span>完成情况</span>
					<form:textarea path="taskExecution" htmlEscape="false" cssClass="input-xxlarge" style="margin-left: 50px;" rows="6" maxlength="300" />
				</div>
				<div>
					<span>序号</span>
					<input class="input1" type="text" name="divSort" />
				</div>
			</form:form>
		</div>
	</c:if>
	<c:forEach items="${relateTaskList}" var="entity">
		<div class="benjieCon">
			<form:form id="inputFormChild"  modelAttribute="yearTaskTableElement" action="" method="post">
				<div style="text-align: right; margin-right: 10px;">
					<a class="upChildBtn" class="divRight">上移</a>
					<a class="downChildBtn" class="divRight">下移</a>
					<a class="saveChildBtn">保存</a>
					<a class="delChildBtn" style="margin-left: 5px;">删除</a>
				</div>
				<c:set target="${yearTaskTableElement}"  property="id" value="${entity.id}"/>
				<form:hidden path="id" />
				<form:hidden path="dataId" value="${yearTaskTableData.id}"/>
				<sys:message content="${message}" />
				<div>
					<span>状态</span>
					<c:set target="${yearTaskTableElement}"  property="taskState" value="${entity.taskState}"/>
					<form:radiobuttons path="taskState"  items="${fns:getDictList('YW_RWZT')}" itemLabel="chname" itemValue="enname" htmlEscape="false" delimiter="&nbsp;"
						style="margin-left: 80px;" />
				</div>
				<div>
					<span>季度</span>
					<c:set target="${yearTaskTableElement}"  property="taskQuarter" value="${entity.taskQuarter}"/>
					<form:checkboxes path="taskQuarter" value="${entity.taskQuarter}" items="${fns:getDictList('YW_RWJD')}" itemLabel="chname" itemValue="enname" htmlEscape="false" delimiter="&nbsp;"
						style="margin-left: 40px;" />

				</div>
				<div>
					<span>进度安排</span>
					<c:set target="${yearTaskTableElement}"  property="taskPlan" value="${entity.taskPlan}"/>
					<form:textarea path="taskPlan" htmlEscape="false" cssClass="input-xxlarge" style="margin-left: 50px;" rows="6" maxlength="300" />
				</div>
				<div>
					<span>完成情况</span>
					<c:set target="${yearTaskTableElement}"  property="taskExecution" value="${entity.taskExecution}"/>
					<form:textarea path="taskExecution"   htmlEscape="false" cssClass="input-xxlarge" style="margin-left: 50px;" rows="6" maxlength="300" />
				</div>
				<div>
					<span>序号</span>
					<input class="input1" type="text" name="divSort" />
				</div>
			</form:form>
		</div>
	</c:forEach>
	<div class="moveLimit">
		<input class="btn btn-primary" type="button" id="addTaskBtn" value="添加任务分解" style="margin-left: 30%;">
	</div>
</body>
</html>