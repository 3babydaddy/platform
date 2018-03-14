<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <style type="text/css">
        .benjieCon {
            display: inline-block;
            border: 2px solid red;
            width: 70%;
            padding-left: 10px;
            padding-top: 10px;
            padding-bottom: 10px;
            margin-left: 11px;
            margin-bottom: 11px;
        }
        .a-upload {
            padding: 4px 10px;
            height: 20px;
            line-height: 20px;
            position: relative;
            cursor: pointer;
            color: #888;
            background: #fafafa;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
            display: inline-block;
            *display: inline;
            *zoom: 1
        }

        .a-upload  input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
            filter: alpha(opacity=0);
            cursor: pointer
        }

        .a-upload:hover {
            color: #444;
            background: #eee;
            border-color: #ccc;
            text-decoration: none
        }
    </style>
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
        $(function() {
            var xctbUpload = "${table.xctbUploadUrl}";
            uploadManage(xctbUpload,"xctbUpload");
            var ldpsUpload = "${table.ldpsUploadUrl}";
            uploadManage(ldpsUpload,"ldpsUpload");
            var scqdUpload = "${table.scqdUploadUrl}";
            uploadManage(scqdUpload,"scqdUpload");
            var bgxsUpload = "${table.bgxsUploadUrl}";
            uploadManage(bgxsUpload,"bgxsUpload");
            isRelation();



        });

        /**
         * 控制上传附件的显示和隐藏
         * @param value
         * @param name
         */
        function uploadManage(value,name) {
            if (value!=null&&value!=''){
                $("#"+name+"Div").show();
                $("#"+name+"Btn").hide();
            }else{
                var showId = name+"A";
                $("#"+name+"Div").hide();
                $("#"+name+"Btn").show();
                $("#"+showId).html("");
                $("#"+name+"Url").val("");
                $("#"+showId).attr("href","");
                $("#"+showId).attr("url","");
            }

        }

        /**
         * 保存方法
         */
        function save() {
            var inspectionTask = $("#inspectionTask").val();
            if (inspectionTask){
                var inspectionDate = $("#inspectionDate").val();
                if (inspectionDate==null||inspectionDate==''){
                    alertx("督查时间不能为空！");
                    return
                }
                var form = $("form").serializeArray();
                var obj = {};
                $.each(form, function (i, v) {
                    obj[v.name] = v.value;
                });
                $.ajax({
                    type: "post",
                    data: obj,
                    url: "${ctx}/track/save",
                    dataType: "json",
                    success: function (res) {
                        if(res.success=='1'){
                            $("#id").val(res.id);
                            alertx("保存成功！");
                            window.location.href = "${ctx}/track/index";
                        }else{
                            alertx("操作失败！");
                        }
                    },
                    error: function () {
                        alertx("error！");
                    }
                });
            }else{
                alertx("督查事项不能为空！");
                return
            }

        }

        /**
         * 添加关联按钮
         */
        function addTask() {
            var id = $("#id").val();
            $.jBox("iframe:${ctx}/inspection/addTaskList?id="+id, {
                title: "添加关联任务",
                width: 800,
                height:550,

                buttons: { }, // no buttons
                showScrolling : false,
                dragLimit: true,
                submit: function (v, h, f) {

                },
                // 点击状态按钮后的回调函数，返回true时表示关闭窗口，    参数有三个，v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
                // opacity: 0, /* 窗口隔离层的透明度,如果设置为0,则不显示隔离层，即遮罩层，设置为0时，点击弹框意外位置不会关闭弹窗，有弹窗时无法操作弹窗外的内容。*/
                closed:function (){
                    isRelation();

                },
                persistent: true /*在显示隔离层的情况下，点击隔离层时，是否坚持窗口不关闭 */
            });
        }

        /**
         * 控制关联按钮变换
         */
        function isRelation() {
            var isRelation = $("#isRelation").val();
//            var  relationTaskNameIs  = $("#relationTaskNameIs").val();
//            var  relationTaskNameText  = $("#relationTaskNameText").val();
//            var  relationTaskNameId  = $("#relationTaskNameId").val();
//            if (relationTaskNameIs&&relationTaskNameText){
//                isRelation= relationTaskNameIs;
//            }
//            if(relationTaskNameId){
//                $("#relationTask").val(relationTaskNameId);
//            }
            if (isRelation == '1'){
                $("#addTask").hide();
                var name = $("#relationTaskNameText").val();
                if (name){
                    $("#relationTaskName").text(name);
                }
                $("#findTask").show();
            }else {
                $("#addTask").show();
                $("#findTask").hide();
            }
        }

        /**
         * 删除关联按钮
         */
        function delectTask() {
            confirmx("确认删除关联任务吗？",function () {
                $("#isRelation").val("0");
                $("#relationTask").val("");
               $("#relationTaskNameIs").val("");
                $("#relationTaskNameText").val("");
                $("#source").val("");
                isRelation();
            })

        }


        /**
         * 点击上传事件
         * @param file
         * @returns {boolean}
         */
        function uploadFile(file){
            var name = file.name;
            var showId = file.name+"A";
            $.ajaxFileUpload({
                url: '${ctx}/file/upFile', //用于文件上传的服务器端请求地址
                secureuri: false, //一般设置为false
                fileElementId: file, //文件上传空间的id属性  <input type="file" id="file" name="file" />
                dataType: 'json', //返回值类型 一般设置为json
                type:"post",
                success: function(res){
                    if(res.success){
                        //返回路径
                        var returnPath=res.returnPath;
                        //展示名
                        showFileName(showId,name,res.showName,returnPath);

                    }else{
                        var message = res.message;
                        alertx(message);
                    }
                },
                error:function(data, status, e){

                    flag=0;
                    alertx("上传文件失败！");
                }
            });
            return false;
        }

        /**
         * 上传成功之后的回显
         * @param showId
         * @param name
         * @param showName
         * @param returnPath
         */
        function showFileName(showId,name,showName,returnPath) {
            $("#"+name+"Div").show();
            $("#"+name+"Btn").hide();
            $("#"+name+"Url").val(returnPath);
            $("#"+showId).html(showName);
            $("#"+showId).attr("href",returnPath);
            $("#"+showId).attr("url",returnPath);
        }

        /**
         * 删除附件
         * @param file
         */
        function delFile(file) {
            var name = file;
            var showId = file+"A";
            $("#"+name+"Div").hide();
            $("#"+name+"Btn").show();
            $("#"+showId).html("");
            $("#"+name+"Url").val("");
            $("#"+showId).attr("href","");
            $("#"+showId).attr("url","");
        }

        function findTask() {
            var relationTask = $("#relationTask").val();
            window.location.href = "${ctx}/inspection/findTask?relationTask="+relationTask;
        }
    </script>
