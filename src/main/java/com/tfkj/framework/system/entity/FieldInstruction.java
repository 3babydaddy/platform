/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.entity;

import org.hibernate.validator.constraints.Length;

import com.tfkj.framework.core.persistence.DataEntity;
import com.tfkj.framework.core.utils.excel.annotation.ExcelField;

/**
 * 字段Entity
 *
 * @author sunxuelong
 */
public class FieldInstruction extends DataEntity<FieldInstruction> {

	private static final long serialVersionUID = 1L;

	// 数据类型
	private String dataType;

	// 模块类型
	private String moduleType;

	// 字段
	private String fieldCode;

	// 字段名
	private String fieldName;

	// 提示信息
	private String instruction;

	// 排序
	private Integer sort;

	// 数据类型查询项
	private String dataTypeSearch;

	// 模块类型查询项
	private String moduleTypeSearch;

	/** 导出excel列表类型 */
	private String exportListType;

	// private Date updateDate;
	private String sId;// 导入导出用Id

	@ExcelField(align = 2, type = 0, sort = 2, title = "Id(不能修改)", exportListType = "")
	public String getsId() {

		return sId;
	}

	public void setsId(String sId) {

		this.sId = sId;
	}

	// @ExcelField(align = 2, type = 0, sort = 4, title = "操作", exportListType = "")
	public String getCaozuo() {

		return "修改";
	}

	public void setCaozuo(String caozuo) {

	}

	/*
	 * @Override
	 * // @ExcelField(align = 2, type = 0, sort = 5, title = "更新时间", exportListType = "")
	 * public Date getUpdateDate() {
	 * return updateDate;
	 * }
	 * @Override
	 * public void setUpdateDate(Date updateDate) {
	 * this.updateDate = updateDate;
	 * }
	 */
	public String getExportListType() {

		return exportListType;
	}

	public void setExportListType(String exportListType) {

		this.exportListType = exportListType;
	}

	public String getDataTypeSearch() {

		return dataTypeSearch;
	}

	@ExcelField(align = 2, type = 0, sort = 1, title = "数据类型", exportListType = "")
	public String getDataTypeSearchString() {// 导入时需要添加set方法

		if ("00".equals(dataTypeSearch)) {
			return "人员基本信息";
		} else if ("01".equals(dataTypeSearch)) {
			return "记实登记";
		} else if ("02".equals(dataTypeSearch)) {
			return "平职交流";
		} else if ("03".equals(dataTypeSearch)) {
			return "处分问责";
		} else {
			return "";
		}
	}

	public void setDataTypeSearchString(String dataTypeSearchString) {

		if ("人员基本信息".equals(dataTypeSearchString)) {
			this.dataTypeSearch = "00";
		} else if ("记实登记".equals(dataTypeSearchString)) {
			this.dataTypeSearch = "01";
		} else if ("平职交流".equals(dataTypeSearchString)) {
			this.dataTypeSearch = "02";
		} else if ("处分问责".equals(dataTypeSearchString)) {
			this.dataTypeSearch = "03";
		} else {
			this.dataTypeSearch = "00";
		}
	}

	public void setDataTypeSearch(String dataTypeSearch) {

		this.dataTypeSearch = dataTypeSearch;
	}

	public String getModuleTypeSearch() {

		return moduleTypeSearch;
	}

