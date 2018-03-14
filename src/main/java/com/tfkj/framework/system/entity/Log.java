/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.entity;

import java.util.Date;
import java.util.Map;

import com.tfkj.framework.core.persistence.DataEntity;
import com.tfkj.framework.core.utils.StringUtils;

/**
 * @Description: 日志实体类
 * @author gaowei
 * @date 2016年11月16日
 */
public class Log extends DataEntity<Log> {

	private static final long serialVersionUID = 1L;
	// 日志类型（1：接入日志；2：错误日志）
	public static final String TYPE_ACCESS = "1";
	public static final String TYPE_EXCEPTION = "2";

	/** 类型 */
	private String type;

	/** 标题 */
	private String title;

	/** IP地址 */
	private String ip;

	/** 访问路径 */
	private String requestUri;

	/** 访问方法 */
	private String method;

	/** 参数 */
	private String params;

	/** 操作内容 */
	private String detail;

	/** 异常 */
	private String exception;
	private Date beginDate; // 开始日期
	private Date endDate; // 结束日期

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getRequestUri() {
		return requestUri;
	}

	public void setRequestUri(String requestUri) {
		this.requestUri = requestUri;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getParams() {
		return params;
	}

	public void setParams(String params) {
		this.params = params;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getException() {
		return exception;
	}

	public void setException(String exception) {
		this.exception = exception;
	}

	/**
	 * 设置请求参数
	 * 
	 * @param paramMap
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void setParams(Map paramMap) {
		if (paramMap == null) {
			return;
		}
		StringBuilder params = new StringBuilder();
		for (Map.Entry<String, String[]> param : ((Map<String, String[]>) paramMap).entrySet()) {
			params.append(("".equals(params.toString()) ? "" : "&") + param.getKey() + "=");
			String paramValue = (param.getValue() != null && param.getValue().length > 0 ? param.getValue()[0] : "");
			params.append(StringUtils.abbr(StringUtils.endsWithIgnoreCase(param.getKey(), "password") ? "" : paramValue, 100));
		}
		this.params = params.toString();
	}

	@Override
	public String toString() {
		return "Log [type=" + type + ", title=" + title + ", ip=" + ip + ", requestUri=" + requestUri + ", method=" + method + ", params=" + params + ", detail=" + detail + ", exception=" + exception
		        + ", beginDate=" + beginDate + ", endDate=" + endDate + "]";
	}

}