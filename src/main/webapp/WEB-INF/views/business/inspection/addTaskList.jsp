<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>年度重点任务督查</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(function() {
        findDictSelect();
        var date = new Date();
        $("#taskYear").val(date.getFullYear());
		$('#search').click(function() {
			$('#table').bootstrapTable('refresh');
		});
		$('#searchInput').keydown(function(event) {
			if (event.keyCode == 13) {
				$('#search').click();
			}
		});
        $("#clear").click(function() {

            var a = $('#searchForm').find('input[name]');
            $('#searchForm').find('input[name]').each(function() {
                $(this).val("");
                $('#table').bootstrapTable('refresh');
            });
        });
		$('#table').tfkjTable({
			url : '${ctx}/inspection/relationlist	',
			queryParams : 'queryParams',
            pagination: false,//分页
			columns : [ [
                {
                    title: '序号',//标题  可不加
                    width: 40,
                    formatter: function (value, row, index) {
                        return index+1;
                    }
                },{
				field : 'id',
				visible : false
			}, {
				field : 'sourceName',
				title : "来源",
				valign : "middle",
				align : "center",
                    width: 150,
                    formatter: function (value, row) {
                        return value;
                    }
			},{
                field : 'agreeMatterName',
                title : "事项",
                valign : "middle",
                align : "center",
                    width: 400,
                    formatter: function (value, row) {
                        var manager = "";
						manager += value;
                        if (row.name){
                            manager += "（"+row.name+"）";
						}

                        return manager;
                    }
            }, {
                    field : '',
                    title : "添加关联",
                    valign : "middle",
                    align : "center",
                    width: 35,
                    formatter:function (value,row) {
                        return "<a style='margin-right: 10px; cursor: pointer;'   onclick=select('" + row.id + "','"+escape(row.agreeMatterName)+"','"+escape(row.sourceName)+"')>关联</a>";
                    }
                }
            ],

			],
			onClickRow : function(row, $element, field) {
				$('#table').bootstrapTable('uncheckAll');
				$('#table').bootstrapTable('check', $element[0].rowIndex - 1);
			},
		});


	});

	function queryParams(params) {
        $('#searchForm').find('input[name]').each(function() {
            params[$(this).attr('name')] = $(this).val();
        });
        $('#searchForm').find('select[name]').each(function() {
            params[$(this).attr('name')] = $(this).val();
        });
        return params;
	}
	function select(taskid,name,source) {
        self.parent.$("#isRelation").val("1");
        self.parent.$("#relationTask").val(taskid);
        self.parent.$("#relationTaskNameId").val(taskid);
        self.parent.$("#relationTaskName").text(unescape(name));
        self.parent.$("#relationTaskNameText").val(unescape(name));
        self.parent.$("#relationTaskNameIs").val("1");
        if (source){
			self.parent.$("#source").val(unescape(source));
		}
        self.parent.$.jBox.close();
        <%--var id = $("#id").val();--%>
		<%--if (id){--%>
                <%--var taskId=taskid;--%>
                <%--$.ajax({--%>
                    <%--type: "post",--%>
                    <%--data: "",--%>
                    <%--url: "${ctx}/inspection/update?id="+id+"&isRelation=1&relationTask="+taskId,--%>
                    <%--dataType: "json",--%>
                    <%--success: function (res) {--%>
                        <%--if(res.success=='1'){--%>
                            <%--alertx("操作成功！");--%>
                        <%--}else{--%>
                            <%--alertx("请刷新后重试！");--%>
                        <%--}--%>
                    <%--},--%>
                    <%--error: function (res) {--%>
                        <%--alertx("error！");--%>
                    <%--}--%>
                <%--});--%>
		<%--}else{--%>
		    <%--alertx("专项督查未保存，请刷新之后重试！");--%>
		<%--}--%>
    }
    /**
     * 下拉框初始化
     */
    function findDictSelect() {
        $.ajax({
            type: "post",
            data: "",
            url: "${ctx}/sys/dict/dictTree?type=SOURCE",
            dataType: "json",
            success: function (res) {
                if(res){
                    $("<option value=''>全部</option>").appendTo($("#source"));
                    $.each(res, function (i, v) {
                        var value ='${table.taskType}';
                        if (value!=null&&value!=''&&value==v.id){
                            $("<option selected='selected' value='" + v.id + "'>" + v.name  + "</option>").appendTo($("#source"));
                        }else{
                            $("<option value='" + v.id + "'>" + v.name  + "</option>").appendTo($("#source"));
                        }
                    });
                }else{
                    alertx("请刷新后重试！");
                }
            },
            error: function (res) {
                alertx("error！");
            }
        });
    }
</script>
</head>
<body style="overflow:hidden;">
	<form:form id="searchForm" cssStyle="overflow:hidden;" modelAttribute="query" action="${ctx}/inspection/relationlist" method="post" style="margin:0px;">
		<div id="searchbar" class="form-search breadcrumb">
			<input type="hidden" id="id" name="id" value="${id}">
			<div class="input-prepend">
				<span class="add-on">年度</span>
				<fmt:parseDate value="${taskYear}" var="taskYear" pattern="yyyy" />
				<input style="width:100px;" class="input1" type="text" id="taskYear" name="taskYear" value="<fmt:formatDate value="${taskYear}" pattern="yyyy" />" onfocus="WdatePicker({dateFmt:'yyyy'})" />
			</div>
			<div class="input-prepend">
				<span class="add-on">来源</span>
				<select id="source" name="source" style="width: 120px">
				</select>
			</div>
			<div class="input-prepend">
				<span class="add-on" style="width: 100px">事项</span>
				<input id="agreeMatterName" name="agreeMatterName" class="input-large" type="text"/>
			</div>
		</div>
		<input id="search" class="btn btn-primary" type="button" value="查询" />
		<%--<input id="clear" class="btn btn-primary" type="button" value="重置" />--%>
	</form:form>

	<div id="content" >
		<table id="table"></table>
	</div>
</body>
</html>