</head>
<body>
<div style="display: none">
    <input type="text" id="relationTaskNameIs" name="relationTaskNameIs">
    <input type="text" id="relationTaskNameId" name="relationTaskNameId">
    <input type="text" id="relationTaskNameText" name="relationTaskNameText" >
</div>

<div id="toolbar">
    <ul class="nav nav-pills">
        <li><a onclick="save();"><i class="icon-save"></i>&nbsp;保存</a></li>
        <li>
            <a href="javascript:history.back(-1)">
                <i class="icon-reply"></i> 返回
            </a>

    </ul>
</div>
<div >
    <form id="inspectionForm" class="form-horizontal">
        <input type="hidden" id="id" name="id" value="${table.id}">
        <div style="display: none">
            <input type="text" id="isRelation" name="isRelation" value="${table.isRelation}">
            <input type="text" id="relationTask" name="relationTask" value="${table.relationTask}">
        </div>
        <div class="control-group">
            <label class="control-label" >关联</label>
            <div class="controls" >
                <div id="addTask">
                        <ul class="nav nav-pills">
                    <a class="qtupload" style="cursor: pointer;" onclick="addTask()">关联任务</a></li>
                        </ul>
                </div>
                <div id="findTask">
                    <ul class="nav nav-pills">
                    <a class="" style="cursor: pointer;" id="relationTaskName" onclick="findTask()">${table.relationTaskName}</a></li>
                    <a class="qtupload"style="cursor: pointer;overflow:inherit" onclick="delectTask()">删除</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" >来源</label>
            <div class="controls" >
                <input class="input" type="text" id="source" name="source" value="${table.source}">
            </div>
        </div>


        <div class="control-group">
            <label class="control-label" >督查时间</label>
            <div class="controls" >
                <fmt:parseDate value="${table.inspectionDate}" var="inspectionDate"/>
                <input type="text" id="inspectionDate" name="inspectionDate"
                       value="<fmt:formatDate value="${inspectionDate}" pattern="yyyy-MM-dd" />" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                <fmt:parseDate value="${table.inspectionEndDate}" var="inspectionEndDate"/>至
                <input type="text" id="inspectionEndDate" name="inspectionEndDate"
                       value="<fmt:formatDate value="${inspectionEndDate}" pattern="yyyy-MM-dd" />" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
            </div>
            <div style="margin-top:20px;">
                <label class="control-label" >督查事项</label>
                <div class="controls" >
                    <textarea rows="5" cols="" id="inspectionTask" name="inspectionTask"
                              style="width: 630px">${table.inspectionTask}</textarea>
                </div>
            </div>
        </div>


        <div class="control-group">
            <label class="control-label" >被督查单位</label>
            <div class="controls" >
                <sys:officeTreeFileTime id="inspectionRange" leftText2="上传督查专函" leftText3="上传回复报告" isShowEndTime="true" name="inspectionRangeList" value="${table.inspectionRangeList}" title="单位"
                                        url="/sys/office/treeData" checked="true"  allowInput="true" notAllowSelectParent="true" input="meeting${fns:getUuId()}" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" >报告形式</label>
            <div class="controls" >
                <input style="width: 320px" type="text" id="bgxs" name="bgxs" value="${table.bgxs}">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" >上传报告</label>
            <div class="controls" >
                    <sys:upFIle input="operatorFile${fns:getUuId()}"  type="files"  name="bgxsUploadUrl"  value="${table.bgxsUploadUrl}"  uploadPath="/file" selectMultiple="false" maxWidth="100" maxHeight="100" text="上传"/>
            </div>
            <div style="margin-top:20px;">
                <label class="control-label" >上传清单</label>
                <div class="controls" >
                    <sys:upFIle input="operatorFile${fns:getUuId()}"  type="files"  name="scqdUploadUrl"  value="${table.scqdUploadUrl}"  uploadPath="/file" selectMultiple="false" maxWidth="100" maxHeight="100" text="上传"/>
                </div>
            </div>
        </div>



        <div class="control-group">
            <label class="control-label" >状态</label>
            <div class="controls" >
                <span style="margin-left:10px;"><input type="radio" name="status" value="02" <c:if test="${table.status eq '02' ||table.status ==null }"> checked="checked"</c:if>> 未落实</span>
                <span style="margin-left:10px;"><input type="radio" <c:if test="${table.status eq '01'}"> checked="checked"</c:if> name="status" value="01"> 已落实</span>
            </div>
            <div style="margin-top:20px;">
                <label class="control-label" >落实时间</label>
                <div class="controls" >
                    <fmt:parseDate value="${table.luoshiDate}" var="luoshiDate"/>

                    <input  type="text" id="luoshiDate" name="luoshiDate"
                           value="<fmt:formatDate value="${luoshiDate}" pattern="yyyy-MM-dd"/>" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                </div>
            </div>
        </div>
    </form>


</div>
</body>
</html>