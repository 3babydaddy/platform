/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.tfkj.framework.core.persistence.DataEntity;

/**
 * 数据操作日志Entity
 * 
 * @author sunxuelong
 * @version 2016-12-21
 */
public class DataLog extends DataEntity<DataLog> {

	private static final long serialVersionUID = 1L;
	private String dataType; // 数据类型
	private String dataId; // 数据ID
	private String operType; // 操作类型
	private String operDetail; // 操作内容
	private String operIp; // 操作IP
	private User operBy; // 操作人
	private Date operDate; // 操作时间

	public DataLog() {
		super();
	}

	public DataLog(String id) {
		super(id);
	}

	@Length(min = 0, max = 50, message = "数据类型长度必须介于 0 和 50 之间")
	public String getDataType() {
		return dataType;
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}

	@Length(min = 0, max = 50, message = "数据ID长度必须介于 0 和 50 之间")
	public String getDataId() {
		return dataId;
	}

	public void setDataId(String dataId) {
		this.dataId = dataId;
	}

	@Length(min = 0, max = 50, message = "操作类型长度必须介于 0 和 50 之间")
	public String getOperType() {
		return operType;
	}

	public void setOperType(String operType) {
		this.operType = operType;
	}

	@Length(min = 0, max = 500, message = "操作内容长度必须介于 0 和 500 之间")
	public String getOperDetail() {
		return operDetail;
	}

	public void setOperDetail(String operDetail) {
		this.operDetail = operDetail;
	}

	@Length(min = 0, max = 50, message = "操作IP长度必须介于 0 和 50 之间")
	public String getOperIp() {
		return operIp;
	}

	public void setOperIp(String operIp) {
		this.operIp = operIp;
	}

	@Length(min = 0, max = 50, message = "操作人长度必须介于 0 和 50 之间")
	public User getOperBy() {
		return operBy;
	}

	public void setOperBy(User operBy) {
		this.operBy = operBy;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Date getOperDate() {
		return operDate;
	}

	public void setOperDate(Date operDate) {
		this.operDate = operDate;
	}

}