	@ExcelField(align = 2, type = 0, sort = 3, title = "模块类型", exportListType = "")
	public String getModuleTypeSearchString() {// 导入时添加set方法 "00"代表空值

		if ("01".equals(moduleTypeSearch)) {
			return "基本信息";
		} else if ("02".equals(moduleTypeSearch)) {
			return "任职资格";
		} else if ("03".equals(moduleTypeSearch)) {
			return "动议";
		} else if ("04".equals(moduleTypeSearch)) {
			return "初次提名";
		} else if ("05".equals(moduleTypeSearch)) {
			return "民主推荐";
		} else if ("06".equals(moduleTypeSearch)) {
			return "竞争性选拔";
		} else if ("07".equals(moduleTypeSearch)) {
			return "确定考察对象";
		} else if ("08".equals(moduleTypeSearch)) {
			return "组织考察";
		} else if ("09".equals(moduleTypeSearch)) {
			return "有关事项报告";
		} else if ("10".equals(moduleTypeSearch)) {
			return "讨论决定";
		} else if ("11".equals(moduleTypeSearch)) {
			return "公示";
		} else if ("12".equals(moduleTypeSearch)) {
			return "任职";
		}
		return "";
	}

	public void setModuleTypeSearchString(String moduleTypeSearchString) {

		if ("基本信息".equals(moduleTypeSearchString)) {
			this.moduleTypeSearch = "01";
		} else if ("任职资格".equals(moduleTypeSearchString)) {
			this.moduleTypeSearch = "02";
		} else if ("动议".equals(moduleTypeSearchString)) {
			this.moduleTypeSearch = "03";
		} else if ("初次提名".equals(moduleTypeSearchString)) {
			this.moduleTypeSearch = "04";
		} else if ("民主推荐".equals(moduleTypeSearchString)) {
			this.moduleTypeSearch = "05";
		} else if ("竞争性选拔".equals(moduleTypeSearchString)) {
			this.moduleTypeSearch = "06";
		} else if ("确定考察对象".equals(moduleTypeSearchString)) {
			this.moduleTypeSearch = "07";
		} else if ("组织考察".equals(moduleTypeSearchString)) {
			this.moduleTypeSearch = "08";
		} else if ("有关事项报告".equals(moduleTypeSearchString)) {
			this.moduleTypeSearch = "09";
		} else if ("讨论决定".equals(moduleTypeSearchString)) {
			this.moduleTypeSearch = "10";
		} else if ("公示".equals(moduleTypeSearchString)) {
			this.moduleTypeSearch = "11";
		} else if ("任职".equals(moduleTypeSearchString)) {
			this.moduleTypeSearch = "12";
		} else {
			this.moduleTypeSearch = "00";
		}
	}

	public void setModuleTypeSearch(String moduleTypeSearch) {

		this.moduleTypeSearch = moduleTypeSearch;
	}

	public FieldInstruction() {
		super();
	}

	public FieldInstruction(String id) {
		super(id);
	}

	@Length(min = 1, max = 50, message = "数据类型长度必须介于 1 和 50 之间")
	public String getDataType() {

		return dataType;
	}

	public void setDataType(String dataType) {

		this.dataType = dataType;
	}

	@Length(min = 0, max = 50, message = "模块类型长度必须介于 0 和 50 之间")
	public String getModuleType() {

		return moduleType;
	}

	public void setModuleType(String moduleType) {

		this.moduleType = moduleType;
	}

	@Length(min = 1, max = 50, message = "字段长度必须介于 1 和 50 之间")
	public String getFieldCode() {

		return fieldCode;
	}

	public void setFieldCode(String fieldCode) {

		this.fieldCode = fieldCode;
	}

	@Length(min = 0, max = 50, message = "字段名长度必须介于 0 和 50 之间")
	@ExcelField(align = 2, type = 0, sort = 4, title = "字段名", exportListType = "")
	public String getFieldName() {

		return fieldName;
	}

	public void setFieldName(String fieldName) {

		this.fieldName = fieldName;
	}

	@Length(min = 1, max = 1000, message = "提示信息长度必须介于 1 和 1000 之间")
	@ExcelField(align = 2, type = 0, sort = 5, title = "提示信息", exportListType = "")
	public String getInstruction() {

		return instruction;
	}

	public void setInstruction(String instruction) {

		this.instruction = instruction;
	}

	public Integer getSort() {

		return sort;
	}

	public void setSort(Integer sort) {

		this.sort = sort;
	}
}