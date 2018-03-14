<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>字典类型管理</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treetable.jsp"%>
<script type="text/javascript">
    $(function() {
        var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
        var data = ${fns:toJson(list)}, rootId = "${not empty dictType.id ? dictType.id : '0'}";
        addRow("#treeTableList", tpl, data, rootId, true);
        $("#treeTable").treeTable({expandLevel : 5});
    });
    function addRow(list, tpl, data, pid, root){
        for (var i=0; i<data.length; i++){
            var row = data[i];
            if ((${fns:jsGetVal('row.parentId')}) == pid){
                $(list).append(Mustache.render(tpl, 
                    {
                        pid: (root?0:pid), 
                        row: row,
                        dict: {
                            type: getDictChname(${fns:toJson(fns:getDictList('sys_dict_type'))}, row.type)
                        }
                    }
                ));
                addRow(list, tpl, data, row.id);
            }
        }
    }
    $(function() {
        $('#search').click(function() {
            var chname=$('#chname').val();
            window.location.href="${ctx}/sys/dictType/list?chname="+chname;
        });})
</script>
</head>
<body>
   <!-- <ul class="breadcrumb">
        <li class="active">字典类型列表</li>
         <div  class="rightMove form-search breadcrumb">
            <div class="input-prepend">
                <input id="chname" name="chname" class="input-small" type="text" />
            </div>
            <a id="search" class="btn btn-primary" href="javascript:void(0)"><i
                class="icon-search"></i></a>
        </div> 
    </ul>-->
    <sys:message content="${message}" />
    <table id="treeTable" class="table table-striped table-bordered table-condensed">
        <thead>
            <tr>
                <th>名称</th>
                <th>保存值</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody id="treeTableList"></tbody>
    </table>
    <script type="text/template" id="treeTableTpl">
        <tr id="{{row.id}}" pId="{{pid}}">
            <td><a href="${ctx}/sys/dictType/form?id={{row.id}}">{{row.chname}}</a></td>
            <td>{{row.enname}}</td>
            <td>
                <a href="${ctx}/sys/dictType/form?id={{row.id}}">修改</a>
                <a href="${ctx}/sys/dictType/delete?id={{row.id}}" onclick="return confirmx('要删除该{{dict.type}}吗？', this.href)">删除</a>
                <a href='${ctx}/sys/dictType/form'>添加</a>
            </td>
        </tr>
    </script>
</body>
</html>