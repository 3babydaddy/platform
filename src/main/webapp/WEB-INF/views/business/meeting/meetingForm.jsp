<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <style type="text/css">
        .benjieCon{
			    border: 2px solid #e9ecf1;
			    width: 70%;
			    padding-left: 10px;
			    padding-top: 10px;
			    padding-bottom: 10px;
			    margin-left: 11px;
			    margin-bottom:11px;
			    float: left;
			}
		#down{
		    width: 0;
		    height: 0;
		    border: 15px solid transparent;
		    border-top-color: red;
		    /*position: relative;*/
		}
		#indown{
		    width: 0;
		    height: 0;
		    border: 40px solid transparent;
		    border-top-color: white;
		   /* position: absolute;*/
		    margin-top: -45px;
		    margin-left: -40px;
		   }
		 #up {
			    width:0;
			    height:0;
			    border:15px solid transparent;
			    border-bottom:15px solid red;
			    margin-bottom: 80px;
			    margin-top: 150px
			}
			#inup{
            width: 0;
            height: 0;
            border: 20px solid transparent;
            border-bottom-color: white;
           /* position: absolute;*/
            margin-top: -15px;
            margin-left: -20px;
           }
            .clearfix:after{
		        content:"";
		        display:table;
		        height:0;
		        visibility:both;
		        clear:both;
		    }

		    .clearfix{
		    *zoom:1;    /* IE/7/6*/
		    }
    </style>

<script type="text/javascript" src="${ctxStatic}/jquery-form/ajaxfileupload.js?version=3.2.6"></script>
<script type="text/javascript" src="${ctxStatic}/common/tableFormValidation.js"></script>
    <script type="text/javascript">
    //保存议定事项
        function save(ob){
        	 var form = $(ob).parents("form").serializeArray();
             var obj = {};
             $.each(form,function(i,v){
               obj[v.name] = v.value;
               })
              $.ajax({
                    type: "post",
                    data:obj,
                    url: "${ctx}/ywgl/Meeting/saveElement",
                    cache: false,
                    dataType: "json",
                    success:function(res){
                    	$(ob).parents("form").find("input[name='id']").val(res.elementId);
                    	alertx("恭喜您保存成功！");
                    	$(ob).parent().parent().parent().css("border","2px solid #e9ecf1");
                    },
                    error:function(res){
                        alertx("操作失败！");
                    }
                });
        }
        //保存会议
        function saveMeeting(obj){
      	 var meetingName=$("#meetingName").val();
           var meetingTime=$("#meetingTime").val();
           if(meetingName==null||meetingName==""){
               alertx("会议名称不能为空！");
               $("#jbox-iframe").contents().find("#meetingName").focus();
               return false;
           }
           if(meetingTime==null||meetingTime==""){
               $("#jbox-iframe").contents().find("#meetingTime").focus();
               alertx("召开时间不能为空！");
               return false;
           }
        var form = $(obj).parents("form").serializeArray();
        	$.ajax({
                type: "post",
                data:form,
                url: "${ctx}/ywgl/Meeting/saveTableData",
                cache: false,
                success:function(data){
                    alertx("恭喜您保存成功！");
                    $(obj).parent().parent().parent().css("border","2px solid #e9ecf1");
                },
                error:function(res){
                    alertx("保存失败，请重试！");
                }
            })
        }
        function changeColor(){
            $(this).parents('.benjieCon').css("border",
            "2px solid red");
       }
       $(function(){

    	 //内容变化恢复颜色
           $('input,textarea').on(
                   'change ',
                   function(e) {
                       $(this).parents('.benjieCon').css("border",
                               "2px solid red");
                   });

    	   $("#addTaskBtn").click(function() { // 按钮的id
               var newDiv = $("#hideDiv").clone(true);
               newDiv.find('.benjieCon').css("border-color", "red");
               newDiv.show();
              $(this).parent().before(newDiv);
               //排序
               updateDivSort('.benjieCon');
           });

           $(".delTaskBtn").click(function() { // del为删除input的id
        	   var obj=this;
               var id=$(obj).parents("form").find("input[name='id']").val();
        	   var test = confirmx("您确认需要删除该议定事项吗?",function(){
        		   $.ajax({
                       type: "get",
                       url: "${ctx}/ywgl/Meeting/deleteMeetingElemnt?id="+id,
                       cache: false,
                       success:function(data){
                           $(obj).parent().parent().parent().parent().remove();
                           alertx("删除成功！");
                       },
                       error:function(res){
                           alertx("删除失败，请重试！");
                       }
                   })
        	   },'');

           });

           //div 默认排序
           updateDivSort('.benjieCon');
           //新增默认添加一个会议议定事项
           //<c:if test="${empty meetingTable.meetingTableElement}">
                $("#addTaskBtn").click();
           //</c:if>

       })
          //日常管理和销号时间关系
          function relate(obj){
               if($(obj).is(':checked')){
            	   $(obj).nextAll("input[name='opertorTime']").val("");
                   $(obj).nextAll("input[name='opertorTime']").attr("disabled","disabled");
               }else{
                   $(obj).nextAll("input[name='opertorTime']").removeAttr("disabled");
               }
           };
         //上移
           function topMove(id) {
               //当前元素
               var a = $(id).parent().parent();
               //当前元素的前一个元素
               var b = $(id).parent().parent().prev();
               var c=b.attr("class");
               if(c.indexOf('moveLimit') >= 0){
                   return;
               }
               $(id).parent().prev().css("border","2px solid red");
               $(id).parent().parent().prev().find(".benjieCon").css("border","2px solid red");
               a.insertBefore(b);
               updateDivSort('.benjieCon');
           }
           //下移
           function lowMove(id) {
               //当前元素
               var a = $(id).parent().parent();
               //当前元素的后一个元素
               var b = $(id).parent().parent().next();
               var c=b.attr("class");
               if(c.indexOf('moveLimit') >= 0){
                   return;
               }
               $(id).parent().prev().css("border","2px solid red");
               $(id).parent().parent().next().find(".benjieCon").css("border","2px solid red");
               a.insertAfter(b);
               updateDivSort('.benjieCon');
           }
         //排序
           function updateDivSort(className) {
               var sort = 0;
               $(className).each(function() {
                   sort++;
                   $(this).find('input').last().val(sort);
               });
           }
         //返回
         function back(){
        	 location.href="${ctx}/ywgl/Meeting/goList";
         }
    </script>
