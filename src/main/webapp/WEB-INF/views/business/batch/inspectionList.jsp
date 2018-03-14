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
            $("#in0012").val("01");
            var date = new Date();
            $("#taskYear").val(date.getFullYear());
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
                url : '${ctx}/relation/list',
                sortOrder : 'desc',
                queryParams : 'queryParams',
                columns : [
                    {
                        field : 'state',
                        checkbox : true,
                    },
                    {
                        field : 'dataId',
                        visible : false,
                    },
                    {
                        field : 'num',
                        title : "序号",
                        valign : "middle",
                        align : "center",
                        width : 40,

                    },
                    {
                        field : 'parentIn0010Text',
                        title : "责任领导",
                        valign : "middle",
                        align : "center",
                        formatter : function(value, row) {
                            var strB =  "<a href='${ctx}/reminders/form?relationType=1&id="
                                    + row.unqId + "' >"
                                    + value + "</a>"
                            return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis'><nobr>"
                                + strB + "</nobr></div>";
                        }

                    },
                    {
                        field : 'parentIn0009Text',
                        title : "承办单位",
                        valign : "middle",
                        align : "center",
                        formatter : function(value, row) {
                            var strB =  "<a href='${ctx}/reminders/form?relationType=2&id="
                                + row.unqId + "' >"
                                + value + "</a>"
                            return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis'><nobr>"
                                + strB + "</nobr></div>";
                        }
                    },
                 {
                        field : 'remindersDate',
                        title : "催办时间",
                        valign : "middle",
                        align : "center",
                    },
                    {
                        field : 'parentIn0016Text',
                        title : "文件类型",
                        valign : "middle",
                        align : "center",
                    },
                    {
                        field : 'parentIn0017Text',
                        title : "批示领导",
                        valign : "middle",
                        align : "center",
                    },
                    {
                        field : 'parentIn0001',
                        title : "文件名",
                        valign : "middle",
                        align : "center",
                        width : 100,
                        formatter : function(value, row) {
                            var strB = "";

                            if (row.parentIn0019 == ''
                                || row.parentIn0019 == null) {
                                strB = "<a href='${ctx}/ywgl/instructions/form?id="
                                    + row.dataId + "' >"
                                    + value + "</a>"
                            }
                            if (row.parentIn0019 == '01') {
                                strB =  ""
                                    + "<a  href='${ctx}/ywgl/instructions/form?id="
                                    + row.dataId + "' >"
                                    +"<i class='icon-exclamation-sign' title='重点关注'></i>"
                                    + value + " </a>"
                            }
                            if (row.parentIn0019 == '02') {
                                strB = ""
                                    + "<a href='${ctx}/ywgl/instructions/form?id="
                                    + row.dataId + "' >"
                                    +"<i class='icon-star' title='报送领导'></i>"
                                    + value + "</a>"
                            }
                            if (row.parentIn0019 == '01,02') {
                                strB = ""
                                    + "<a href='${ctx}/ywgl/instructions/form?id="
                                    + row.dataId + "' >"
                                    +"<i class='icon-exclamation-sign' title='重点关注'></i>"
                                    +"<i class='icon-star' title='报送领导'></i>"
                                    + value + "</a>";
                            }
                            return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
                                + strB + "</nobr></div>";
                        }
                    },
                    {
                        field : 'parentIn0002',
                        title : "文件号",
                        valign : "middle",
                        align : "center",
                        formatter : function(value, row) {
                            if (value == null) {
                                value = "-";
                            }
                            return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
                                + value + "</nobr></div>";
                        }

                    },
                    {
                        field : '',
                        title : "批示内容及日期",
                        valign : "middle",
                        align : "center",
                        colspan : 1,
                        formatter : function(value, row) {
                            var show = "";
                            if (row.parentIn0003) {
                                show += row.parentIn0003;
                            }
                            if (row.parentIn0004) {
                                show += row.parentIn0004;
                            }
                            return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + show + "'><nobr>"
                                + show + "</nobr></div>";
                        }
                    },
                    {
                        field : 'parentIn0013Text',
                        title : "是否超期",
                        valign : "middle",
                        align : "center",
                        formatter : function(value, row) {
                            if (value == null) {
                                value = "-";
                            }
                            return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
                                + value + "</nobr></div>";
                        }
                    },{
                        field : 'parentIn0012Text',
                        title : "办理情况",
                        valign : "middle",
                        align : "center",
                        formatter : function(value, row) {
                            if (value == null) {
                                value = "-";
                            }
                            return "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
                                + value + "</nobr></div>";
                        }
                    },

                    {
                        field : 'parentIn0014',
                        title : "落实及上报情况",
                        valign : "middle",
                        align : "center",
                        formatter : function(value, row) {
                            if (value == null) {
                                value = "-";
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
                    mergeCells(data, "remindersDate,num,state,parentIn0009Text,parentIn0010Text","unqId", 1, $('#table'));

                },

            });
            $('#table').bootstrapTable('hideColumn', 'parentIn0009Text');
            $('#table').bootstrapTable('showColumn', 'parentIn0010Text');
            //查询
            $("#searchButton").click(function () {
                $('#table').bootstrapTable('refresh');
            });
            $("#clear").click(function() {


                $('#searchForm').find('input[name]').each(function() {
                    $(this).val("");
                });
                $('#searchForm').find('select[name]').each(function() {
                    $(this).val("");
                });
                $("#in0012").val("01");
                //年度
                var date = new Date();
                $("#taskYear").val(date.getFullYear());
                $("#frist").click();
            });
            //点击标签
            $("#frist").click(function () {
                $('#relationType').val('1');
                $('#table').bootstrapTable('hideColumn', 'parentIn0009Text');
                $('#table').bootstrapTable('showColumn', 'parentIn0010Text');
                $('#table').bootstrapTable('refresh');
            });
            $("#second").click(function () {
                $('#relationType').val('2');
                $('#table').bootstrapTable('hideColumn', 'parentIn0010Text');
                $('#table').bootstrapTable('showColumn', 'parentIn0009Text');
                $('#table').bootstrapTable('refresh');
            });
            var relationType = $("#relationType").val()
            if (relationType=='2'){
                $("#second").click();

            }else if (relationType=='1') {
                $("#frist").click();

            }
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
                var fieldNames=fieldName.split(",");
                $.each(fieldNames,function(i,v){
                    $(target).bootstrapTable('mergeCells',{index:index, field:v, colspan: colspan, rowspan: count});
                });
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
        //重置
        function resetVal(){
            $("#leadLeaderId").val("");
            $("#officeNameId").val("");
        }
        function delect() {
            var rows = $("#table").bootstrapTable("getSelections"),
                ids = [], i = 0;
            if (rows != null && rows.length > 0) {
                for (; i < rows.length; i++) {
                    ids.push(rows[i].unqId);
                }
            }
            if(rows.length>0){
                confirmx("确认要删除该记录吗?",function () {
                   var type = $("#relationType").val();

                    $.ajax({
                        type: "post",
                        data: '',
                        url: "${ctx}/reminders/delete?ids="+ids+"&relationType="+type,
                        cache: false,
                        dataType: "json",
                        success: function (res) {
                            if(res.success=='1'){
                                alertx("删除成功！");
                                $('#table').bootstrapTable('refresh');
                            }else{
                                alertx("操作失败！");
                            }
                        },
                        error: function (res) {
                            alertx("操作失败！");
                        }
                    });
                })

            }else{
                alertx("请选择删除的数据!");
                return;
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
                     ids.push(rows[i].unqId);
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
             window.location.href="${ctx}/relation/exportExcel?ids="+ids+"&"+decodeParams;
            },'')
        }
    </script>
