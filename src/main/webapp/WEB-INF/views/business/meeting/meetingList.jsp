<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>会议列表</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treetable.jsp"%>
 <link rel="stylesheet" href="${ctxStatic}/common/css/common.css">
 <style type="text/css">
    .navbar .nav > li > a {
		    float: none;
		    padding: 10px 15px 10px;
		    color: #dd4814;
		    text-decoration: none;
		}
	.navbar {
	    margin-bottom: 5px;
	    margin-left: 10px;
	    }
	.navbar .nav li.dropdown.open > .dropdown-toggle, .navbar .nav li.dropdown.active > .dropdown-toggle, .navbar .nav li.dropdown.open.active > .dropdown-toggle {
		    color: #ffffff;
		    background-color: #dd2014;
		}
 </style>
<script type="text/javascript">
function addMeeting(){
    $.jBox("iframe:${ctx}/ywgl/Meeting/goSingleMeetingForm", {
	        title: "新增会议",
	        width: 400,
	        height: 260,
	        buttons: { '保存': 1, '保存并添加议定事项' :2 },
	        dragLimit: true,
	        submit: function(v,h,f){
	            var formData=$("#jbox-iframe").contents().find("#addMeeting").serialize();
	            var meetingName=$("#jbox-iframe").contents().find("#meetingName").val();
	            var meetingTime=$("#jbox-iframe").contents().find("#meetingTime").val();
	            if(v==1){
	                if(meetingName==null||meetingName==""){
	                    alertx("会议名称不能为空！");
	                    $("#jbox-iframe").contents().find("#meetingName").focus();
	                    return false;
	                }
	                if(meetingTime==null||meetingTime==""){
	                    $("#jbox-iframe").contents().find("#meetingTime").focus();
	                    alertx("召开时间不能为空！");
	                    return false;
	                }
	                $.ajax({
	                    type: "post",
	                    data:formData,
	                    url: "${ctx}/ywgl/Meeting/saveTableData",
	                    cache: false,
	                    success:function(data){
	                    	$.jBox.close();
	                    	alertx("恭喜您保存成功！");
	                    	$("#searchButton").click();
	                    },
	                    error:function(res){
	                    	$.jBox.close();
	                        alertx("保存失败，请重试！");
	                    }
	                })
	            }
	            if(v==2){
	            	if(meetingName==null||meetingName==""){
                        alertx("会议名称不能为空！");
                        $("#jbox-iframe").contents().find("#meetingName").focus();
                        return false;
                    }
                    if(meetingTime==null||meetingTime==""){
                        $("#jbox-iframe").contents().find("#meetingTime").focus();
                        alertx("召开时间不能为空！");
                        return false;
                    }
                    $.ajax({
                        type: "post",
                        data:formData,
                        url: "${ctx}/ywgl/Meeting/saveTableData",
                        cache: false,
                        success:function(data){
                            var id=data.id
                            location.href="${ctx}/ywgl/Meeting/form?id="+id;
                            $.jBox.close();
                        },
                        error:function(res){
                        	$.jBox.close();
                            alertx("保存失败，请重试！");
                        }
                    })
	            }

	        },
	        // 点击状态按钮后的回调函数，返回true时表示关闭窗口，    参数有三个，v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
	        // opacity: 0, /* 窗口隔离层的透明度,如果设置为0,则不显示隔离层，即遮罩层，设置为0时，点击弹框意外位置不会关闭弹窗，有弹窗时无法操作弹窗外的内容。*/
	        persistent: true /*在显示隔离层的情况下，点击隔离层时，是否坚持窗口不关闭 */
	    });
	}
