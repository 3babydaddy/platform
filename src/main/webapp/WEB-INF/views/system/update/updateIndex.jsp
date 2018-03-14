<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>系统升级</title>
    <meta name="decorator" content="default" />
    <script type="text/javascript">
        
    </script>
</head>
<body>
    <ul class="breadcrumb">
        <li class="active">系统升级</li>
        <a href="/">撒地方</a>
    </ul>
    <div id="content">
        <form:form id="inputForm" modelAttribute="update" action="${ctx}/sys/update/execute" method="post" class="form-horizontal">
        <div class="control-group">
            <label class="control-label">头像:</label>
            <div class="controls">
                <form:hidden id="updateZip" path="path" htmlEscape="false" maxlength="255" class="input-xlarge"/>
                <sys:ckfinder input="updateZip" type="files" uploadPath="/updateZip" selectMultiple="false" maxWidth="100" maxHeight="100"/>
            </div> 
        </div>
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
    </form:form>
    </div>
</body>
</html>