</head>
<body>
<nav class="navbar navbar-default" role="navigation"  >
    <div class="container-fluid" style="padding-left:0px;">
        <ul class="nav navbar-nav" id="addTab">
            <li  class="dropdown "  id="frist">
                <a class="dropdown-toggle"  data-toggle="dropdown"   title="责任领导"><i class="icon-paste"></i>&nbsp;责任领导</a>
            </li>
            <li  class="dropdown " id="second">
                <a class="dropdown-toggle"  data-toggle="dropdown"   title="承办单位"><i class="icon-paste"></i>&nbsp;承办单位</a>
            </li>
        </ul>
    </div>
</nav>

<form:form id="searchForm" modelAttribute="query">

    <div style="display: none">
        <input name="relationType" id="relationType" type="text" value="1" />
    </div>
    <div class="controls controls-row ">
        <div class="search-div input-prepend input-append margin-left-1">
            <span class="add-on">文件名</span>
            <form:input cssClass="search-input-medium style_input_width_small" path="in0001" htmlEscape="false" maxlength="50" />
        </div>
        <div class="search-div input-prepend input-append ">
            <span class="add-on">批示时间</span>
            <input class="search-input-small style_date_width_small" type="text" name="in0004Start" onfocus="WdatePicker()" />
            <span class="add-on">至</span>
            <input class="search-input-small style_date_width_small" type="text" name="in0004End" onfocus="WdatePicker()" />
        </div>


        <div class="search-div input-prepend input-append ">
            <span class="add-on">是否超期</span>
            <form:select path="in0013" class="search-select-mini style_select_width_small">
                <option value="">全部</option>
                <form:options items="${fns:getDictList('YW_SF')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
            </form:select>
        </div>
        <div class="search-div input-prepend input-append input-append margin-left-1">
            <span class="add-on">来源</span>
            <form:select path="in0017" class="search-select-mini style_select_width_small">
                <option value="">全部</option>
                <form:options items="${fns:getDictList('YW_PS_LY')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
            </form:select>
        </div>



    </div>

    <div class="controls controls-row ">
        <div class="search-div input-prepend input-append margin-left-1">
            <span class="add-on">文件号</span>
            <form:input cssClass="search-input-medium style_input_width_small" path="in0002" htmlEscape="false" maxlength="50" />
        </div>
        <div class="search-div input-prepend input-append ">
            <span class="add-on">催办日期</span>
            <input class="search-input-small style_date_width_small" type="text" name="in0011Start" onfocus="WdatePicker()" />
            <span class="add-on">至</span>
            <input class="search-input-small style_date_width_small" type="text" name="in0011End" onfocus="WdatePicker()" />
        </div>
        <div class="search-div input-prepend input-append ">
            <span class="add-on">办理情况</span>
            <form:select path="in0012" class="search-select-mini style_select_width_small">
                <option value="">全部</option>
                <form:options items="${fns:getDictList('YW_PS_BLQK')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
            </form:select>
        </div>

        <div class="search-div input-prepend input-append  input-append margin-left-1 ">
            <span class="add-on">年度</span>
            <fmt:parseDate value="${query.taskYear}" var="taskYear" pattern="yyyy" />
            <input class="search-input-mini" style="width: 100px" type="text" id="taskYear" name="taskYear" value="<fmt:formatDate value="${taskYear}" pattern="yyyy" />"
                   onfocus="WdatePicker({dateFmt:'yyyy'})" />
        </div>
    </div>
    <div class="controls controls-row ">
        <div class="search-div input-prepend input-append ">
            <span class="add-on">批示内容</span>
            <form:input cssClass="search-input-medium style_input_width_small" path="in0003" htmlEscape="false" maxlength="50" />
        </div>
        <div class="search-div input-prepend">
            <span class="add-on">落实及上报情况</span>
            <form:input cssClass="search-input-medium style_input_width_small" cssStyle="width: 240px" path="in0014" htmlEscape="false" maxlength="50" />
        </div>
        <div class="search-div input-prepend input-append ">
            <span class="add-on">责任领导</span>
            <sys:treeselect id="in0009" cssStyle="width: 100px;" name="leaderIds" value="" labelName="in0009" labelValue="${query.in0009Text}" title="领导" url="/sys/leader/leaderTree?type=01"
                            cssClass="required" allowClear="true" notAllowSelectParent="fasle" hideBtn="true" />
        </div>
        <input id="searchButton" class="btn btn-primary" type="button" value="查询" />
        <input id="clear" class="btn btn-primary" type="button" value="重置" />
    </div>
</form:form>
<div id="toolbar">
    <ul class="nav nav-pills">
        <li><a id="add" onclick="add();"><i class="icon-plus"></i>&nbsp;新增</a></li>
        <%--<li><a id="saveSort" onclick="saveSort()"><i class="icon-plus"></i>&nbsp;保存排序</a></li>--%>
        <%--<li><a onclick="update()"><i class="icon-plus"></i>&nbsp;修改</a></li>--%>
        <li><a onclick="delect();"><i class="icon-trash"></i> &nbsp;删除</a></li>
        <li><a id="export" onclick="exportExcel()"><i class="icon-download"></i>&nbsp;导出台账</a></li>
    </ul>
</div>
<sys:message content="${message}" />
<div id="content">
    <table id="table"></table>
</div>

</body>
</html>