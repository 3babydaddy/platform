/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.security;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.stereotype.Service;

import com.tfkj.framework.core.utils.StringUtils;

/**
 * 表单验证（包含验证码）过滤类
 *
 * @author ThinkGem
 * @version 2014-5-19
 */
@Service
public class FormAuthenticationFilter {

	public static final String DEFAULT_CAPTCHA_PARAM = "validateCode";

	public static final String DEFAULT_MOBILE_PARAM = "mobileLogin";

	public static final String DEFAULT_MESSAGE_PARAM = "message";

	private String captchaParam = DEFAULT_CAPTCHA_PARAM;

	private String mobileLoginParam = DEFAULT_MOBILE_PARAM;

	private String messageParam = DEFAULT_MESSAGE_PARAM;

	/*@Override
	protected AuthenticationToken createToken(ServletRequest request, ServletResponse response) {

		String username = getUsername(request);
		String password = getPassword(request);
		String loginKey = WebUtils.getCleanParam(request, "loginKey");
		String randomString = (String) ((HttpServletRequest) request).getSession().getAttribute("randomString");
		if (password == null) {
			password = "";
		}
		boolean rememberMe = isRememberMe(request);
		String host = StringUtils.getRemoteAddr((HttpServletRequest) request);
		String captcha = getCaptcha(request);
		boolean mobile = isMobileLogin(request);
		return new UsernamePasswordToken(username, password.toCharArray(), loginKey, randomString, rememberMe, host, captcha, mobile);
	}*/

	public String getCaptchaParam() {

		return captchaParam;
	}

	protected String getCaptcha(ServletRequest request) {

		return WebUtils.getCleanParam(request, getCaptchaParam());
	}

	public String getMobileLoginParam() {

		return mobileLoginParam;
	}

	protected boolean isMobileLogin(ServletRequest request) {

		return WebUtils.isTrue(request, getMobileLoginParam());
	}

	public String getMessageParam() {

		return messageParam;
	}

	/**
	 * 登录成功之后跳转URL
	 *//*
	@Override
	public String getSuccessUrl() {

		return super.getSuccessUrl();
	}

	@Override
	protected void issueSuccessRedirect(ServletRequest request, ServletResponse response) throws Exception {

		WebUtils.issueRedirect(request, response, getSuccessUrl(), null, true);
	}

	*//**
	 * 登录失败调用事件
	 *//*
	@Override
	protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {

		String className = e.getClass().getName(), message = "";
		if (IncorrectCredentialsException.class.getName().equals(className) || UnknownAccountException.class.getName().equals(className)) {
			message = "用户名或密码错误, 请重试.";
		} else if (e.getMessage() != null && StringUtils.startsWith(e.getMessage(), "msg:")) {
			message = StringUtils.replace(e.getMessage(), "msg:", "");
		} else {
			message = "系统出现点问题，请稍后再试！";
			e.printStackTrace();
		}
		request.setAttribute(getFailureKeyAttribute(), className);
		request.setAttribute(getMessageParam(), message);
		return true;
	}*/
}