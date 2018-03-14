/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.core.persistence;

import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.tf.permission.client.entity.User;
import com.tfkj.framework.core.config.Global;
import com.tfkj.framework.core.utils.IdGen;
import com.tfkj.framework.core.utils.excel.annotation.ExcelField;
import com.tfkj.framework.system.utils.UserUtils;

/**
 * 数据Entity类
 * 
 * @author ThinkGem
 * @version 2014-05-16
 */
public abstract class DataEntity<T> extends BaseEntity<T> {

	private static final long serialVersionUID = 1L;

	protected String remarks; // 备注

	protected User createBy; // 创建者

	protected Date createDate; // 创建日期

	protected User updateBy; // 更新者

	protected Date updateDate; // 更新日期

	protected String delFlag; // 删除标记（0：正常；1：删除；2：审核）

	protected String sysVersion;// 程序版本

	public DataEntity() {
		super();
		this.delFlag = DEL_FLAG_NORMAL;
		this.sysVersion = Global.getConfig("version");
	}

	public DataEntity(String id) {
		super(id);
	}

	/**
	 * 插入之前执行方法，需要手动调用
	 */
	@Override
	public void preInsert() {

		// 不限制ID为UUID，调用setIsNewRecord()使用自定义ID
		if (!this.isNewRecord) {
			setId(IdGen.uuid());
		}
		User user = UserUtils.getUser();
		if (StringUtils.isNotBlank(user.getId().toString())) {
			this.updateBy = user;
			this.createBy = user;
		}
		this.updateDate = new Date();
		this.createDate = this.updateDate;
	}

	/**
	 * 更新之前执行方法，需要手动调用
	 */
	@Override
	public void preUpdate() {

		User user = UserUtils.getUser();
		if (StringUtils.isNotBlank(user.getId().toString())) {
			this.updateBy = user;
		}
		this.updateDate = new Date();
	}

	public String getRemarks() {

		return remarks;
	}

	public void setRemarks(String remarks) {

		this.remarks = remarks;
	}

	public User getCreateBy() {

		return createBy;
	}

	public void setCreateBy(User createBy) {

		this.createBy = createBy;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getCreateDate() {

		return createDate;
	}

	public void setCreateDate(Date createDate) {

		this.createDate = createDate;
	}

	@JsonIgnore
	public User getUpdateBy() {

		return updateBy;
	}

	public void setUpdateBy(User updateBy) {

		this.updateBy = updateBy;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getUpdateDate() {

		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {

		this.updateDate = updateDate;
	}

	@JsonIgnore
	@Length(min = 1, max = 1)
	public String getDelFlag() {

		return delFlag;
	}

	public void setDelFlag(String delFlag) {

		this.delFlag = delFlag;
	}

	public static long getSerialversionuid() {

		return serialVersionUID;
	}

	@ExcelField(align = 2, sort = -2, value = "sysVersion", title = "系统版本")
	public String getSysVersion() {

		return Global.getConfig("version");
	}

	public void setSysVersion(String sysVersion) {

		this.sysVersion = sysVersion;
	}
}
