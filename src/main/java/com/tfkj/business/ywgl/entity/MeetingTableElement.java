package com.tfkj.business.ywgl.entity;

import java.util.List;

import com.github.pagehelper.StringUtil;
import com.tfkj.business.web.constants.YwglConstantsUtil;
import com.tfkj.framework.core.persistence.DataEntity;
import com.tfkj.framework.core.utils.excel.annotation.ExcelField;

public class MeetingTableElement extends DataEntity<MeetingTableElement> {

	private static final long serialVersionUID = 1L;

	// 数据ID
	private String parentId;

	// 合并-列
	private String columnNum;

	// 议定事项状态
	private String state;

	// 销号人
	private String operator;

	// 日常管理
	private String isOpertorTime;

	// 销号时间
	private String opertorTime;

	// 议定事项
	private String agreeMatterName;

	// 牵头区领导
	private String leader;

	// 完成时间
	private String endtime;

	// 责任单位
	private List<TableOfficeElement> officeList;

	// 有关要求
	private String relateRequest;

	// 落实情况
	private String fulfillSituation;

	// 亮度标记
	private String lightFlag;

	// 排序
	private String sort;

	/*** 用于前台展示 ***/
	// 会议类型
	private String meetingType;

	// 会议名称
	private String meetingName;

	// 会议召开时间
	private String meetingTime;

	// 会议顺序
	private String meetingSort;

	// 开始时间
	private String meetingTimeStart;

	// 结束时间
	private String meetingTimeEnd;

	// 完成时限开始时间
	private String endtimeStart;

	// 完成时限结束时间
	private String endtimeEnd;

	// 落实时间开始
	private String opertorTimeStart;

	// 落实时间结束
	private String opertorTimeEnd;

	// 年度
	private String year;

	// 会议ID集合字符串
	private String meetingIds;

	// 单位名称
	private String officeName;

	public String getOfficeName() {

		return officeName;
	}

	public void setOfficeName(String officeName) {

		this.officeName = officeName;
	}

	public String getMeetingIds() {

		return meetingIds;
	}

	public void setMeetingIds(String meetingIds) {

		this.meetingIds = meetingIds;
	}



	public void setOfficeShow(String officeShow) {

	}



	public void setLeaderText(String leaderText) {

	}

	public String getEndtimeStart() {

		return endtimeStart;
	}

	public void setEndtimeStart(String endtimeStart) {

		this.endtimeStart = endtimeStart;
	}

	public String getEndtimeEnd() {

		return endtimeEnd;
	}

	public void setEndtimeEnd(String endtimeEnd) {

		this.endtimeEnd = endtimeEnd;
	}

	public String getOpertorTimeStart() {

		return opertorTimeStart;
	}

	public void setOpertorTimeStart(String opertorTimeStart) {

		this.opertorTimeStart = opertorTimeStart;
	}

	public String getOpertorTimeEnd() {

		return opertorTimeEnd;
	}

	public void setOpertorTimeEnd(String opertorTimeEnd) {

		this.opertorTimeEnd = opertorTimeEnd;
	}

	public String getYear() {

		return year;
	}

	public void setYear(String year) {

		this.year = year;
	}

	public String getMeetingTimeStart() {

		return meetingTimeStart;
	}

	public void setMeetingTimeStart(String meetingTimeStart) {

		this.meetingTimeStart = meetingTimeStart;
	}

	public String getMeetingTimeEnd() {

		return meetingTimeEnd;
	}

	public void setMeetingTimeEnd(String meetingTimeEnd) {

		this.meetingTimeEnd = meetingTimeEnd;
	}

	public String getMeetingSort() {

		return meetingSort;
	}

	public void setMeetingSort(String meetingSort) {

		this.meetingSort = meetingSort;
	}

	public String getMeetingType() {

		return meetingType;
	}

	public void setMeetingType(String meetingType) {

		this.meetingType = meetingType;
	}
	@ExcelField(align = 2, type = 0, sort = 1000, title = "会议名称")
	public String getMeetingName() {

		return meetingName;
	}

