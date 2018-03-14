<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>

<head>
    <title>专报列表</title>
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
                url: '${ctx}/specialReport/list',
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
                        field: 'reportName',
                        title: '名称',
                        width: 100,
                        formatter: function (value, row) {
                            var manager = "";
                            if (value.length>5){
                                manager = value.substring(0,5)+"...";
                                return "<nobr>" +
                                    "<a title = '"+value+"' href='${ctx}/specialReport/form?id=" + row.id + "'>" + manager + "</a>"
                                    + "</nobr>"
                            }else{
                                return "<nobr>" +
                                    "<a href='${ctx}/specialReport/form?id=" + row.id + "'>" + value + "</a>"
                                    + "</nobr>"
                            }

                        }
                    }, {
                        field: 'lssueDate',
                        title: '签发时间',
                        valign : "middle",
                        align : "center",
                        sortable : true,
                        sortName : 'LSSUE_DATE',
                        width: 100,
                    },{
                        field: 'number',
                        title: '期数',
                        width: 150,
                    },  {
                        field: 'msg',
                        title: '内容简介',
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
            window.location.href = "${ctx}/specialReport/form";
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
                        url: "${ctx}/specialReport/delete?ids="+ids,
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
                window.location.href = "${ctx}/specialReport/form?id="+id;
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
                        url: "${ctx}/specialReport/saveSort",
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
                window.location.href="${ctx}/specialReport/exportExcel?ids="+ids+"&"+decodeParams;
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
    <li class="active">专报</li>
</ul>
<div>
    <form:form id="searchForm" modelAttribute="specialReport" action="${ctx}/specialReport/list" method="post">
        <div class="controls controls-row">
            <div class="search-div input-prepend input-append">
                <span class="add-on">名称</span>
                <form:input cssClass="search-input-medium" path="reportName" htmlEscape="false" maxlength="50" />
            </div>
            <div class="search-div input-prepend input-append">
                <span class="add-on">期数</span>
                <form:input cssClass="search-input-medium" path="number" htmlEscape="false" maxlength="50" />

            </div>
            <div class="search-div input-prepend input-append">
                <span class="add-on">内容简介</span>
                <form:input cssClass="search-input-medium" path="msg" htmlEscape="false" maxlength="50" />
            </div>
            <div class="search-div input-prepend input-append margin-left-1">
                <span class="add-on">签发时间</span>
                <input class="search-input-mini" type="text" name="lssueDate" value="<fmt:formatDate value="${lssueDate}" pattern="yyyy-MM-dd" />" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
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