</head>
<body>

			    <div id="toolbar">
			        <ul class="nav nav-pills">
			            <li><a id="add" href="javascript:history.back(-1)"><i class="icon-reply"></i>&nbsp;返回</a></li>
			        </ul>
			    </div>
			    <!-- 模板 -->
                <div class="clearfix" id="hideDiv" style="display: none;">
                        <div class="benjieCon" >
                             <form  id="meetingElement" >
                               <div style="text-align: right;margin-right: 10px;margin-bottom:5px;"><a onclick="save(this)" style="cursor: pointer;">保存</a><a  style="margin-left: 5px;cursor: pointer"   class="delTaskBtn" >删除</a></div>
                                       <div>
                                               <input type="hidden" name="id"  value="${entity.id }" >
                                               <input type="hidden" name="parentId"  value="${meetingTable.id}" >
                                       </div>

                                       <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;">
                                                  <span >跟踪督办事项</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;">
                                                  <textarea  rows="3" cols="" name="agreeMatterName"  style="margin-bottom:0px;margin-left:10px;margin-right:10px;width:80%">${entity.agreeMatterName}</textarea>
                                               </div>
                                       </div>
                                        <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;">
                                                 <span >有关要求</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;">
                                               <textarea rows="3" cols="" name="relateRequest"   style="margin-bottom:0px;margin-left:10px;margin-right:10px;width:80%">${entity.relateRequest}</textarea>
                                               </div>
                                       </div>
                                       <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;">
                                                     <span >牵头领导</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;margin-left: 10px;">
                                                     <sys:mulTreeSelect id="office" name="leader" value="${entity.leader}" labelName="leaderText" labelValue="${entity.leaderText}"
                                                         title="领导" url="/sys/leader/leaderTree?type=01" cssClass="required" checked="true" notAllowSelectParent="true" />
                                               </div>
                                       </div>
                                        <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;">
                                                     <span >完成时限</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;margin-left: 10px;">
                                                    <input type='text'  name='endtime' value="${entity.endtime }"  onFocus="WdatePicker({startDate:'%y-%M-01 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})" onchange="changeColor()" />
                                               </div>
                                       </div>
                                       <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;height: 35px;line-height: 35px;">
                                                     <span >责任单位</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;margin-left: 10px;">
                                                     <sys:officeTreeFileTime id="office" leftText2="上传督查专函" leftText3="上传回复报告" isShowEndTime="none" name="officeList"  value="${entity.officeList}" title="单位" url="/sys/office/treeData" checked="true" notAllowSelectParent="true" input="meeting${fns:getUuId()}" isBorder="1" />
                                               </div>
                                       </div>
                                       <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;">
                                                     <span >落实情况</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;">
                                                    <textarea rows="3" cols="" name="fulfillSituation"  style="margin-bottom:0px;margin-left:10px;margin-right:10px;width:80%">${entity.fulfillSituation}</textarea>
                                               </div>
                                       </div>
                                       <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;height: 37px;line-height: 37px">
                                                     <span style="display: block;">上传督查专报</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;margin-left: 10px;">
                                                     <sys:upFIle input="operatorFile${fns:getUuId()}"  type="files"  name="operator"  value="${entity.operator}"  uploadPath="/file" selectMultiple="false" maxWidth="100" maxHeight="100" text="上传" isBorder="1"/>
                                               </div>
                                       </div>
                                       <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;">
                                                    <span>状态</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;">
                                                    <span style="margin-left:10px;"><input type="radio" name="state" value="Y" <c:if test="${entity.state=='Y'}">checked="checked"</c:if>> 已落实</span>
                                                    <span style="margin-left:10px;"><input type="radio" name="state" value="N" <c:if test="${entity.state=='N'||entity.state==''||entity.state==null}">checked="checked"</c:if> > 未落实</span>

                                               </div>
                                       </div>
                                       <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;">
                                                    <span >落实时间</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;">
                                                    <fmt:parseDate value="${entity.opertorTime}" var="opertorTime" />
                                                    <input style="margin-bottom:0px;margin-left:10px;width:20%" type="text" name="opertorTime"  value="<fmt:formatDate value="${opertorTime}" />" onfocus="WdatePicker()" onchange="changeColor()"/>
                                               </div>
                                       </div>
                                       <input class="input1" type="hidden" name="sort" value="${entity.sort}" />
                               </form>
                           </div>
                           <div class="rightMove"  style="float:left">
                               <div  id="up" onclick="topMove(this)" style="cursor: pointer;">
                                  <div id="inup"></div>
                               </div>
                               <div id="down" onclick="lowMove(this)" style="cursor: pointer;">
                                   <div id="indown"></div>
                               </div>
                           </div>
                </div>
                <div class="benjieCon moveLimit">
	                <form>
		                   <div style="text-align: right;margin-right: 10px;"><a onclick="saveMeeting(this)" style="cursor: pointer;">保存</a></div>
		                   <input type="hidden" name="id"  value="${meetingTable.id}" >
		                     <div style="margin-top:20px;" class="clearfix">
	                                   <div style="float: left;width: 10%;text-align: right;">
	                                       <span>会议类型</span>
	                                   </div>
	                                   <div style="float: left;width: 80%;text-align: left;">
	                                       <span style="margin-left:10px;"><input type="radio" name="meetingType" value="QWCWh" <c:if test="${meetingTable.meetingType=='QWCWh'||meetingTable.meetingType==''||meetingTable.meetingType==null}">checked="checked"</c:if> > 区委常委会</span>
	                                <span style="margin-left:40px;"><input type="radio" name="meetingType" value="QZFCWH" <c:if test="${meetingTable.meetingType=='QZFCWH'}">checked="checked"</c:if>> 区政府常务会</span>
	                                   </div>
	                           </div>
	                           <div style="margin-top:20px;" class="clearfix">
	                                   <div style="float: left;width: 10%;text-align: right;">
	                                       <span >会议名称</span>
	                                   </div>
	                                   <div style="float: left;width: 80%;text-align: left;">
	                                      <input type="text" name="meetingName"  id="meetingName" value="${meetingTable.meetingName}" style="margin-bottom:0px;margin-left:10px;margin-right:10px;width:60%">
	                                   </div>
	                           </div>
	                           <div style="margin-top:20px;" class="clearfix">
	                                   <div style="float: left;width: 10%;text-align: right;">
	                                       <span style="margin-bottom:10px;">召开时间</span>
	                                   </div>
	                                   <div style="float: left;width: 80%;text-align: left;">
	                                        <input style="margin-bottom:0px;margin-left:10px;width:20%" type="text" name="meetingTime" id="meetingTime"  value="${meetingTable.meetingTime}" onfocus="WdatePicker()" onchange="changeColor()"/>
	                                   </div>
	                           </div>
	                           <div style="margin-top:10px;" class="clearfix">
	                                   <div style="float: left;width: 10%;text-align: right;height: 37px;line-height: 37px">
	                                       <span>上传督查依据</span>
	                                   </div>
	                                   <div style="float: left;width: 80%;text-align: left;margin-left: 10px">
	                                        <sys:upFIle input="operatorFile${fns:getUuId()}"  type="files"  name="remarks"  value="${meetingTable.remarks}"  uploadPath="/file" selectMultiple="false" maxWidth="100" maxHeight="100" text="上传" isBorder="1"/>
	                                    </div>
	                           </div>
		                    <input class="input1" type="hidden" name="divSort" />
	                </form>
                </div>

		         <!--循环时显示 -->
		         <c:forEach items="${meetingTable.meetingTableElement}" var="entity">
		                <div class="clearfix">
                          <div class="benjieCon" >
                             <form  id="meetingElement" >
                               <div style="text-align: right;margin-right: 10px;margin-bottom:5px;"><a onclick="save(this)" style="cursor: pointer;">保存</a><a  style="margin-left: 5px;cursor: pointer"   class="delTaskBtn" >删除</a></div>
                                       <div>
                                               <input type="hidden" name="id"  value="${entity.id }" >
                                               <input type="hidden" name="parentId"  value="${meetingTable.id}" >
                                       </div>

                                       <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;">
                                                  <span >跟踪督办事项</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;">
                                                  <textarea  rows="3" cols="" name="agreeMatterName"  style="margin-bottom:0px;margin-left:10px;margin-right:10px;width:80%">${entity.agreeMatterName}</textarea>
                                               </div>
                                       </div>
                                        <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;">
                                                 <span >有关要求</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;">
                                               <textarea rows="3" cols="" name="relateRequest"   style="margin-bottom:0px;margin-left:10px;margin-right:10px;width:80%">${entity.relateRequest}</textarea>
                                               </div>
                                       </div>
                                       <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;">
                                                     <span >牵头领导</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;margin-left: 10px;">
                                                     <sys:mulTreeSelect id="office" name="leader" value="${entity.leader}" labelName="leaderText" labelValue="${entity.leaderText}"
                                                         title="领导" url="/sys/leader/leaderTree?type=01" cssClass="required" checked="true" notAllowSelectParent="true"/>
                                               </div>
                                       </div>
                                        <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;">
                                                     <span >完成时限</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;margin-left: 10px;">
                                                    <input type='text'  name='endtime' value="${entity.endtime }"  onFocus="WdatePicker({startDate:'%y-%M-01 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})" onchange="changeColor()" />
                                               </div>
                                       </div>
                                       <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;height: 35px;line-height: 35px;">
                                                     <span >责任单位</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;margin-left: 10px;">
                                                     <sys:officeTreeFileTime id="office" leftText2="上传督查专函" leftText3="上传回复报告" isShowEndTime="none" name="officeList"  value="${entity.officeList}" title="单位" url="/sys/office/treeData" checked="true" notAllowSelectParent="true" input="meeting${fns:getUuId()}" isBorder="1" />
                                               </div>
                                       </div>
                                       <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;">
                                                     <span >落实情况</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;">
                                                    <textarea rows="3" cols="" name="fulfillSituation"  style="margin-bottom:0px;margin-left:10px;margin-right:10px;width:80%">${entity.fulfillSituation}</textarea>
                                               </div>
                                       </div>
                                       <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;height: 37px;line-height: 37px">
                                                     <span style="display: block;">上传督查专报</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;margin-left: 10px;">
                                                     <sys:upFIle input="operatorFile${fns:getUuId()}"  type="files"  name="operator"  value="${entity.operator}"  uploadPath="/file" selectMultiple="false" maxWidth="100" maxHeight="100" text="上传" isBorder="1"/>
                                               </div>
                                       </div>
                                       <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;">
                                                    <span>状态</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;">
                                                    <span style="margin-left:10px;"><input type="radio" name="state" value="Y" <c:if test="${entity.state=='Y'}">checked="checked"</c:if>> 已落实</span>
                                                    <span style="margin-left:10px;"><input type="radio" name="state" value="N" <c:if test="${entity.state=='N'||entity.state==''||entity.state==null}">checked="checked"</c:if> > 未落实</span>

                                               </div>
                                       </div>
                                       <div style="margin-top:20px;" class="clearfix">
                                               <div style="float: left;width: 10%;text-align: right;">
                                                    <span >落实时间</span>
                                               </div>
                                               <div style="float: left;width: 80%;text-align: left;">
                                                    <fmt:parseDate value="${entity.opertorTime}" var="opertorTime" />
                                                    <input style="margin-bottom:0px;margin-left:10px;width:20%" type="text" name="opertorTime"  value="<fmt:formatDate value="${opertorTime}" />" onfocus="WdatePicker()" onchange="changeColor()"/>
                                               </div>
                                       </div>
                                       <input class="input1" type="hidden" name="sort" value="${entity.sort}" />
                               </form>
                           </div>
                           <div class="rightMove"  style="float:left">
                               <div  id="up" onclick="topMove(this)" style="cursor: pointer;">
                                  <div id="inup"></div>
                               </div>
                               <div id="down" onclick="lowMove(this)" style="cursor: pointer;">
                                   <div id="indown"></div>
                               </div>
                           </div>
		                </div>
		         </c:forEach>

                <div class="moveLimit">
			        <a id="addTaskBtn" class="qtupload" style="margin-left: 30%;margin-bottom: 10px;">添加议定事项</a>
			    </div>
</body>
</html>