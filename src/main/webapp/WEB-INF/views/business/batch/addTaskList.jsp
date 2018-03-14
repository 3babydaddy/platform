<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>年度重点任务督查</title>
<meta name="decorator" content="default" />
<style type="text/css">
      .splitCss label{
        margin-left: 5px;
    }
     .splitCss input{
        margin-bottom: 6px;
        margin-left: 6px;
    }
</style>
<script type="text/javascript">
	$(function() {



	});

    function save() {


			var value = ""
            $("input[type='checkbox']:checked").each(function() {

                value += $(this).val() + ",";
            });
			var date = $("#remindersDate").val();
			if(date){
			    if (value.length<2){
			        alertx("请选择！");
					return
				}
                $.ajax({
                    type: "post",
                    data:{"list":value,"remindersDate":date},
                    dataType: "json",
                    url: "${ctx}/reminders/save",
                    cache: false,
                    dataType: "json",
                    success: function (res) {
                        if(res.success=='1'){
                            alertx("保存成功！");
                            self.parent.$.jBox.close();
                        }else{
                            alertx("操作失败！");
                        }
                    },
                    error: function (res) {
                        alertx("操作失败！");
                    }
                });
            }else{
			    alertx("催办时间不能为空！");
            }

    }

</script>
</head>
<body style="overflow:hidden;">
	<form:form id="form" cssStyle="overflow:hidden;" modelAttribute="query"  method="post" style="margin:0px;">
		<div id="" class="form-search breadcrumb">
			<input type="hidden" id="id" name="id" value="${id}">
			<div class="input-prepend">
				<span class="add-on">催办时间</span>
				<input class="search-input-mini" type="text" name="remindersDate" id="remindersDate" value="<fmt:formatDate value="${inspectionDate}" pattern="yyyy-MM-dd" />" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
			</div>
		</div>
		<c:if test="${leadlist!=null and leadlist.size()>0}">
			<div id="" class="form-search breadcrumb">
				<div class="input-prepend splitCss">
					<span>负责领导</span>
					<br/>
					<c:forEach items="${leadlist}" var="lead" varStatus="status">
						<input type="checkbox" id="" name="${lead.type}${status.index}" value="${lead.id}">
						<label>${lead.name}</label>
						<c:if test="${status.index mod 3 == '2'}">
							<br/>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</c:if>
		<c:if test="${dwlist!=null and dwlist.size()>0}">
			<div id="" class="form-search breadcrumb">
				<div class="input-prepend splitCss">
					<span>承办单位</span>
					<br/>
					<c:forEach items="${dwlist}" var="dw" varStatus="status">
						<input type="checkbox" id="" name="${dw.type}${status.index}" value="${dw.id}">
						<label>${dw.name}</label>
						<c:if test="${status.index mod 3 == '2'}">
							<br/>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</c:if>
		<div style="text-align: right;">
		    <input id="urge" onclick="save()" class="btn btn-primary" type="button" value="确认催办" style="margin-top:6px;margin-right: 6px;" />
		</div>

		<%--<input id="clear" class="btn btn-primary" type="button" value="重置" />--%>
	</form:form>

</body>
</html>
