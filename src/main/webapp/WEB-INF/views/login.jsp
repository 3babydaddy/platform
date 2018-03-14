<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>${fns:getConfig('productName')}登录</title>
<meta name="decorator" content="blank" />
<link href="${ctxStatic}/modules/login/css/login.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
	// 如果在框架或在对话框中，则弹出提示并跳转到首页
	var a=window.top.location.href;
	var b=location.href;
	if (self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0||window.top.location.href!=location.href) {
		alertx('未登录或登录超时。请重新登录，谢谢！');
		top.location = "${ctx}";
	}
	$(function() {
		$('#username').val("");
		$('#password').val("");
		if('${not empty message}'&&'${message}'!=""){
			alertx('${message}', closed);
		}
	});
	function check(){
		if($('#username').val()=="" || $('#username').val()==null){
			alertx("用户名不能为空");
		    return false;
		}
		if($('#psdword').val()=="" || $('#psdword').val()==null){
			alertx("密码不能为空");
		    return false;
		}
	}
</script>
<style type="text/css">
    .u0{
            font-family: 华文行楷;
		    font-weight: 400;
		    font-style: normal;
		    font-size: 72px;
		    color: rgb(255, 0, 0);
		    text-align: center;
		    margin-top: 25px;
		    white-space:nowrap;
    }
    .u0 p span{
            font-size: 70px;
    }
</style>
</head>
<body>
	<div class="bgLeft">
	<div class="bgRight">
	<div class="loginWrap">
		<div class="main">
			<div class="header" >
			     <div style="margin: 0 auto;width: 1140px;">
			         <img alt="" src="${ctxStatic}/modules/login/img/title.png">
			     </div>

			</div>
			<div class="content">
			  <div class="contentInner">
				     <div class="conLeft">
	                    <img alt="" src="${ctxStatic}/modules/login/img/u25.png">
	                </div>
	                <div class="conRight">
	                    <div class="conRightTop">
	                        <p class="loginTit">请登录您的账户</p>
	                        <hr>
	                    </div>
	                    <ul>
	                        <li>
	                            <form id="loginForm" action="${ctx}/login" method="post" class="loginForm" onsubmit="return check()">
	                                <div class="right-login">
	                                    <div>
	                                        <label>用户名</label>
	                                        <input type="text" placeholder="请输入用户名" id="username" class="username" value="" name="username">
	                                    </div>
	                                    <div>
	                                        <label>密　码</label>
	                                        <input type="password" placeholder="请输入密码" id="psdword" class="psdword" value="" name="password">
	                                    </div>
	                                    <div class="groupBtns">
	                                        <input type="submit" value="登  录" class="loginbtn" id="loginbtn">
	                                    </div>
	                                </div>
	                            </form>
	                         </li>
	                    </ul>
	                </div>
			  </div>

		    </div>
	    </div>
	     <!-- copyright版权信息 -->
		    <div class="hr-login-bottom">
		         <p>${fns:getConfig('loginFooter_line1')}</p>
		         <p>${fns:getConfig('loginFooter_line3')}</p>
		    </div>
		    <!-- copyright版权信息 -->
	</div>
    </div>
    </div>
    <script type="text/javascript">
//         $(function(){
//             var wid = $(window).width()*0.622;
//             var hei = ($(window).height()-$('.username').height())/2;
//             hei=hei*0.89;
//             var heipsd = hei*1.21;
//             var lgbtnw = wid*1.12;
//             var lgbtnh = hei*1.4;
//             $('.username').css({'left':wid,'top':hei});
//             $('.psdword').css({'left':wid,'top':heipsd});
//             $('.loginbtn').css({'left':lgbtnw,'top':lgbtnh});
//             $(window).resize(function(){
//             	var wid = $(window).width()*0.622;
//                 var hei = ($(window).height()-$('.username').height())/2;
//                 hei=hei*0.89;
//                 var heipsd = hei*1.21;
//                 var lgbtnw = wid*1.12;
//                 var lgbtnh = hei*1.4;
//                 $('.username').css({'left':wid,'top':hei});
//                 $('.psdword').css({'left':wid,'top':heipsd});
//                 $('.loginbtn').css({'left':lgbtnw,'top':lgbtnh});
//             });
//         });
    </script>
</body>
</html>