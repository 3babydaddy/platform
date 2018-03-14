<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page
	import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<% String RndData ="";
  char UpperChar = 'z';
  char LowerChar = 'a';
  char UpperInt = '9';
  char LowerInt = '0';
  Random r = new Random();
  for(int i=0;i<16;i++)
  {
    if ((i==1) || (i==6) || (i==7) || (i==9) || (i==15)){
      int tempval = (int)((int)LowerInt + (r.nextFloat() * ((int)(UpperInt - LowerInt))));
      RndData += new Character((char)tempval).toString();
    }else{
      int tempval = (int)((int)LowerChar + (r.nextFloat() * ((int)(UpperChar - LowerChar))));
      RndData += new Character((char)tempval).toString();
    }
  }
  session.setAttribute("randomString",RndData);
   %>
<html>
<head>

<title>${fns:getConfig('productName')}登录</title>
<meta name="decorator" content="blank" />
<style type="text/css">
*{
    margin: 0;
    padding: 0;
}
/* 背景图样式 */
body{
    font-family: "Microsoft YaHei";
    <c:choose>
    	<c:when test="${fns:getConfig('zzbjsdj.type')==1}">
    		background-image: url(${ctxStatic}/modules/jcgl/img/login-djbg.png);
    	</c:when>
    	<c:when test="${fns:getConfig('zzbjsdj.type')==0}">
    		background-image: url(${ctxStatic}/modules/jcgl/img/newlogin-bgmFont.png);
    	</c:when>
    </c:choose>
    background-repeat: no-repeat;
/*     background-size: cover; */
     <c:choose>
    	<c:when test="${fns:getConfig('zzbjsdj.type')==1}">
    		 filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${ctxStatic}/modules/jcgl/img/login-djbg.png',  sizingMethod='scale');
    	</c:when>
    	<c:when test="${fns:getConfig('zzbjsdj.type')==0}">
/*     		 filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${ctxStatic}/modules/jcgl/img/login-bgm.png',  sizingMethod='scale'); */
    	</c:when>
    </c:choose>

    position: relative;
    background-position: center center;
    height: 100%;
}
/* 背景图样式 */
html{
    height: 100%;
}
ul li{
    list-style: none;
}
a{
    text-decoration: none;
}
.loginForm{/*登录表单*/
    position: fixed;
    width: 639px;
    height: 303px;
/*     background-image: url(${ctxStatic}/modules/jcgl/img/form-bgm.jpg); */
}
.right-login{
    float: right;
    margin-top: 16%;
    margin-right: 10%;
    text-align: center;
}
.right-login h1{
    font-size: 40px;
    font-weight: bold;
    line-height: 40px;
    text-align: center;
    color: #f3f3f3;
    margin-bottom: 10%;
/*     font-family:"Microsoft YaHei!important"; */
}
/* 用户名密码输入框样式 */
.right-login .username,.right-login .psdword{
    padding-left: 50px;
    border: none;
    width: 164px;
    height: 22px;
    line-height:22px;
}
.right-login .username{
    background-image: url(${ctxStatic}/modules/jcgl/img/name-input.jpg);
    background-repeat: no-repeat;
}
.right-login .psdword{
    background-image: url(${ctxStatic}/modules/jcgl/img/psd-input.jpg);
    background-repeat: no-repeat;
}
/* 用户名密码输入框 */
 .right-login .loginbtn{/*登录按钮样式 */
    background-image: url(${ctxStatic}/modules/jcgl/img/login-button.png);
    background-repeat: no-repeat;
    width: 222px;
    height: 34px;
    border: none;
    font-weight: bold;
    font-size: 22px;
    color: #fe241e;
/*     font-family:"Microsoft YaHei!important"; */
}
/*copyright*/
.hr-login-bottom{
    width: 100%;
    text-align: center;
    color: #fff;
    position: absolute;
    bottom: 5%;
    margin: 0 auto;
}
.hr-login-bottom p{
    margin-bottom: 5px;
    font-size: 12px;
}
</style>
<script type="text/javascript">
//校验加密锁
function CheckUsbKey(){

	var form =$("#loginForm");
	var ciphertextspan=$("#ciphertextspan");
	if($(form.userName).val()==""){
		alertx("请输入用户名！");
		$(form.userName).focus();
		return false;
	}
	if($(form.password).val()==""){
		alertx("请输入密码！");
		$(form.password).focus();
		return false;
	}
	try {
		var version = ePassFull.GetLibVersion();
	} catch (e) {
		if(e="&H1B6"){
			alertx("请安装身份认证锁安全控件！");
			ciphertextspan.html("<input type='hidden' name='loginKey' Value=''>");
		}else{
			alertx("发生未定义异常！");
			ciphertextspan.html("<input type='hidden' name='loginKey' Value=''>");
		}
		return false;
	}

	try {
		ePassFull.OpenDevice(1,"");
	} catch (e) {
		alertx("请插入身份认证锁！");
		ciphertextspan.html("<input type='hidden' name='loginKey' Value=''>");
		return false;
	}

	try {
		ePassFull.ChangeDir(0x300,0,"ASP_DEMO");
	} catch (e) {
		 alertx("ePass目录打开失败。");
	     ePass.CloseDevice();
		ciphertextspan.html("<input type='hidden' name='loginKey' Value=''>");
		return false;
	}

	try {
		 ePassFull.OpenFile(0,1);
	} catch (e) {
		 alertx("Key文件打开失败。");
	     ePass.CloseDevice();
		ciphertextspan.html("<input type='hidden' name='loginKey' Value=''>");
		return false;
	}

	try {
		 var ciphertext = ePassFull.HashToken (1, 2,"<%=(String)session.getAttribute("randomString")%>");
		 ciphertextspan.html("<input type='hidden' name='loginKey' Value='"+ciphertext+"'>");
	} catch (e) {
		 alertx("ePass密文取得失败。");
	     ePass.CloseDevice();
		ciphertextspan.html("<input type='hidden' name='loginKey' Value=''>");
		return false;
	}
	return true;
}
</script>
<script type="text/javascript">
	// 如果在框架或在对话框中，则弹出提示并跳转到首页
	if (self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0) {
		alertx('未登录或登录超时。请重新登录，谢谢！');
		top.location = "${ctx}";
	}
	$(function() {
		$("#loginbtn").click(function() {
			if (CheckUsbKey()) {
				$("#loginForm").submit();
			}
		});

		$('#username').val("");
        $('#password').val("");
		if('${not empty message}'&&'${message}'!=""){
			alertx('${message}', closed);
		}
	});
