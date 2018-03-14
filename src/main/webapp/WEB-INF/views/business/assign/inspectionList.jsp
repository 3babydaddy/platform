<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>

<head>
    <title>交办督查列表</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/common/css/common.css">
    <script type="text/javascript">

        $(function () {
            $(".Wdate").focus(function () {
                WdatePicker({
                    dateFmt: 'yyyy-MM-dd',
                    autoUpdateOnChanged: true
                });
            });
            if ('${listType}' == 09) {
                $('#searchbar').hide();
            }
        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            var date = new Date();
            $("#yearNumber").val(date.getFullYear());
            $('#search').click(function () {
                $('#table').bootstrapTable('refresh');
            });
            $("#clear").click(function() {
                 $('#searchForm').find('input[name]').each(function() {
                    $(this).val("");
                });
                $('#searchForm').find('select[name]').each(function() {
                    $(this).val("");
                });
                //年度
                var date = new Date();
                $("#yearNumber").val(date.getFullYear());
            });
            $('#table').tfkjTable({
                url: '${ctx}/assign/list',
                queryParams: 'queryParams',
                cache: false,
                method: "get",
                editable:true,//开启编辑模式

                pagination: true,//分页
                striped: true, //设置为 true 会有隔行变色效果
                rowStyle: function (value, row) {
                    return {
                        css: {
                            "white-space": "nowrap"
                        }
                    }
                },
                columns: [
                    {
                        field: 'state',
                        checkbox: true,
                        align: 'center',
                        valign: 'middle',
                        width: 35
                    }, {
                        field: 'id',
                        visible: false
                    },{
                        title: '序号',//标题  可不加
                        formatter : function(value, row, index) {
                            //return index+1; //序号正序排序从1开始
                            var pageSize=$('#table').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
                            var pageNumber=$('#table').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
                            return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
                        },
                        width: 40,
                    },
//                    {
//                        field: 'sort',
//                        title: '序号',
//                        formatter: function nameFormatter(value, row) {
//                            return "<input id="+row.id+" style='width: 50px' type='number' value="+value+" '>"+"</input>";
//                        },
//
//                    },
                    {
                        field: 'inspectionTask',
                        title: '交办事项',
                        width: 100,
                        formatter: function (value, row) {
                            var manager = "";
                            if (value.length>5){
                                manager = value.substring(0,5)+"...";
                                return "<nobr>" +
                                    "<a title = '"+value+"' href='${ctx}/assign/form?id=" + row.id + "'>" + manager + "</a>"
                                    + "</nobr>"
                            }else{
                                return "<nobr>" +
                                    "<a href='${ctx}/assign/form?id=" + row.id + "'>" + value + "</a>"
                                    + "</nobr>"
                            }

                        }
                    }, {
                        field: 'relationTaskName',
                        title: '关联任务',
                        width: 100,
                        formatter: function (value, row) {
                            var manager = "";
                            if(value){
                                if (value.length>5){
                                    manager = value.substring(0,5)+"...";
                                    return "<nobr>" +
                                        "<a title = '"+value+"' href='${ctx}/inspection/findTask?relationTask="+row.relationTask+"'>" + manager + "</a>"
                                        + "</nobr>"
                                }else{
                                    return "<nobr>" +
                                        "<a href='${ctx}/inspection/findTask?relationTask="+row.relationTask+"'>" + value + "</a>"
                                        + "</nobr>"
                                }

                            }else {
                                return '';
                            }

                        }
                    },  {
                        field: 'inspectionDate',
                        title: '督查时间',
                        valign : "middle",
                        align : "center",
                        sortable : true,
                        sortName : 'INSPECTION_DATE',
                        width: 200,
                        formatter: function (value, row) {
                            var manager = "";
                            if (row.inspectionDate){
                                manager += row.inspectionDate ;
                            };
                            if(row.inspectionDate&&row.inspectionEndDate){
                                manager += "至";
                            }
                            if (row.inspectionEndDate){
                                manager += row.inspectionEndDate;
                            }
                            return manager;
                        }
                    },{
                        field: 'leadLeaderText',
                        title: '领导',
                        width: 150,
                        formatter: function (value, row) {
                            var manager = "";
                            if (value){
                                var array = value.split(/[,，、]/);
                               if(array.length>1){
                                   manager = array[0] + "等"+array.length+"位领导";
                               }else{
                                   manager = value;
                               }
                            }
                            return manager;
                        }
                    },  {
                        field: 'inspectionRange',
                        title: '被督查单位',
                        width: 150,
                        formatter: function (value, row) {
                            var manager = "";
                            if (value){
                                var array = value.split(/[,，、]/);
                               if (array.length==1){
                                   manager = value;
                               }else {
                                   manager = array[0] + "等"+array.length+"单位";
                               }
                            }
                            return manager;
                        }
                    },  {
                        field: 'bgxs',
                        title: '报告形式',
                        width: 100,
                        formatter : function (value,row) {
                            var manager = "";
                            if (value){
                                if (value.length>5){
                                    manager = "<div style='width: 90px;text-align:left; border: 0px;overflow: hidden; text-overflow:ellipsis' title='" + value + "'><nobr>"
                                        + value.substring(0,5)+"..." + "</nobr></div>";
                                }else{
                                    manager = value;
                                }

                            }
                            return manager;
                        }
                    }, {
                        field: 'status',
                        title: '状态',
                        width: 100,
                        formatter: function (value, row) {
                            var manager = "";
                            if (value){
                                if (value=='01'){
                                    manager = '已落实';
                                }else{
                                    manager = '未落实';
                                }
                            }else{
                                manager = "-"
                            }
                            return manager;
                        }
                    }, {
                        field: 'luoshiDate',
                        title: '落实时间',
                        width: 100,
                        formatter: function (value, row) {
                            if (value == null) {
                                value = "-";
                            }
                            return "<div title='" + value + "' style='text-align:center;text-indent:0;'>" + value + "</div>";
                        }
//                        sortable: true,
//                        sortName: 'UPDATE_DATE'
                    }
                ]
            });
        });


        //设置传入参数
        function queryParams(params) {
            $('#searchForm').find('input[name]').each(function() {
                params[$(this).attr('name')] = $(this).val();
            });
            $('#searchForm').find('select[name]').each(function() {
                params[$(this).attr('name')] = $(this).val();
            });
            return params;
        }
        // 新添
        function add() {
            window.location.href = "${ctx}/assign/form";
        }
        function delect() {
            var rows = $("#table").bootstrapTable("getSelections"),
                ids = [], i = 0;
            if (rows != null && rows.length > 0) {
                for (; i < rows.length; i++) {
                    ids.push(rows[i].id);
                }
            }
            if(rows.length>0){
                confirmx("确认要删除该记录吗?",function () {
                    $.ajax({
                        type: "post",
                        data: '',
                        url: "${ctx}/assign/delete?ids="+ids,
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
        function update(id) {
                window.location.href = "${ctx}/assign/form?id="+id;
        }
        function saveSort() {
            if(confirm("确认保存当前排序吗？")){
                var array = new Array();

                var flag = '1';
                $("table input[type='number']").each(function(){
                    var obj = new Object();
                    obj.id = $(this).attr("id");
                    if ($(this).val()!=null&&$(this).val()!=''){
                        obj.sort = $(this).val();
                        array.push(obj);
                    }else {
                        flag = '0';
                    }
                });
                if (flag=='1'){
                    $.ajax({
                        type: "post",
                        data:{"sortlist":JSON.stringify(array)},
                        dataType: "json",
                        url: "${ctx}/assign/saveSort",
                        cache: false,
                        dataType: "json",
                        success: function (res) {
                            if(res.success=='1'){
                                alertx("保存成功！");
                                $('#table').bootstrapTable('refresh');
                            }else{
                                alertx("操作失败！");
                            }
                        },
                        error: function (res) {
                            alertx("操作失败！");
                        }
                    });
                }else {
                    alertx("请输入序号！");
                }

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
                        ids.push(rows[i].id);
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
                window.location.href="${ctx}/assign/exportExcel?ids="+ids+"&"+decodeParams;
            },'')
        }
    </script>
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
    <style type="text/css">
        #table {
            table-layout: fixed;
        }

        /* 列表长度超出部分以省略号显示样式控制*/
        #table td div {
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
            text-align: left;
            text-indent: 14px;
        }

        /* 列表长度超出部分以省略号显示样式控制 */
    </style>
</head>

<body>
<ul class="breadcrumb">
    <li class="active">交办督查</li>

</ul>
<div>
    <form:form id="searchForm" modelAttribute="specialSupervision" action="${ctx}/assign/list" method="post">
        <div class="controls controls-row">

            <div class="search-div input-prepend input-append margin-left-2">
                <span class="add-on">领导</span>
                <sys:treeselect id="leadLeader" name="leadLeader" value="${table.leadLeader}" labelName="leadLeaderText" hideBtn="true"
                                labelValue="${table.leadLeaderText}" title="领导" url="/sys/leader/leaderTree?type=01" cssClass="required" allowClear="true" />
            </div>
            <div class="search-div input-prepend input-append margin-left-1">
                <span class="add-on">关联任务</span>
                <form:input cssClass="search-input-medium" path="relationTaskName" htmlEscape="false" maxlength="50" />
            </div>
            <div class="search-div input-prepend input-append">
                <span class="add-on">报告形式</span>
                <form:input cssClass="search-input-medium" path="bgxs" htmlEscape="false" maxlength="50" />
            </div>
            <div class="search-div input-prepend input-append">
                <span class="add-on">状态</span>
                <form:select path="status" class="search-select-mini">
                    <option value="">全部</option>
                    <form:options items="${fns:getDictList('YW_DCLSQK')}" itemLabel="chname" itemValue="enname" htmlEscape="false" />
                </form:select>
            </div>
        </div>
        <div class="controls controls-row">
            <div class="search-div input-prepend input-append">
                <span class="add-on">交办事项</span>
                <form:input cssClass="search-input-medium" path="inspectionTask" htmlEscape="false" maxlength="50" />
            </div>

            <div class="search-div input-prepend input-append">
                <span class="add-on">被督查单位</span>
                <form:input cssClass="search-input-medium" path="inspectionRange" htmlEscape="false" maxlength="50" />
            </div>
            <div class="search-div input-prepend input-append">
                <span class="add-on">落实时间</span>
                <input class="search-input-mini" type="text" name="luoshiDate" value="<fmt:formatDate value="${luoshiDate}" pattern="yyyy-MM-dd" />" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
                <span class="add-on">至</span>
                <input class="search-input-mini" type="text" name="luoshiEndDate" value="<fmt:formatDate value="${luoshiEndDate}" pattern="yyyy-MM-dd" />" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
            </div>
            <div class="search-div input-prepend input-append">
                <span class="add-on">年度</span>
                <fmt:parseDate value="${yearTaskTableData.taskYear}" var="taskYear" pattern="yyyy" />
                <input class="search-input-mini" type="text" id="yearNumber" name="yearNumber" value="<fmt:formatDate value="${taskYear}" pattern="yyyy" />" onfocus="WdatePicker({dateFmt:'yyyy'})" />
            </div>
            <input id="search" class="btn btn-primary" type="button" value="查询" />
            <input id="clear" class="btn btn-primary" type="button" value="重置" />
        </div>

    </form:form>
</div>
<div id="toolbar">
    <ul class="nav nav-pills">
        <li><a id="add" onclick="add();"><i class="icon-plus"></i>&nbsp;新增</a></li>
        <%--<li><a id="saveSort" onclick="saveSort()"><i class="icon-plus"></i>&nbsp;保存排序</a></li>--%>
        <%--<li><a onclick="update()"><i class="icon-plus"></i>&nbsp;修改</a></li>--%>
        <li><a onclick="delect();"><i class="icon-trash"></i> &nbsp;删除</a></li>
        <li>
            <a id="exportExcel" onclick="exportExcel()">
                <i class="icon-download"></i> &nbsp;导出台账
            </a>
        </li>
    </ul>
</div>
</div>
</div>
</ul>
</div>
<sys:message content="${message}"/>
<div id="content">
    <table id="table"></table>
</div>
</body>

</html>