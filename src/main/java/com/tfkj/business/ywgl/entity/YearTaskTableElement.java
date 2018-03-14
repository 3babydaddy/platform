package com.tfkj.business.ywgl.entity;

import java.util.List;

import com.tfkj.business.web.constants.YwglConstants;
import com.tfkj.framework.core.persistence.DataEntity;
import com.tfkj.framework.core.utils.StringUtils;

public class YearTaskTableElement extends DataEntity<YearTaskTableElement> {

	private static final long serialVersionUID = 1L;

	// 数据ID
	private String dataId;

	// 父类排序号
	private String parentSort;

	// 合并-列
	private String columnNum;

	// 年度
	private String taskYear;

	// 排序序号
	private String sort;

	// 目标任务
	private String targetTask;

	// 目标任务完成状态
	private String targetTaskState;

	// 分解任务完成状态
	private String taskState;

	// 所在季度
	private String taskQuarter;

	// 分解任务进度安排
	private String taskPlan;

	// 分解任务完成情况
	private String taskExecution;

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

	// 牵头单位责任人
	private String leadOfficeChargePersons;

	// 责任单位责任人
	private String dutyOfficeChargePersons;

	// 分管区单位责任人
	private String chargeOfficeChargePersons;

	// 牵头单位
	private List<TableOfficeElement> leadOfficeList;

	// 责任单位
	private List<TableOfficeElement> dutyOfficeList;

	// 分管区单位
	private List<TableOfficeElement> chargeOfficeList;

	// 分解任务-第一季度-进度安排
	private String firstQuarterTaskPlan;

	// 分解任务-第二季度-进度安排
	private String secondQuarterTaskPlan;

	// 分解任务-第三季度-进度安排
	private String thirdQuarterTaskPlan;

	// 分解任务-第四季度-进度安排
	private String fourthQuarterTaskPlan;

	// 分解任务-第一季度-完成情况
	private String firstQuarterTaskExecution;

	// 分解任务-第二季度-完成情况
	private String secondQuarterTaskExecution;

	// 分解任务-第三季度-完成情况
	private String thirdQuarterTaskExecution;

	// 分解任务-第四季度-完成情况
	private String fourthQuarterTaskExecution;

	// 父类元素用于前台展示
	// 排序序号
	// 目标任务
	// 牵头单位Names
	// 责任单位Names
	// 分管区单位Names
	// 牵头单位ChargePersons
	// 责任单位ChargePersons
	// 分管区单位ChargePersons
	public String getTargetTaskState() {

		return targetTaskState;
	}

	public void setTargetTaskState(String targetTaskState) {

		this.targetTaskState = targetTaskState;
	}

	public String getTaskState() {

		return taskState;
	}

	public void setTaskState(String taskState) {

		this.taskState = taskState;
	}

	public String getFirstQuarterTaskPlan() {

		if (StringUtils.isNotBlank(taskQuarter)) {
			if (taskQuarter.indexOf(YwglConstants.FIRST_QUARTER) != -1) {
				return taskPlan;
			}
		}
		return firstQuarterTaskPlan;
	}

	public void setFirstQuarterTaskPlan(String firstQuarterTaskPlan) {

		this.firstQuarterTaskPlan = firstQuarterTaskPlan;
	}

	public String getSecondQuarterTaskPlan() {

		if (StringUtils.isNotBlank(taskQuarter)) {
			if (taskQuarter.indexOf(YwglConstants.SECOND_QUARTER) != -1) {
				return taskPlan;
			}
		}
		return secondQuarterTaskPlan;
	}

	public void setSecondQuarterTaskPlan(String secondQuarterTaskPlan) {

		this.secondQuarterTaskPlan = secondQuarterTaskPlan;
	}

	public String getThirdQuarterTaskPlan() {

		if (StringUtils.isNotBlank(taskQuarter)) {
			if (taskQuarter.indexOf(YwglConstants.THIRD_QUARTER) != -1) {
				return taskPlan;
			}
		}
		return thirdQuarterTaskPlan;
	}

	public void setThirdQuarterTaskPlan(String thirdQuarterTaskPlan) {

		this.thirdQuarterTaskPlan = thirdQuarterTaskPlan;
	}

	public String getFourthQuarterTaskPlan() {

		if (StringUtils.isNotBlank(taskQuarter)) {
			if (taskQuarter.indexOf(YwglConstants.FOURTH_QUARTER) != -1) {
				return taskPlan;
			}
		}
		return fourthQuarterTaskPlan;
	}

	public void setFourthQuarterTaskPlan(String fourthQuarterTaskPlan) {

		this.fourthQuarterTaskPlan = fourthQuarterTaskPlan;
	}

	public String getFirstQuarterTaskExecution() {

		if (StringUtils.isNotBlank(taskQuarter)) {
			if (taskQuarter.indexOf(YwglConstants.FIRST_QUARTER) != -1) {
				return taskExecution;
			}
		}
		return firstQuarterTaskExecution;
	}

	public void setFirstQuarterTaskExecution(String firstQuarterTaskExecution) {

		this.firstQuarterTaskExecution = firstQuarterTaskExecution;
	}

	public String getSecondQuarterTaskExecution() {

		if (StringUtils.isNotBlank(taskQuarter)) {
			if (taskQuarter.indexOf(YwglConstants.SECOND_QUARTER) != -1) {
				return taskExecution;
			}
		}
		return secondQuarterTaskExecution;
	}

	public void setSecondQuarterTaskExecution(String secondQuarterTaskExecution) {

		this.secondQuarterTaskExecution = secondQuarterTaskExecution;
	}