</script>
</head>
<body >
    <form id="loginForm" action="${ctx}/login" method="post" class="loginForm">
        <div class="right-login">
            <h1></h1>
            <p>
                <input type="text" placeholder="请输入用户名" id="username" class="username" value="" name="username">
            </p>
            <p>
                <input type="password" placeholder="请输入密码" id="psdword" class="psdword" value="" name="password">
            </p>
            <div >
				<!--加密锁-->
				<span id="ciphertextspan" ></span>
				<!--加密锁-->
			</div>
            <p>
                <input type="submit" value="" class="loginbtn" id="loginbtn">
                <a href="${ctxStatic}/ePass1000ND_Setup.exe" style="color: white;display: block;text-align: right;font-size: 14px;margin-top: 3px;">【身份认证锁驱动】</a>
            </p>
        </div>
    </form>
    <!-- copyright版权信息 -->
    <div class="hr-login-bottom">
        <p>${fns:getConfig('loginFooter_line1')}</p>
        <p>${fns:getConfig('loginFooter_line2')}</p>
        <p>${fns:getConfig('loginFooter_line3')}</p>
        <p>${fns:getConfig('loginFooter_line4')}&nbsp;版本号：${fns:getConfig('version')}</p>
    </div>

    <!--加密锁-->
     <object CLASSID="clsid:C7672410-309E-4318-8B34-016EE77D6B58"
	    CODEBASE="files/install.cab#Version=1,0,6,413"
	    BORDER="0" VSPACE="0" HSPACE="0" ALIGN="TOP" HEIGHT="0" WIDTH="0"
	    id="ePass1000nd" style="LEFT: 0px; TOP: 0px"
	    name="ePassFull" VIEWASTEXT>
	 </object>
	 <!--加密锁-->

    <script type="text/javascript">
        $(function(){

            var wid = ($(window).width()-$('.loginForm').width())/2;
            var hei = ($(window).height()-$('.loginForm').height())/2;
            $('.loginForm').css({'left':wid,'top':hei});
            /* $(window).resize(function(){
                var wid = ($(window).width()-$('.loginForm').width())/2;
                var hei = ($(window).height()-$('.loginForm').height())/2;
                $('.loginForm').css({'left':wid,'top':hei});
            }); */
        });
    </script>
</body>
</html>