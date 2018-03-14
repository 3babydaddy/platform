<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
	<head>
	    <title>婚嫁事前登记列表</title>
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
	                $("#type").val("0");
	            }); 
	            $('#table').tfkjTable({
	                url: '${ctx}/familyMatters/list',
	                queryParams: 'queryParams',
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
	                    }, {
	                        title: '序号',//标题  可不加
	                        formatter : function(value, row, index) {
	                            var pageSize=$('#table').bootstrapTable('getOptions').pageSize;//通过表的#id 可以得到每页多少条
	                            var pageNumber=$('#table').bootstrapTable('getOptions').pageNumber;//通过表的#id 可以得到当前第几页
	                            return pageSize * (pageNumber - 1) + index + 1;    //返回每条的序号： 每页条数 * （当前页 - 1 ）+ 序号
	                        },
	                        width: 40,
	                    }, {
	                        field: 'nameText',
	                        title: '姓名',
	                        width: 100,
	                        formatter: function (value, row) {
	                            var manager = "";
	                            if (value.length>7){
	                                manager = value.substring(0,7)+"...";
	                                return "<nobr>" +
	                                    "<a title = '"+value+"' href='${ctx}/familyMatters/form?id=" + row.id + "'>" + manager + "</a>"
	                                    + "</nobr>"
	                            }else{
	                                return "<nobr>" +
	                                    "<a href='${ctx}/familyMatters/form?id=" + row.id + "'>" + value + "</a>"
	                                    + "</nobr>"
	                            }

	                        }
	                    }, {
	                        field: 'companyText',
	                        title: '单位',
	                        width: 100,
	                        formatter : function (value,row) {
	                            var manager = "";
	                            if (value){
	                                if (value.length>8){
	                                    manager =  "<div  title='" + value + "'><nobr>"
	                                        + value.substring(0,8)+"..." + "</nobr></div>";
	                                }else{
	                                    manager = value;
	                                }
	                            }
	                            return manager;
	                        }
	                    }, {
	                        field: 'post',
	                        title: '职务',
	                        width: 100,
	                        formatter : function (value,row) {
	                            var manager = "";
	                            if (value){
	                                if (value.length>8){
	                                    manager =  "<div  title='" + value + "'><nobr>"
	                                        + value.substring(0,8)+"..." + "</nobr></div>";
	                                }else{
	                                    manager = value;
	                                }
	                            }
	                            return manager;
	                        }
	                    }, {
	                        field: 'idNumber',
	                        title: '身份证号',
	                        width: 150
	                    }, {
	                        field: 'matters',
	                        title: '申报事宜',
	                        width: 150
	                    },{
	                        field: 'holding',
	                        title: '举办方式',
	                        width: 100,
	                        formatter : function (value,row) {
	                            var manager = "";
	                            if (value){
	                                if (value.length>8){
	                                    manager =  "<div  title='" + value + "'><nobr>"
	                                        + value.substring(0,8)+"..." + "</nobr></div>";
	                                	//manager = value.substring(0,8)+"..."
	                                }else{
	                                    manager = value;
	                                }
	                            }
	                            return manager;
	                        }
	                    },  {
	                        field: 'feteTime',
	                        title: '宴请时间',
	                        valign : "middle",
	                        align : "center",
	                        sortable : true,
	                        sortName : 'FR_FETETIME',
	                        width: 100
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
	        
	        //新增
	        function add() {
	            window.location.href = "${ctx}/familyMatters/form";
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
	                        url: "${ctx}/familyMatters/delete?ids="+ids,
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
	             window.location.href="${ctx}/familyMatters/exportExcel?ids="+ids+"&"+decodeParams;
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
		    <li class="active">婚嫁事前登记</li>
		</ul>
		<div>
		    <form:form id="searchForm" modelAttribute="familyMatters" action="${ctx}/familyMatters/list" method="post">
		    	<input type="hidden" id="type" name="type" value="0">
		        <div class="controls controls-row">
		        	<div class="search-div input-prepend input-append">
		                <span class="add-on">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</span>
		                <form:input cssClass="search-input-medium" path="name" htmlEscape="false" maxlength="50" />
		            </div>
		            <div class="search-div input-prepend input-append margin-left-1">
		                <span class="add-on">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位</span>
		                <sys:treeselect id="company" name="company" value="${table.company}" labelName="companyText" labelValue="${table.companyText}" title="参加单位" url="/sys/office/treeData?isAll=true" cssClass="required" allowClear="true" notAllowSelectParent="true" hideBtn="true" />
		            </div>
		            <div class="search-div input-prepend input-append margin-left-1">
		                <span class="add-on">举办方式</span>
		                <form:input cssClass="search-input-medium" path="holding" htmlEscape="false" maxlength="50" />
		            </div>
		        </div>
		        <div class="controls controls-row">
		        	<div class="search-div input-prepend input-append">
		                <span class="add-on">宴请时间</span>
		                <input class="search-input-mini" type="text" name="feteTime" value="<fmt:formatDate value="${feteTime}" pattern="yyyy-MM-dd" />" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
		                <span class="add-on">至</span>
		                <input class="search-input-mini" type="text" name="feteEndTime" value="<fmt:formatDate value="${feteEndTime}" pattern="yyyy-MM-dd" />" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
		            </div>
		            <div class="search-div input-prepend input-append margin-left-1">
			            <input id="search" class="btn btn-primary" type="button" value="查询" />
			            <input id="clear" class="btn btn-primary" type="button" value="重置" />
		            </div>
		        </div>
		    </form:form>
		</div>
		<div id="toolbar">
		    <ul class="nav nav-pills">
		        <li><a id="add" onclick="add();"><i class="icon-plus"></i>&nbsp;新增</a></li>
		        <li><a onclick="delect();"><i class="icon-trash"></i> &nbsp;删除</a></li>
		        <li><a id="export" onclick="exportExcel()"><i class="icon-download"></i>&nbsp;导出台账</a></li>
		    </ul>
		</div>
		<sys:message content="${message}"/>
		<div id="content">
		    <table id="table"></table>
		</div>
	</body>
</html>