	@ExcelField(align = 2, type = 0, sort = 2000, title = "召开时间")
	public String getMeetingTime() {

		return meetingTime;
	}

	@ExcelField(align = 2, type = 0, sort = 3000, title = "跟踪督办事项")
	public String getAgreeMatterName() {

		return agreeMatterName;
	}

	@ExcelField(align = 2, type = 0, sort = 4000, title = "有关要求")
	public String getRelateRequest() {

		return relateRequest;
	}

	@ExcelField(align = 2, type = 0, sort = 5000, title = "牵头领导")
	public String getLeaderText() {

		return YwglConstantsUtil.getLeaderNames(this.leader);
	}

	@ExcelField(align = 2, type = 0, sort = 6000, title = "责任单位")
	public String getOfficeShow() {
		String show = "";
		Boolean flag = true;
		int i = 0;
		if (this.officeList != null && this.officeList.size() > 0) {
			for (TableOfficeElement tableOfficeElement : officeList) {
				if (tableOfficeElement.getOffice() != null && flag) {
					show = tableOfficeElement.getOffice().getName();
					flag = false;
				}
				if (tableOfficeElement.getOffice() != null) {
					i++;
				}
			}
			if (i > 1) {
				show += "等";
				show += "" + String.valueOf(i) + "家单位";
			}
		}
		return show;
	}

	@ExcelField(align = 2, type = 0, sort = 7000, title = "完成时限")
	public String getEndtime() {

		return endtime;
	}

	@ExcelField(align = 2, type = 0, sort = 8000, title = "落实情况")
	public String getFulfillSituation() {

		return fulfillSituation;
	}

	@ExcelField(align = 2, type = 0, sort = 9000, title = "状态")
	public String getStateShow() {
		String name="";
		if(StringUtil.isNotEmpty(state)){
			if("N".equals(state)){
				name="未落实";
			}
			if("Y".equals(state)){
				name="已落实";
			}
		}
		return name;
	}
	public String getState() {

		return state;
	}

	@ExcelField(align = 2, type = 0, sort = 10000, title = "落实时间")
	public String getOpertorTime() {

		return opertorTime;
	}

	public String getIsOpertorTime() {

		return isOpertorTime;
	}

	public void setMeetingName(String meetingName) {

		this.meetingName = meetingName;
	}



	public void setMeetingTime(String meetingTime) {

		this.meetingTime = meetingTime;
	}

	public String getSort() {

		return sort;
	}

	public void setSort(String sort) {

		this.sort = sort;
	}

	public String getLightFlag() {

		return lightFlag;
	}

	public void setLightFlag(String lightFlag) {

		this.lightFlag = lightFlag;
	}

	public String getParentId() {

		return parentId;
	}

	public void setParentId(String parentId) {

		this.parentId = parentId;
	}

	public String getColumnNum() {

		return columnNum;
	}

	public void setColumnNum(String columnNum) {

		this.columnNum = columnNum;
	}



	public void setState(String state) {

		this.state = state;
	}

	public String getOperator() {

		return operator;
	}

	public void setOperator(String operator) {

		this.operator = operator;
	}



	public void setIsOpertorTime(String isOpertorTime) {

		this.isOpertorTime = isOpertorTime;
	}



	public void setOpertorTime(String opertorTime) {

		this.opertorTime = opertorTime;
	}



	public void setAgreeMatterName(String agreeMatterName) {

		this.agreeMatterName = agreeMatterName;
	}

	public String getLeader() {

		return leader;
	}

	public void setLeader(String leader) {

		this.leader = leader;
	}


	public void setEndtime(String endtime) {

		this.endtime = endtime;
	}

	public List<TableOfficeElement> getOfficeList() {

		return officeList;
	}

	public void setOfficeList(List<TableOfficeElement> officeList) {

		this.officeList = officeList;
	}



	public void setRelateRequest(String relateRequest) {

		this.relateRequest = relateRequest;
	}



	public void setFulfillSituation(String fulfillSituation) {

		this.fulfillSituation = fulfillSituation;
	}

	public static long getSerialversionuid() {

		return serialVersionUID;
	}
}