	public String getThirdQuarterTaskExecution() {

		if (StringUtils.isNotBlank(taskQuarter)) {
			if (taskQuarter.indexOf(YwglConstants.THIRD_QUARTER) != -1) {
				return taskExecution;
			}
		}
		return thirdQuarterTaskExecution;
	}

	public void setThirdQuarterTaskExecution(String thirdQuarterTaskExecution) {

		this.thirdQuarterTaskExecution = thirdQuarterTaskExecution;
	}

	public String getFourthQuarterTaskExecution() {

		if (StringUtils.isNotBlank(taskQuarter)) {
			if (taskQuarter.indexOf(YwglConstants.FOURTH_QUARTER) != -1) {
				return taskExecution;
			}
		}
		return fourthQuarterTaskExecution;
	}

	public void setFourthQuarterTaskExecution(String fourthQuarterTaskExecution) {

		this.fourthQuarterTaskExecution = fourthQuarterTaskExecution;
	}

	public String getLeadOfficeIds() {

		StringBuilder ids = new StringBuilder();
		if (leadOfficeList != null && !leadOfficeList.isEmpty()) {
			for (TableOfficeElement table : leadOfficeList) {
				ids.append(table.getOffice().getId());
				ids.append(",");
			}
		}
		leadOfficeIds = ids.toString();
		return leadOfficeIds;
	}

	public void setLeadOfficeIds(String leadOfficeIds) {

		this.leadOfficeIds = leadOfficeIds;
	}

	public String getDutyOfficeIds() {

		StringBuilder ids = new StringBuilder();
		if (dutyOfficeList != null && !dutyOfficeList.isEmpty()) {
			for (TableOfficeElement table : dutyOfficeList) {
				ids.append(table.getOffice().getId());
				ids.append(",");
			}
		}
		dutyOfficeIds = ids.toString();
		return dutyOfficeIds;
	}

	public void setDutyOfficeIds(String dutyOfficeIds) {

		this.dutyOfficeIds = dutyOfficeIds;
	}

	public String getChargeOfficeIds() {

		StringBuilder ids = new StringBuilder();
		if (chargeOfficeList != null && !chargeOfficeList.isEmpty()) {
			for (TableOfficeElement table : chargeOfficeList) {
				ids.append(table.getOffice().getId());
				ids.append(",");
			}
		}
		chargeOfficeIds = ids.toString();
		return chargeOfficeIds;
	}

	public void setChargeOfficeIds(String chargeOfficeIds) {

		this.chargeOfficeIds = chargeOfficeIds;
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

	public String getLeadOfficeNames() {

		StringBuilder names = new StringBuilder();
		if (leadOfficeList != null && !leadOfficeList.isEmpty()) {
			for (TableOfficeElement table : leadOfficeList) {
				names.append(table.getOffice().getName());
				names.append(",");
			}
		}
		leadOfficeNames = names.toString();
		return leadOfficeNames;
	}

	public void setLeadOfficeNames(String leadOfficeNames) {

		this.leadOfficeNames = leadOfficeNames;
	}

	public String getDutyOfficeNames() {

		StringBuilder names = new StringBuilder();
		if (dutyOfficeList != null && !dutyOfficeList.isEmpty()) {
			for (TableOfficeElement table : dutyOfficeList) {
				names.append(table.getOffice().getName());
				names.append(",");
			}
		}
		dutyOfficeNames = names.toString();
		return dutyOfficeNames;
	}

	public void setDutyOfficeNames(String dutyOfficeNames) {

		this.dutyOfficeNames = dutyOfficeNames;
	}

	public String getChargeOfficeNames() {

		StringBuilder names = new StringBuilder();
		if (chargeOfficeList != null && !chargeOfficeList.isEmpty()) {
			for (TableOfficeElement table : chargeOfficeList) {
				names.append(table.getOffice().getName());
				names.append(",");
			}
		}
		chargeOfficeNames = names.toString();
		return chargeOfficeNames;
	}

	public void setChargeOfficeNames(String chargeOfficeNames) {

		this.chargeOfficeNames = chargeOfficeNames;
	}

	public String getParentSort() {

		return parentSort;
	}

	public void setParentSort(String parentSort) {

		this.parentSort = parentSort;
	}

	public String getDataId() {

		return dataId;
	}

	public void setDataId(String dataId) {

		this.dataId = dataId;
	}

	public String getColumnNum() {

		return columnNum;
	}

	public void setColumnNum(String columnNum) {

		this.columnNum = columnNum;
	}

	public String getTaskYear() {

		return taskYear;
	}

	public void setTaskYear(String taskYear) {

		this.taskYear = taskYear;
	}

	public String getSort() {

		return sort;
	}

	public void setSort(String sort) {

		this.sort = sort;
	}

	public String getTargetTask() {

		return targetTask;
	}

	public void setTargetTask(String targetTask) {

		this.targetTask = targetTask;
	}

	public String getTaskQuarter() {

		return taskQuarter;
	}

	public void setTaskQuarter(String taskQuarter) {

		this.taskQuarter = taskQuarter;
	}

	public String getTaskPlan() {

		return taskPlan;
	}

	public void setTaskPlan(String taskPlan) {

		this.taskPlan = taskPlan;
	}

	public String getTaskExecution() {

		return taskExecution;
	}

	public void setTaskExecution(String taskExecution) {

		this.taskExecution = taskExecution;
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

	public static long getSerialversionuid() {

		return serialVersionUID;
	}
}
