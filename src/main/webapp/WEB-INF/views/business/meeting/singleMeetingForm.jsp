<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
</head>
<body>
    <div style="padding: 20px;">
        <form id="addMeeting">
                <div class="benjieCon moveLimit">
			            <span>会议类型</span>
			            <span style="margin-left:10px;"><input type="radio" name="meetingType" value="QWCWh" checked="checked"> 区委常委会</span>
			            <span style="margin-left:40px;"><input type="radio" name="meetingType" value="QZFCWH"> 区政府常务会</span>
			      </div>
			      <div style="margin-top:20px;">
			              <span >会议名称</span>
			              <input type="text" name="meetingName" id="meetingName" style="margin-bottom:0px;margin-left:10px;margin-right:10px;">
			      </div>
			      <div style="margin-top:20px;">
			      <span style="margin-bottom:10px;">召开时间</span>
			            <fmt:parseDate value="${meeting.meetingTime}" var="meetingTime" pattern="yyyy-MM"/>
			            <input style="margin-bottom:0px;margin-left:10px;" type="text" name="meetingTime" id="meetingTime"  onfocus="WdatePicker()"/>
			      </div>
	       </form>

    </div>
</body>
</html>