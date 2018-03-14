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

            init();
        });


        /**
         * 保存方法
         */
        function save() {

                var array = [];
                var form = $("form").serializeArray();
                var obj = {};
                $.each(form, function (i, v) {
                    if (v.value){
                        obj[v.name] = v.value+" ";
                    }else {
                        obj[v.name] ="''";
                    }
                });
                array.push(obj);
                $.ajax({
                    type: "post",
                    data: {"list":JSON.stringify(array)},
                    url: "${ctx}/reminders/update?form="+form,
                    dataType: "json",
                    success: function (res) {
                        if(res.success=='1'){
                            $("#id").val(res.id);
                            alertx("保存成功！");
                        }else{
                            alertx("操作失败！");
                        }
                    },
                    error: function () {
                        alertx("error！");
                    }
                });
        }

        /**
         * @param filename
         * @param filenumber
         * @param msg
         * @param date
         * @param lsqk
         * @param id
         */
        function addArea(filename,filenumber,msg,date,lsqk,id,in0012,in0013,in0014) {

            debugger
            var mydate = new Date();
            var uuid = "cms"+mydate.getDay()+ mydate.getHours()+ mydate.getMinutes()+mydate.getSeconds()+mydate.getMilliseconds()+ Math.round(Math.random() * 10000)
            var newRow='' +
                '<div id="div'+uuid+'" >' +
                    '<div class="control-group">'+
                        '<label class="control-label" >文件名:</label>' +
                        '<div class="controls" > ' +
                            '<label style="width: 630px" >'+unescape(filename)+'</label> ' +
                        '</div>' +
                    '</div>'+
                    '<div class="control-group">'+
                        '<label class="control-label" >文件号:</label>' +
                        '<div class="controls" > ' +
                         '<label style="width: 630px">'+unescape(filenumber)+'</label> ' +
                         '</div>' +
                    '</div>'+
                '<div class="control-group">'+
                    '<label class="control-label" >批示内容:</label>' +
                    '<div class="controls" > ' +
                    '<label style="width: 630px" >'+unescape(msg)+'</label> ' +
                    '</div>' +
                '</div>'+
                '<div class="control-group">'+
                    '<label class="control-label" >批示日期:</label>' +
                    '<div class="controls" > ' +
                    '<label >'+date+'</label> ' +
                    '</div>' +
                '</div>'+

                '<div class="control-group">'+
                '<label class="control-label" >是否超期:</label>' +
                '<div class="controls" > ' +
                '<select class="control-label" name="in0003'+id+'">' ;

            if (in0013=='02'){
                newRow+='<option value="02 " selected=selected>是</option>' +
                    '<option value="01">否</option>' ;
            }else {
                newRow+='<option value="02 ">是</option>' +
                    '<option value="01"  selected=selected>否</option>' ;
            }
            newRow += '</select> ' +
                '</div>' +
                '</div>'+

                '<div class="control-group">'+
                    '<label class="control-label" >办理情况:</label>' +
                    '<div class="controls" > ' +
                    '<select class="control-label" name="in0002'+id+'">' ;
            if (in0012=='01'){
                newRow +=  '<option value="01" selected=selected>办理中</option><option value="02">已办结</option><option value="03">已转办</option></select> ';
            }else if(in0012=='02'){
                newRow +=  '<option value="01" >办理中</option><option value="02" selected=selected >已办结</option><option value="03">已转办</option></select> ';
            }else if(in0012=='03'){
                newRow +=  '<option value="01" >办理中</option><option value="02">已办结</option><option selected=selected value="03">已转办</option></select> ';
            }else{
                newRow +=  '<option value="01" >办理中</option><option value="02"  >已办结</option><option value="03">已转办</option></select> ';
            }
               newRow+=  '</div>' +
                '</div>'+
                '<div class="control-group">'+
                '<label class="control-label" >落实及上报情况:</label>' +
                '<div class="controls" > ' +
                '<textarea name="in0004'+id+'" rows="5" style="width: 630px">'+unescape(in0014)+'</textarea>' +
                '</div>' +
                '</div>'+
//                '<a class="qtupload" onclick=delRow("' + uuid + '")>删除</a>';
                '</div>';


            $("#area").append(newRow);
        }

        function init() {
            <c:forEach items="${listElement}" var="t">

                addArea(escape("${t.parentIn0001}"),escape("${t.parentIn0002}"),escape("${t.parentIn0003}"),"${t.parentIn0004Text}","${t.parentIn0014}","${t.id}","${t.parentIn0012}","${t.parentIn0013}",escape("${t.parentIn0014}"));

            </c:forEach>
        }
        function delRow(rowIndex){
            confirmx("确认删除关联吗？",function () {
                $("#div"+rowIndex).remove();
            })

        }
    </script>
</head>
<body>

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
        <input type="hidden" id="unqId" name="unqId" value="${unqId}">

        <div class="control-group">
            <c:choose>
                <c:when test="${type=='1'}">
                    <label class="control-label" >责任领导</label>
                    <div class="controls" >
                        <label>${leaderName}</label>
                    </div>
                </c:when>
                <c:otherwise>
                    <label class="control-label" >承办单位</label>
                    <div class="controls" >
                        <label>${officeName}</label>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>


        <div class="control-group">
                <label class="control-label" >催办时间</label>
                <div class="controls" >
                    <label>${remindersDate}</label>

                </div>
            <h5 style="margin-top:20px;margin-left: 45px;">批示件：</h5>
        <div id="area">

        </div>

        <ul class="nav nav-pills">
            <%--<a class="qtupload" style="cursor: pointer;" onclick="addArea()">关联任务</a></li>--%>
        </ul>




</div>
    </form>


</div>
</body>
</html>