$(function() {
	   $('#addTab li').click(function(){
           var i = $(this).index();
           $('#addTab li').removeClass('active');
           $(this).addClass('active');
       })
       $('#addTab li').first().click();
    $('#search').click(function() {
        $('#table').bootstrapTable('refresh');
    });
    $('#searchInput').keydown(function(event) {
        if (event.keyCode == 13) {
            $('#search').click();
        }
    });
    $('#table').tfkjTable({
        url : '${ctx}/ywgl/Meeting/list',
        sortOrder : 'desc',
        queryParams : 'queryParams',
        columns : [ {
            field : 'state1',
            checkbox : true,
        }, {
            field : 'parentId',
            visible : false,
        },
        {
        	field : 'num',
            title: '序号',//标题  可不加
        },
        {
            field : 'meetingName',
            title : "会议名称",
            valign : "middle",
            align : "center",
           formatter: function (value, row) {
                return "<nobr>" +
                    "<a href='${ctx}/ywgl/Meeting/form?id=" + row.parentId + "'>" + value + "</a>"
                    + "</nobr>"
            }
        }, {
            field : 'meetingTime',
            title : "召开时间",
            valign : "middle",
            sortable : true,
            sortName:"data.MEETING_TIME",
            align : "center",
            formatter : function(value, row) {
                if(value==null){
                    value="-";
                }
                return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
                        + value + "</nobr></div>";
            }

        },{
            field : 'agreeMatterName',
            title : "跟踪督办事项",
            valign : "middle",
            align : "center",
            colspan : 1,
            formatter : function(value, row) {
                if(value==null){
                    value="-";
                }
                return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
                        + value + "</nobr></div>";
            }

        },   {
            field : 'relateRequest',
            title : "有关要求",
            valign : "middle",
            align : "center",
            formatter : function(value, row) {
                if(value==null){
                    value="-";
                }
                return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
                        + value + "</nobr></div>";
            }

        },{
            field : 'leaderText',
            title : "牵头领导",
            valign : "middle",
            align : "center",
            formatter : function(value, row) {
                if(value==null){
                    value="-";
                }
                return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
                        + value + "</nobr></div>";
            }

        }, {
            field : 'officeShow',
            title : "责任单位",
            valign : "middle",
            align : "center",
            formatter : function(value, row) {
                if(value==null){
                    value="-";
                }
                return "<div style='width: 110px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
                        + value + "</nobr></div>";
            }

        }, {
            field : 'endtime',
            title : "完成时限",
            valign : "middle",
            align : "center",
            formatter : function(value, row) {
                if(value==null){
                    value="-";
                }
                return "<div style='width: 130px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
                        + value + "</nobr></div>";
            }

        }, {
            field : 'fulfillSituation',
            title : "落实情况",
            valign : "middle",
            align : "center",
            formatter : function(value, row) {
                if(value==null){
                    value="-";
                }
                return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
                        + value + "</nobr></div>";
            }

        }, {
            field : 'state',
            title : "状态",
            valign : "middle",
            align : "center",
            formatter: function (value, row) {
            	var show="";
                if(value=='N'){
                	show="未落实"
                }
                if(value=='Y'){
                	show="已落实"
                }
                return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + show + "'><nobr>"
                        + show + "</nobr></div>";
            }
        }
        , {
            field : 'opertorTime',
            title : "落实时间",
            valign : "middle",
            align : "center",
            formatter : function(value, row) {
                if(value==null){
                    value="-";
                }
                return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
                        + value + "</nobr></div>";
            }
        }

        ],
        onClickRow : function(row, $element, field) {
            $('#table').bootstrapTable('uncheckAll');
            $('#table').bootstrapTable('check', $element[0].rowIndex - 1);
        },
        onLoadSuccess : function(data) {
            var data = $('#table').bootstrapTable('getData', true);
            //合并单元格
            mergeCells(data, "meetingName,meetingTime,state1,num","parentId", 1, $('#table'));

            },
    });
    //查询
    $("#searchButton").click(function () {
        $('#table').bootstrapTable('refresh');
    });
    //点击标签
    $("#frist").click(function () {
    	$('#meetingType').val('QWCWh');
        $('#table').bootstrapTable('refresh');
    });
    $("#second").click(function () {
    	$('#meetingType').val('QZFCWH');
        $('#table').bootstrapTable('refresh');
    });

})

	/**
	 * 合并单元格
	 * @param data  原始数据（在服务端完成排序）
	 * @param fieldName 合并属性名称
	   @param flagName  标记属性名称
	 * @param colspan   合并列
	 * @param target    目标表格对象
	 */
	function mergeCells(data,fieldName,flagName,colspan,target){
	    //声明一个map计算相同属性值在data对象出现的次数和
	    var sortMap = {};
	    for(var i = 0 ; i < data.length ; i++){
	        for(var prop in data[i]){
	            if(prop == flagName){
	                var key = data[i][prop]
	                if(sortMap.hasOwnProperty(key)){
	                    sortMap[key] = sortMap[key] * 1 + 1;
	                } else {
	                    sortMap[key] = 1;
	                }
	                break;
	            }
	        }
	    }
	   /*  for(var prop Rin sortMap){
	        console.log(prop,sortMap[prop])
	    } */
	    //获取每页显示的数量
	    var pageSize=$(target).bootstrapTable('getOptions').pageSize;
	    //获取当前是第几页
	    var pageNumber=$(target).bootstrapTable('getOptions').pageNumber;
	    var i= pageSize * (pageNumber - 1)+1;
        var index1 = 0;
        for(var prop in sortMap){
            var count = sortMap[prop] * 1;
            $(target).bootstrapTable('updateRow',{index:index1, row:{num:i}});
            index1 += count;
            i++;
        }
        //合并单元格
        var index = 0;
	    for(var prop in sortMap){
	        var count = sortMap[prop] * 1;
	        $(target).bootstrapTable('mergeMulCells',{index:index, field:fieldName, colspan: colspan, rowspan: count});
	        index += count;
	        i++;
	    }


	}
    function queryParams(params) {
    	 $('#searchForm').find('input[name]').each(function () {
             params[$(this).attr('name')] = $(this).val();
         });
         $('#searchForm').find('select[name]').each(function () {
             params[$(this).attr('name')] = $(this).val();
         });
    	 return params;
    }
    // 删除
    function deleteMeeting() {
        var ryxx = $("#table").bootstrapTable("getSelections");
        ids = [],
            i = 0;
        if (ryxx != null && ryxx.length > 0) {
            for (; i < ryxx.length; i++) {
                ids.push(ryxx[i].parentId);
            }
        }
        if (ids.length == 0) {
            alertx("请选择要删除的信息!");
            return;
        } else {
            confirmx('确认要删除选中信息吗？',function (){
                $.ajax({
                    type: "get",
                    data: "",
                    url: "${ctx}/ywgl/Meeting/deleteMeeting?ids=" + ids,
                    cache: false,
                    dataType: "json",
                    success: function (res) {
                        if (res.flag=='success') {
                        	$("#searchButton").click();
                            alertx("恭喜您删除成功！");

                        } else {
                            alertx("删除出错，请您重试！");
                        }
                    },
                    error: function (res) {
                        alertx(res);
                    }
                })
            },'');
        }
    }
  //导出excel
    function exportExcel() {
        confirmx('确认要导出数据吗？',function(){
             var rows=$("#table").bootstrapTable("getSelections"),
             ids=[],
             i = 0;
         if(rows!=null && rows.length>0){
             for (; i < rows.length; i++) {
                 ids.push(rows[i].parentId);
             }
         }
         var obj = {};
         $('#searchForm').find('input[name]').each(function () {
             obj[$(this).attr('name')] = $(this).val();
         });
         $('#searchForm').find('select[name]').each(function () {
             obj[$(this).attr('name')] = $(this).val();
         });
         var par = $.param(obj);
         var decodeParams = decodeURIComponent(par);
         window.location.href="${ctx}/ywgl/Meeting/exportExcel?ids="+ids+"&"+decodeParams;
        },'')
    }
    //重置
    function resetVal(){
        $("#leadLeaderId").val("");
        $("#officeNameId").val("")
    }

