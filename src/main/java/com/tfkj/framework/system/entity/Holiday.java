/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.tfkj.framework.core.persistence.DataEntity;

/**
 * 节假日管理Entity
 * 
 * @author sunxuelong
 * @version 2016-12-30
 */
public class Holiday extends DataEntity<Holiday> {

	private static final long serialVersionUID = 1L;
	// 节假日名称
	private String name;
	// 年度
	private String year;
	// 节假日开始日期
	private Date beginDate;
	// 节假日结束日期
	private Date endDate;
	// 调休日期1
	private Date exchangeDate1;
	// 调休日期2
	private Date exchangeDate2;

	public Holiday() {
		super();
	}

	public Holiday(String id) {
		super(id);
	}

	@Length(min = 0, max = 50, message = "节假日名称长度必须介于 0 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getEndDate() {
		return endDate;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getExchangeDate1() {
		return exchangeDate1;
	}

	public void setExchangeDate1(Date exchangeDate1) {
		this.exchangeDate1 = exchangeDate1;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getExchangeDate2() {
		return exchangeDate2;
	}

	public void setExchangeDate2(Date exchangeDate2) {
		this.exchangeDate2 = exchangeDate2;
	}

}