<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ include file="/WEB-INF/views/include/taglib.jsp" %>
        <html>

        <head>
            <title>节假日管理</title>
            <meta name="decorator" content="default" />
             <script type="text/javascript">
                $(function () {
                    var time = new Date().getFullYear();
                    $('#year').val(time);
                });
            </script>
            <script type="text/javascript">
                $(document).ready(function () {
                    $('#search').click(function () {
                        $('#table').bootstrapTable('refresh');
                    });
                    $('#table').tfkjTable({
                        url: "${ctx}/system/holiday/list",
                        queryParams: 'queryParams',
                        pagination: false,
                        columns: [{
                            field: 'name',
                            title: '节日名称',
                            width: 170,
                            cellStyle : function(value,row){
								return {
									css : {
										"text-align" : "left",
										"text-indent" : "14px"
									}
								}
							},
                            formatter: function (value, row) {
                                return "<a title="+value+" href='${ctx}/system/holiday/form?id=" + row.id + "'>" + value + "</a>";
                            }
                        }, {
                            title: '放假时间',
                            formatter: function (value, row) {
                                if (row.beginDate == row.endDate) {
                                    return "<div title="+row.beginDate+">"+row.beginDate+"</div>";
                                }
                                if (row.beginDate == null && row.endDate != null) {
                                    return "<div title="+row.endDate+">"+row.endDate+"</div>";
                                }
                                if (row.endDate == null && row.beginDate != null) {
                                    return "<div title="+row.exchangeDate1+">"+row.exchangeDate1+"</div>";
                                }
                                if (row.beginDate != null && row.endDate != null) {
                                    return "<div title='"+row.beginDate+" 至"+row.endDate+"'>"+row.beginDate + " 至 " + row.endDate+"</div>";
                                }

                            }
                        }, {
                            title: '调休上班时间',
                            formatter: function (value, row) {
                                if (row.exchangeDate1 == row.exchangeDate2 && row.exchangeDate1 != null) {
                                    return "<div title="+row.exchangeDate2+">"+row.exchangeDate2+"</div>";
                                }
                                if (row.exchangeDate1 == null && row.exchangeDate2 == null) {
                                    return "<div title='无调休'>无调休</div>";
                                }
                                if (row.exchangeDate1 == null && row.exchangeDate2 != null) {
                                    return "<div title="+row.exchangeDate2+">"+row.exchangeDate2+"</div>";
                                }
                                if (row.exchangeDate2 == null && row.exchangeDate1 != null) {
                                    return "<div title="+row.exchangeDate1+">"+row.exchangeDate1+"</div>";
                                }
                                if (row.exchangeDate1 != null && row.exchangeDate2 != null) {
                                    return "<div title='"+row.exchangeDate1+"、  "+row.exchangeDate2+"'>"+row.exchangeDate1 + " 、 " + row.exchangeDate2+"</div>";
                                }

                            }
                        }, {
                            title: '操作',
                            width: 100,
                            formatter: function (value, row) {
                                return '<a class="icon-pencil" href="${ctx}/system/holiday/form?id=' + row.id + '"></a>&nbsp;&nbsp;' + '<a class="icon-remove" href="${ctx}/system/holiday/delete?id=' + row.id + '" onclick="return confirmx(\'确认要删除吗？\', this.href)" title="删除"></a>';
                            }
                        }]
                    });
                });
                 //设置传入参数
                function queryParams(params) {
                    $('#searchbar').find('input[name]').each(function () {
                        params[$(this).attr('name')] = $(this).val();
                    });
                    return params
                }
            </script>
			<style type="text/css">
				#table{
					table-layout:fixed;
				}
				#table td div{
					text-overflow: ellipsis;
					white-space: nowrap; 
					overflow: hidden;
					text-align: left;
					text-indent: 14px;
				}
			</style>
        </head>

        <body>
            <ul class="breadcrumb">
                <li class="active"><a href="${ctx}/system/holiday/">节假日列表</a></li>
            </ul>
            <div id="toolbar">
                <ul class="nav nav-pills">
                    <li><a id="xinzeng" href="${ctx}/system/holiday/form"><i class="icon-plus"></i>&nbsp;新增</a>
                    </li>
                </ul>
                <div id="searchbar" class="input-prepend">
                    <span class="add-on">全年公休假放假安排</span>
                    <input id="year" name="year" type="text" maxlength="20" class="input-mini" value="${holiday.year}" onfocus="WdatePicker({dateFmt:'yyyy',autoUpdateOnChanged:true});" style="vertical-align:middle; text-align:center;"/>
                    <input id="search" class="btn btn-primary" type="button" value="查询" style="margin-left:6px;"/>
                </div>
            </div>

            <sys:message content="${message}" />
            <table id="table"></table>
        </body>

        </html>