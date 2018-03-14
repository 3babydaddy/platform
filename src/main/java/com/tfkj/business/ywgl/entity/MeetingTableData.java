package com.tfkj.business.ywgl.entity;

import java.util.List;

import com.tfkj.framework.core.persistence.DataEntity;

public class MeetingTableData extends DataEntity<MeetingTableData> {

	private static final long serialVersionUID = 1L;

	// 分解IDs
	private String relateIds;

	// 合并-行
	private String rowNum;

	// 排序序号
	private String sort;

	// 会议类型
	private String meetingType;

	// 会议名称
	private String meetingName;

	// 会议召开时间
	private String meetingTime;

	//议定事项
	private List<MeetingTableElement> meetingTableElement;

	//开始时间
	private String meetingTimeStart;

	//结束时间
	private String meetingTimeEnd;

	//页数
	private String pageNum;




	public String getPageNum() {
		return pageNum;
	}


	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
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


	//根据议定事项合并单元格
	public String getRowNum() {
		String rowNum="1";
		if(this.meetingTableElement!=null){
			rowNum=String.valueOf(this.meetingTableElement.size())  ;
		}
		return rowNum;
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


	public String getMeetingType() {
		return meetingType;
	}


	public void setMeetingType(String meetingType) {
		this.meetingType = meetingType;
	}


	public String getMeetingName() {
		return meetingName;
	}


	public void setMeetingName(String meetingName) {
		this.meetingName = meetingName;
	}


	public String getMeetingTime() {
		return meetingTime;
	}


	public void setMeetingTime(String meetingTime) {
		this.meetingTime = meetingTime;
	}


	public List<MeetingTableElement> getMeetingTableElement() {
		return meetingTableElement;
	}


	public void setMeetingTableElement(List<MeetingTableElement> meetingTableElement) {
		this.meetingTableElement = meetingTableElement;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public void setRowNum(String rowNum) {
		this.rowNum = rowNum;
	}





}
