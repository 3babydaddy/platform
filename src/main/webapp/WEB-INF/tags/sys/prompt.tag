<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="fieldName" type="java.lang.String" required="true" description="字段名"%>
<c:if test="${not empty fieldName}">
	<div style="position:relative;height:100%;">
    	<span id="fi_${fieldName}" class="fiSpan promptSpan"><jsp:doBody></jsp:doBody></span>
    	<span id="red_${fieldName}" class="redSpan promptSpan" style="opacity:0.75;filter:alpha(opacity=75);display:none;color:#EE4000;cursor:text;position:absolute;left:45%;top:12%;"><img style="vertical-align:middle;" src="${ctxStatic}/images/light/jingzhong.gif"></span>
    	<span id="yellow_${fieldName}" class="yellowSpan promptSpan" style="opacity:0.75;filter:alpha(opacity=75);display:none;color:#FFC600;cursor:text;position:absolute;left:45%;top:12%;"><img style="vertical-align:middle;" src="${ctxStatic}/images/light/jingzhong_y.gif"></span>
    	<span id="tj_${fieldName}" class="tjSpan promptSpan" style="display:none;"><i class="icon-remove-circle" style="color:#EE4000;cursor:pointer;"></i></span>
    </div>
</c:if>