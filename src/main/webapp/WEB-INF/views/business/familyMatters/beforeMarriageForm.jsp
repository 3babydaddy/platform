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
	        .notestyle{
	        	margin-top:30px;
	        }
	        .notetitle{
	        	font-weight:bold;
	        	font-size:20px;
	        }
	        .notestyle label{
	        	margin-top:5px;
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
	                            window.location.href = "${ctx}/familyMatters/index";
	                        }else{
	                            alertx("操作失败！");
	                        }
	                    },
	                    error: function () {
	                        alertx("error！");
	                    }
	                });
	            }else{
	                alertx("申报事宜不能为空！");
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
		    <form id="familyMattersForm" class="form-horizontal">
		        <input type="hidden" id="id" name="id" value="${table.id}">
		        <c:choose>
		        	<c:when test="${table == null}">
		        		<input type="hidden" id="type" name="type" value="0">
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
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >申报事宜</label>
					            <div class="controls" >
					                <input class="input" type="text" id="matters" name="matters" value="婚嫁">
					            </div>
					        </div>
		        		</td>
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >举办方式</label>
					            <div class="controls" >
					                <input class="input" type="text" id="holding" name="holding" value="${table.holding}">
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
					            <label class="control-label" >宴请地点</label>
					            <div class="controls" >
					                <input class="input" type="text" id="fetePlace" name="fetePlace" value="${table.fetePlace}">
					            </div>
					        </div>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >宴请桌数</label>
					            <div class="controls" >
					                <input class="input" type="text" id="feteAmount" name="feteAmount" value="${table.feteAmount}">
					                (桌)
					            </div>
					           	
					        </div>
		        		</td>
		        		<td>
		        			<div class="control-group">
					            <label class="control-label" >宴请标准</label>
					            <div class="controls" >
					                <input class="input" type="text" id="feteStandards" name="feteStandards" value="${table.feteStandards}">
					                (元/桌)
					            </div>
					            
					        </div>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td colspan="2">
		        			<div class="control-group">
					            <label class="control-label" >宴请对象</label>
					            <div class="controls" >
					                <input class="input" type="text" id="fetePeople" name="fetePeople" value="${table.fetePeople}">
					            </div>
					        </div>
		        		</td>
		        	</tr>
		        </table>
		    </form>
		</div>
		<div class="notestyle">
			<label class="notetitle">廉政承诺事项</label><br>
			<label>1.不搞铺张浪费、大操大办、借机敛财</label><br>
			<label>2.不邀请工作分管范围内的单位、个人和服务对象，以及与个人行使职权有关的人员参加</label><br>
			<label>3.不收受或者变相收受本单位或个人行使职权有关单位、近亲属以外人员的礼品礼金，不接受可能影响公正执行公务的礼品礼金</label><br>
			<label>4.不再本单位或与自己工作有关的单位报销或者变相报销费用</label><br>
			<label>5.不利用职权或职务影响，违规使用公共资源、占用公务车辆</label><br>
			<label>6.不再操办婚丧嫁娶事宜过程中搞封建迷信活动、举办低俗演义活动、大量燃放烟花爆竹等扰民类活动</label><br>
		</div>
	</body>
</html>