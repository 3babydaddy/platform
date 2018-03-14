<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>管理专报</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(function() {
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
			 url: '${ctx}/specialReport/list',
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
			},
			{
                field: 'reportName',
                title: '名称',
                width: 100,
                formatter: function (value, row) {
                    var manager = "";
                    if (value.length>5){
                        manager = value.substring(0,5)+"...";
                        return "<nobr>" + manager + "</nobr>"
                    }else{
                        return "<nobr>" + value +"</nobr>"
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
            }, 
             {
                field : '',
                title : "添加关联",
                valign : "middle",
                align : "center",
                width: 35,
                formatter:function (value,row) {
                    return "<a style='margin-right: 10px; cursor: pointer;'   onclick=select('" + row.id + "')>关联</a>";
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
	function select(relateId) {
		if (relateId!=null && relateId!=''){
			$.ajax({
				type : "post",
				url : "${ctx}/ywgl/instructions/relate?parentIds=${parentIds}&relateId="+relateId,
				cache : false,
				success : function(res) {
					self.parent.$('#table').bootstrapTable('refresh');
					self.parent.$.jBox.close();
				},
				error : function(res) {
					alertx("关联失败！");
				}
			});
		}else{
		    alertx("请选择要关联的任务！");
		}
    }

</script>
</head>
<body >
<form:form id="searchForm" modelAttribute="query" action="${ctx}/instructions/relationlist" method="post" style="margin:0px;">
<div class="controls controls-row">
	<input type="hidden" id="id" name="id" value="${id}">
	
	<div class="search-div input-prepend input-append">
		<span class="add-on">名称</span>
		<input id="reportName" name="reportName" class="input-large" type="text"/>
	</div>
	<div class="search-div input-prepend input-append">
		<span class="add-on">签发时间</span>
		<input class="search-input-mini" type="text" name="lssueDate" value="<fmt:formatDate value="${lssueDate}" pattern="yyyy-MM-dd" />" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
	</div>
	<div class="search-div input-prepend input-append">
		<span class="add-on">内容简介</span>
		<input id="msg" name="msg" class="input-large" type="text"/>
	</div>
<input id="search" class="btn btn-primary" type="button" value="查询" />
</div>
</form:form>
	<div id="content" style="overflow:hidden;overflow-x: hidden; overflow-y: auto;">
		<table id="table"></table>
	</div>
</body>
</html>