</script>
</head>
<body>
 <nav class="navbar navbar-default" role="navigation"  >
       <div class="container-fluid" style="padding-left:0px;">
               <ul class="nav navbar-nav" id="addTab">
                     <li  class="dropdown "  id="frist">
                             <a class="dropdown-toggle"  data-toggle="dropdown"   title="基本信息"><i class="icon-paste"></i>&nbsp;区委常委会</a>
                     </li>
                      <li  class="dropdown " id="second">
                             <a class="dropdown-toggle"  data-toggle="dropdown"   title="综合情况"><i class="icon-paste"></i>&nbsp;区政府常务会</a>
                     </li>
               </ul>
           </div>
   </nav>
      <form:form id="searchForm" modelAttribute="meetingData" >
        <input name="meetingType" id="meetingType" type="hidden" value="QWCWh"/>
        <div class="controls controls-row">
            <div class="search-div input-prepend input-append margin-left-2">
                <span class="add-on">会议名称</span>
                <form:input cssClass="search-input-medium" path="meetingName" htmlEscape="false" maxlength="50" />
            </div>
            <div class="search-div input-prepend input-append">
                <span class="add-on">召开时间</span>
                <input class="search-input-small" type="text" name="meetingTimeStart"  onfocus="WdatePicker()" />
                <span class="add-on">至</span>
                <input class="search-input-small" type="text" name="meetingTimeEnd"  onfocus="WdatePicker()" />
            </div>
             <div class="search-div input-prepend input-append">
                <span class="add-on">有关要求</span>
                <form:input cssClass="search-input-medium" path="relateRequest" htmlEscape="false" maxlength="50" />
            </div>
            <div class="search-div input-prepend input-append">
                <span class="add-on">状态</span>
                <form:select path="state" class="search-select-mini">
                    <option value="">全部</option>
                    <option value="Y">已落实</option>
                    <option value="N">未落实</option>
                </form:select>
            </div>
        </div>
        <div class="controls controls-row">
            <div class="search-div input-prepend input-append">
                <span class="add-on">跟踪督办事项</span>
                <form:input cssClass="search-input-medium" path="agreeMatterName" htmlEscape="false" maxlength="50" />
            </div>
            <div class="search-div input-prepend input-append">
                <span class="add-on">完成时限</span>
                <input class="search-input-small" type="text" name="endtimeStart"  onfocus="WdatePicker({startDate:'%y-%M-01 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})" />
                <span class="add-on">至</span>
                <input class="search-input-small" type="text" name="endtimeEnd"  onfocus="WdatePicker({startDate:'%y-%M-01 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})" />
            </div>
             <div class="search-div input-prepend input-append">
                <span class="add-on">落实情况</span>
                <form:input cssClass="search-input-medium" path="fulfillSituation" htmlEscape="false" maxlength="50" />
            </div>
            <div class="search-div input-prepend input-append">
                <span class="add-on">年度</span>
                <input class="search-input-mini" type="text" id="year" name="year" value="2018"  onfocus="WdatePicker({dateFmt:'yyyy'})" />
            </div>
        </div>
        <div class="controls controls-row">
            <div class="search-div input-prepend input-append margin-left-2">
                <span class="add-on">牵头领导</span>
                <sys:treeselect id="leadLeader" name="leader" value="${table.leader}" labelName="" labelValue="" title="领导" url="/sys/leader/leaderTree?type=01" cssClass="required"  checked="true"  allowClear="true" hideBtn="true" notAllowSelectParent="true"/>
            </div>
            <div class="search-div input-prepend input-append">
                <span class="add-on">落实时间</span>
                <input class="search-input-small" type="text" name="opertorTimeStart"  onfocus="WdatePicker()" />
                <span class="add-on">至</span>
                <input class="search-input-small" type="text" name="opertorTimeEnd"  onfocus="WdatePicker()" />
            </div>
             <div class="search-div input-prepend input-append">
                <span class="add-on">责任单位</span>
                <sys:treeselect id="officeName" name="officeName" value="${table.officeName}" labelName="" labelValue="" title="参加单位" url="/sys/office/treeData" cssClass="required"  allowClear="true" notAllowSelectParent="true" hideBtn="true"/>
            </div>
            <input id="searchButton" class="btn btn-primary" type="button" value="查询" />
            <input id="clear" class="btn btn-primary" type="reset" value="重置" onclick="resetVal()"/>
        </div>
    </form:form>
    <div id="toolbar">
        <ul class="nav nav-pills">
            <!-- <li><a id="updateSortBtn" href="javascript:void(0)"><i class="icon-plus"></i>&nbsp;保存排序</a></li> -->
            <li><a  onclick="addMeeting()"><i class="icon-plus"></i>&nbsp;新增</a></li>
            <li><a  onclick="deleteMeeting()"><i class="icon-trash"></i>&nbsp;删除</a></li>
            <li> <a id="exportExcel" onclick="exportExcel()" ><i class="icon-download"></i> &nbsp;导出台账</a></li>
        </ul>
    </div>
    <sys:message content="${message}" />
    <div id="content">
        <table id="table"></table>
    </div>

</body>
</html>