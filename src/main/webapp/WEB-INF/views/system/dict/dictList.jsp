<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>字典管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
    $(document).ready(function() {
        $("#btnImport").click(function(){
            $.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
                bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
        });
    });
    </script>
</head>
<body>
    <div id="importBox" class="hide">
        <form id="importForm" action="${ctx}/sys/dict/import" method="post" enctype="multipart/form-data"
            class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
            <input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
            <input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
            <a href="${ctx}/sys/dict/import/template">下载模板</a>
        </form>
    </div>
    <ul class="breadcrumb">
        <li class="active">字典</li>
    </ul>
    <div id="toolbar">
        <ul class="nav nav-pills">
            <li><a id="xinzeng" href="${ctx}/sys/dict/form?typeEnname=${dict.typeEnname}"><i class="icon-plus"></i>&nbsp;新增</a></li>
            <li><a id="btnImport" href="javascript:void(0);"><i class="icon-plus"></i>&nbsp;导入</a></li>
        </ul>
    </div>
    <div id="content">
        <table id="contentTable" class="table table-striped table-bordered table-condensed">
            <thead>
                <tr>
                    <th>中文名</th>
                    <th>保存值</th>
                    <th>排序</th>
                    <shiro:hasPermission name="sys:dict:edit">
                        <th>操作</th>
                    </shiro:hasPermission>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${dictList}" var="dict">
                <tr>
                    <td>${dict.chname}</td>
                    <td><a href="${ctx}/sys/dict/form?id=${dict.id}">${dict.enname}</a></td>
                    <td>${dict.sort}</td>
                    <shiro:hasPermission name="sys:dict:edit"><td>
                        <a href="${ctx}/sys/dict/form?id=${dict.id}">修改</a>
                        <a href="${ctx}/sys/dict/delete?id=${dict.id}" onclick="return confirmx('确认要删除该字典项吗？', this.href)">删除</a>
                    </td></shiro:hasPermission>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>