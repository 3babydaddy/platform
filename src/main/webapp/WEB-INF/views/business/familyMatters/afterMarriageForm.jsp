<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
	<head>
	    <meta name="decorator" content="default"/>
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
	    <script type="text/javascript">
	        /**
	         * 保存方法
	         */
	        function save() {
	            var matters = $("#matters").val();
	            if (matters){
	                var form = $("form").serializeArray();
	                var obj = {};
	                $.each(form, function (i, v) {
	                    obj[v.name] = v.value;
	                });
	                $.ajax({
	                    type: "post",
	                    data: obj,
	                    url: "${ctx}/familyMatters/save",
	                    dataType: "json",
	                    success: function (res) {
	                        if(res.success=='1'){
	                            $("#id").val(res.id);
	                            alertx("保存成功！");
	                            window.location.href = "${ctx}/familyMatters/afterMarriageIndex";
	                        }else{
	                            alertx("操作失败！");
	                        }
	                    },
	                    error: function () {
	                        alertx("error！");
	                    }
	                });
	            }else{
	                alertx("报告事项不能为空！");
	                return
	            }
	
	        }
	    </script>
	</head>
	<body>
		<div id="toolbar">
		    <ul class="nav nav-pills">
		        <li><a onclick="save();"><i class="icon-save"></i>&nbsp;保存</a></li>
		        <li><a href="javascript:history.back(-1)"><i class="icon-reply"></i>返回</a>
		    </ul>
		</div>
		<div>
		    <form id="inspectionForm" class="form-horizontal">
		        <input type="hidden" id="id" name="id" value="${table.id}">
		        <c:choose>
		        	<c:when test="${table == null}">
		        		<input type="hidden" id="type" name="type" value="1">
		        	</c:when>
		        	<c:otherwise>
		        		<input type="hidden" id="type" name="type" value="${table.type}">
		        	</c:otherwise>
		        </c:choose>
		        <table>
		        	<tr>
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >姓名</label>
					                <div class="controls" >
						                <sys:treeselect cssStyle="width:206px" id="name" name="name" value="${table.name}" labelName="nameText" hideBtn="true" labelValue="${table.nameText}" title="领导" url="/sys/leader/leaderTree?type=01" cssClass="required" checked="true" allowClear="true" />
						            </div>
					        </div>
		        		</td>
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >单位</label>
					            <div class="controls" >
					                <sys:treeselect cssStyle="width:206px" id="company" name="company" value="${table.company}" labelName="companyText" labelValue="${table.companyText}" notAllowSelectParent="true"
					                                title="参加单位" url="/sys/office/treeData"
					                                cssClass="required" checked="true"  hideBtn="true"/>
					            </div>
					        </div>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >职务</label>
					            <div class="controls" >
					                <input class="input" type="text" id="post" name="post" value="${table.post}">
					            </div>
					        </div>
		        		</td>
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >身份证号</label>
					            <div class="controls" >
					                <input class="input" type="text" id="idNumber" name="idNumber" value="${table.idNumber}">
					            </div>
					        </div>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td colspan="2">
		        			<div class="control-group">
					            <label class="control-label" >报告事项</label>
					            <div class="controls" >
					                <input class="input" type="text" id="matters" name="matters" value="${table.matters}">
					            </div>
					        </div>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >宴请时间</label>
					            <div class="controls">
				                    <fmt:parseDate value="${table.feteTime}" var="feteTime"/>
				                    <input type="text" id="feteTime" name="feteTime"
				                           value="<fmt:formatDate value="${feteTime}" pattern="yyyy-MM-dd"/>" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
				                </div>
					        </div>
		        		</td>
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >城市</label>
					            <div class="controls" >
					                <input class="input" type="text" id="city" name="city" value="${table.city}">
					            </div>
					        </div>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td colspan="2">
		        			<div class="control-group">
					            <label class="control-label" >宴请地点</label>
					            <div class="controls" >
					                <input style="width:795px;" class="input" type="text" id="fetePlace" name="fetePlace" value="${table.fetePlace}">
					            </div>
					        </div>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td colspan="2">
		        			<div class="control-group">
					            <label class="control-label" >宴请规模</label>
					            <div class="controls" >
					                <input style="width:795px;" class="input" type="text" id="feteScale" name="feteScale" value="${table.feteScale}">
					            </div>
					        </div>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >参加人员</label>
					            <div class="controls" >
					                <input class="input" type="text" id="attendants" name="attendants" value="${table.attendants}">
					            </div>
					        </div>
		        		</td>
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >数量</label>
					            <div class="controls" >
					                <input class="input" type="text" id="amount" name="amount" value="${table.amount}">
					                (人)
					            </div>
					        </div>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td colspan="2">
		        			<div class="control-group">
					            <label class="control-label" >收取礼金礼品数量</label>
					            <div class="controls" >
					                <input style="width:795px;" class="input" type="text" id="giftAmount" name="giftAmount" value="${table.giftAmount}">
					            </div>
					        </div>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >宴席桌数</label>
					            <div class="controls" >
					                <input class="input" type="text" id="feteAmount" name="feteAmount" value="${table.feteAmount}">
					                (桌)
					            </div>
					        </div>
		        		</td>
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >价格</label>
					            <div class="controls" >
					                <input class="input" type="text" id="feteCost" name="feteCost" value="${table.feteCost}">
					                (元)
					            </div>
					        </div>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >其他费用</label>
					            <div class="controls" >
					                <input class="input" type="text" id="otherCost" name="otherCost" value="${table.otherCost}">
					                (元)
					            </div>
					        </div>
		        		</td>
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >总体花费</label>
					            <div class="controls" >
					                <input class="input" type="text" id="totalCost" name="totalCost" value="${table.totalCost}">
					                (元)
					            </div>
					        </div>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td colspan="2" rowspan="2">
		        			<div class="control-group">
					            <label class="control-label" >其他需要说明的情况</label>
					            <div class="controls" >
					                <input style="width:795px;height:50px;" class="input" type="text" id="instruction" name="instruction" value="${table.instruction}">
					            </div>
					        </div>
		        		</td>
		        	</tr>
		        </table>
		    </form>
		</div>
	</body>
</html>