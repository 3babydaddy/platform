package com.tfkj.business.ywgl.entity;

import java.util.List;

import com.tfkj.framework.core.persistence.DataEntity;

public class YearTaskTableData extends DataEntity<YearTaskTableData> {

	private static final long serialVersionUID = 1L;

	// 分解任务IDs(以 , 隔开)
	private String relateIds;

	// 排序序号
	private String sort;

	// 年度
	private String taskYear;

	// 目标任务
	private String targetTask;

	// 目标任务完成状态
	private String taskState;

	// 分解任务状态
	private String relateTaskState;

	// 分解任务-明细
	private List<YearTaskTableElement> relateTaskList;

	// 牵头单位Ids
	private String leadOfficeIds;

	// 责任单位Ids
	private String dutyOfficeIds;

	// 分管区单位Ids
	private String chargeOfficeIds;

	// 牵头单位Names
	private String leadOfficeNames;

	// 责任单位Names
	private String dutyOfficeNames;

	// 分管区单位Names
	private String chargeOfficeNames;

	// 牵头单位ChargePersons
	private String leadOfficeChargePersons;

	// 责任单位ChargePersons
	private String dutyOfficeChargePersons;

	// 分管区单位ChargePersons
	private String chargeOfficeChargePersons;

	// 牵头单位
	private List<TableOfficeElement> leadOfficeList;

	// 责任单位
	private List<TableOfficeElement> dutyOfficeList;

	// 分管区单位
	private List<TableOfficeElement> chargeOfficeList;

	// 根据分解任务合并单元格
	public String getRowNum() {

		String rowNum = "1";
		if (this.relateTaskList != null && !relateTaskList.isEmpty()) {
			rowNum = String.valueOf(this.relateTaskList.size());
		}
		return rowNum;
	}

	public void setRowNum(String rowNum) {

	}

	public String getTargetTask() {

		return targetTask;
	}

	public void setTargetTask(String targetTask) {

		this.targetTask = targetTask;
	}

	public String getRelateTaskState() {

		return relateTaskState;
	}

	public void setRelateTaskState(String relateTaskState) {

		this.relateTaskState = relateTaskState;
	}

	public String getTaskYear() {

		return taskYear;
	}

	public void setTaskYear(String taskYear) {

		this.taskYear = taskYear;
	}

	public String getRelateIds() {

		return relateIds;
	}

	public void setRelateIds(String relateIds) {

		this.relateIds = relateIds;
	}

	public String getSort() {

		return sort;
	}

	public void setSort(String sort) {

		this.sort = sort;
	}

	public List<YearTaskTableElement> getRelateTaskList() {

		return relateTaskList;
	}

	public void setRelateTaskList(List<YearTaskTableElement> relateTaskList) {

		this.relateTaskList = relateTaskList;
	}

	public String getLeadOfficeIds() {

		StringBuilder str = new StringBuilder();
		if (leadOfficeList != null && !leadOfficeList.isEmpty()) {
			for (TableOfficeElement entity : leadOfficeList) {
				str.append(entity.getOffice().getId());
				str.append(",");
			}
		}
		leadOfficeIds = str.toString();
		return leadOfficeIds;
	}

	public void setLeadOfficeIds(String leadOfficeIds) {

		this.leadOfficeIds = leadOfficeIds;
	}

	public String getDutyOfficeIds() {

		StringBuilder str = new StringBuilder();
		if (dutyOfficeList != null && !dutyOfficeList.isEmpty()) {
			for (TableOfficeElement entity : dutyOfficeList) {
				str.append(entity.getOffice().getId());
				str.append(",");
			}
		}
		dutyOfficeIds = str.toString();
		return dutyOfficeIds;
	}

	public void setDutyOfficeIds(String dutyOfficeIds) {

		this.dutyOfficeIds = dutyOfficeIds;
	}

	public String getChargeOfficeIds() {

		StringBuilder str = new StringBuilder();
		if (chargeOfficeList != null && !chargeOfficeList.isEmpty()) {
			for (TableOfficeElement entity : chargeOfficeList) {
				str.append(entity.getOffice().getId());
				str.append(",");
			}
		}
		chargeOfficeIds = str.toString();
		return chargeOfficeIds;
	}

	public void setChargeOfficeIds(String chargeOfficeIds) {

		this.chargeOfficeIds = chargeOfficeIds;
	}

	public String getLeadOfficeNames() {

		return leadOfficeNames;
	}

	public void setLeadOfficeNames(String leadOfficeNames) {

		this.leadOfficeNames = leadOfficeNames;
	}

	public String getDutyOfficeNames() {

		return dutyOfficeNames;
	}

	public void setDutyOfficeNames(String dutyOfficeNames) {

		this.dutyOfficeNames = dutyOfficeNames;
	}

	public String getChargeOfficeNames() {

		return chargeOfficeNames;
	}

	public void setChargeOfficeNames(String chargeOfficeNames) {

		this.chargeOfficeNames = chargeOfficeNames;
	}

	public String getLeadOfficeChargePersons() {

		return leadOfficeChargePersons;
	}

	public void setLeadOfficeChargePersons(String leadOfficeChargePersons) {

		this.leadOfficeChargePersons = leadOfficeChargePersons;
	}

	public String getDutyOfficeChargePersons() {

		return dutyOfficeChargePersons;
	}

	public void setDutyOfficeChargePersons(String dutyOfficeChargePersons) {

		this.dutyOfficeChargePersons = dutyOfficeChargePersons;
	}

	public String getChargeOfficeChargePersons() {

		return chargeOfficeChargePersons;
	}

	public void setChargeOfficeChargePersons(String chargeOfficeChargePersons) {

		this.chargeOfficeChargePersons = chargeOfficeChargePersons;
	}

	public List<TableOfficeElement> getLeadOfficeList() {

		return leadOfficeList;
	}

	public void setLeadOfficeList(List<TableOfficeElement> leadOfficeList) {

		this.leadOfficeList = leadOfficeList;
	}

	public List<TableOfficeElement> getDutyOfficeList() {

		return dutyOfficeList;
	}

	public void setDutyOfficeList(List<TableOfficeElement> dutyOfficeList) {

		this.dutyOfficeList = dutyOfficeList;
	}

	public List<TableOfficeElement> getChargeOfficeList() {

		return chargeOfficeList;
	}

	public void setChargeOfficeList(List<TableOfficeElement> chargeOfficeList) {

		this.chargeOfficeList = chargeOfficeList;
	}

	public String getTaskState() {

		return taskState;
	}

	public void setTaskState(String taskState) {

		this.taskState = taskState;
	}

	public static long getSerialversionuid() {

		return serialVersionUID;
	}
}
