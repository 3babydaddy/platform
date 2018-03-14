<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>角色管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#name").focus();
            $("#inputForm").validate({
                rules: {
                    name: {remote: "${ctx}/sys/role/checkName?oldName=" + encodeURIComponent("${role.name}")}
                },
                messages: {
                    name: {remote: "角色名已存在"}
                },
                submitHandler: function(form){
                    var ids = [], nodes = tree.getCheckedNodes(true);
                    for(var i=0; i<nodes.length; i++) {
                        ids.push(nodes[i].id);
                    }
                    $("#menuIds").val(ids);
                    var ids2 = [], nodes2 = tree2.getCheckedNodes(true);
                    for(var i=0; i<nodes2.length; i++) {
                        ids2.push(nodes2[i].id);
                    }
                    $("#officeIds").val(ids2);
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });

            var setting = {check:{enable:true,nocheckInherit:true},view:{selectedMulti:false},
                    data:{simpleData:{enable:true}},callback:{beforeClick:function(id, node){
                        tree.checkNode(node, !node.checked, true, true);
                        return false;
                    }}};
            
            // 用户-菜单
            var zNodes=[
                    <c:forEach items="${menuList}" var="menu">{id:"${menu.id}", pId:"${not empty menu.parent.id?menu.parent.id:0}", name:"${not empty menu.parent.id?menu.name:'权限列表'}"},
                    </c:forEach>];
            // 初始化树结构
            var tree = $.fn.zTree.init($("#menuTree"), setting, zNodes);
            // 不选择父节点
            tree.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
            // 默认选择节点
            var ids = "${role.menuIds}".split(",");
            for(var i=0; i<ids.length; i++) {
                var node = tree.getNodeByParam("id", ids[i]);
                try{tree.checkNode(node, true, false);}catch(e){}
            }
            // 默认展开全部节点
            tree.expandAll(true);
            
            // 用户-单位
            var zNodes2=[
                    <c:forEach items="${officeList}" var="office">{id:"${office.id}", pId:"${not empty office.parent?office.parent.id:0}", name:"${office.name}"},
                    </c:forEach>];
            // 初始化树结构
            var tree2 = $.fn.zTree.init($("#officeTree"), setting, zNodes2);
            // 不选择父节点
            tree2.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
            // 默认选择节点
            var ids2 = "${role.officeIds}".split(",");
            for(var i=0; i<ids2.length; i++) {
                var node = tree2.getNodeByParam("id", ids2[i]);
                try{tree2.checkNode(node, true, false);}catch(e){}
            }
            // 默认展开全部节点
            tree2.expandAll(true);
            // 刷新（显示/隐藏）单位
            refreshOfficeTree();
            $("#dataType").change(function(){
                refreshOfficeTree();
            });
            $("textarea").attr("onkeyup","return isMaxLen(this)");
        });
        function refreshOfficeTree(){
            if($("#dataType").val()==9){
                $("#officeTree").show();
            }else{
                $("#officeTree").hide();
            }
        }
      	//在IE8下对textarea的字数长度限制的函数
		function isMaxLen(o){
			var nMaxLen=o.getAttribute ? parseInt(o.getAttribute("maxlength")) : "";  
			if(o.getAttribute && o.value.length>nMaxLen){  
				o.value=o.value.substring(0,nMaxLen)  
			}
		}
    </script>
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
</head>
<body>
    <ul class="breadcrumb">
        <li><a href="${ctx}/sys/role/">角色列表</a></li>
        <li><span class="divider">/</span></li>
        <li class="active"><a href="${ctx}/sys/role/form?id=${role.id}">角色<shiro:hasPermission name="sys:role:edit">${not empty role.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:role:edit">查看</shiro:lacksPermission></a></li>
    </ul><br/>
    <form:form id="inputForm" modelAttribute="role" action="${ctx}/sys/role/save" method="post" class="form-horizontal">
        <form:hidden path="id"/>
        <sys:message content="${message}"/>
        <div class="control-group">
            <label class="control-label">所属单位:</label>
            <div class="controls">
                <sys:treeselect id="office" name="office.id" value="${role.office.id}" labelName="office.name" labelValue="${role.office.name}"
                    title="单位" url="/sys/office/treeData"  isAll="true" notAllowSelectParent="true" cssClass="required"/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">角色名称:</label>
            <div class="controls">
                <input id="oldName" name="oldName" type="hidden" value="${role.name}">
                <form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
                <span class="help-inline"><font color="red">*</font> </span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">是否可用</label>
            <div class="controls">
                <form:select path="stateFlag">
                    <form:options items="${fns:getDictList('yes_no')}" itemLabel="chname" itemValue="enname" htmlEscape="false"/>
                </form:select>
                <span class="help-inline">“是”代表此数据可用，“否”则表示此数据不可用</span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">角色类型:</label>
            <div class="controls">
                <form:select path="funcType">
                    <form:options items="${fns:getDictList('sys_user_type')}" itemLabel="chname" itemValue="enname" htmlEscape="false"/>
                </form:select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">数据权限:</label>
            <div class="controls">
                <form:select path="dataType">
                    <form:options items="${fns:getDictList('sys_data_scope')}" itemLabel="chname" itemValue="enname" htmlEscape="false"/>
                </form:select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">角色授权:</label>
            <div class="controls">
                <div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div>
                <form:hidden path="menuIds"/>
                <div id="officeTree" class="ztree" style="margin-left:100px;margin-top:3px;float:left;"></div>
                <form:hidden path="officeIds"/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">备注:</label>
            <div class="controls">
                <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
            </div>
        </div>
        <div class="form-actions">
            <shiro:hasPermission name="sys:role:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" style="outline:none;"/>&nbsp;</shiro:hasPermission>
            <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)" style="outline:none;"/>
        </div>
    </form:form>
</body>
</html>