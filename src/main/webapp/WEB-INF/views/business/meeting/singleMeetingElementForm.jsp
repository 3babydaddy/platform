<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

	<div class="benjieCon" >
	 <form  id="meetingElement" >
       <div style="text-align: right;margin-right: 10px;margin-bottom:5px;"><a onclick="save(this)">保存</a><a  style="margin-left: 5px;" class="delTaskBtn">删除</a></div>
               <div>
                       <input type="hidden" name="id"  value="${entity.id }" >
                       <input type="hidden" name="parentId"  value="${meetingTable.id}" >
                       <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态</span>
                       <span style="margin-left:10px;"><input type="radio" name="state" value="N" <c:if test="${entity.state=='N'||entity.state==''||entity.state==null}">checked="checked"</c:if> > 未办结</span>
                       <span style="margin-left:10px;"><input type="radio" name="state" value="Y" <c:if test="${entity.state=='Y'}">checked="checked"</c:if>> 已办结</span>
                       <span style="margin-left:10px;">销号人</span>
                       <input type="text" name="operator" value="${entity.operator }" style="margin-bottom:0px;margin-left:10px;margin-right:10px;width:25%;">
                       <input type="checkbox" name="isOpertorTime" value="N" style="margin-left: 5px;" <c:if test="${entity.isOpertorTime=='N'}">checked="checked"</c:if>>日常管理
                       <span style="margin-left:15px;">销号时间</span>
                       <fmt:parseDate value="${entity.opertorTime}" var="opertorTime" />
                       <input style="margin-bottom:0px;margin-left:10px;width:10%" type="text" name="opertorTime"  value="<fmt:formatDate value="${opertorTime}" />" onfocus="WdatePicker()"/>
               </div>
               <div style="margin-top:20px;">
                       <span >&nbsp;&nbsp;&nbsp;议定事项</span>
                       <input type="text" name="agreeMatterName" value="${entity.agreeMatterName}" style="margin-bottom:0px;margin-left:10px;margin-right:10px;width:60%">
               </div>
               <div style="margin-top:20px;">
                       <span >牵头区领导</span>
                       <input type="text" name="leader" value="${entity.leader}" style="margin-bottom:0px;margin-left:10px;margin-right:10px;width:60%">
                        <span style="margin-left:5px;">完成时限</span>
                       <fmt:parseDate value="${entity.endtime}" var="endtime" />
                       <input style="margin-bottom:0px;margin-left:10px;width:10%" type="text" name="endtime"  value="<fmt:formatDate value="${endtime}" />" onfocus="WdatePicker()"/>
               </div>
               <div style="margin-top:20px;">
                       <span >&nbsp;&nbsp;&nbsp;责任单位</span>
                       <sys:officeTree id="office" name="officeList"  value="${entity.officeList}" title="单位" url="/sys/office/treeData" checked="true" input="meeting${fns:getUuId()}"/>
               </div>
               <div style="margin-top:20px;">
                       <span >&nbsp;&nbsp;&nbsp;有关要求</span>
                       <textarea rows="5" cols="" name="relateRequest"   style="margin-bottom:0px;margin-left:10px;margin-right:10px;width:60%">${entity.relateRequest}</textarea>
               </div>
               <div style="margin-top:20px;">
                       <span >&nbsp;&nbsp;&nbsp;落实情况</span>
                        <textarea rows="5" cols="" name="fulfillSituation"  style="margin-bottom:0px;margin-left:10px;margin-right:10px;width:60%">${entity.fulfillSituation}</textarea>
               </div>
               <input class="input1" type="hidden" name="sort" value="${entity.sort}" />
       </form>
   </div>
   <div class="rightMove"  style="float:left">
       <div  id="up" onclick="topMove(this)">
          <div id="inup"></div>
       </div>
       <div id="down" onclick="lowMove(this)">
           <div id="indown"></div>
       </div>
   </div>