package com.tfkj.business.web.constants;

/**
 * @Description: 业务管理中使用的常量
 * @author gaowei
 * @date 2018年1月23日
 */
public class YwglConstants {

	/**
	 * 季度
	 */
	public static final String FIRST_QUARTER = "01";

	public static final String SECOND_QUARTER = "02";

	public static final String THIRD_QUARTER = "03";

	public static final String FOURTH_QUARTER = "04";

	/**
	 * 任务完成状态
	 */
	public static final String TASK_STATE_COMPLETE_OK = "Y";// 已办结

	public static final String TASK_STATE_COMPLETE_NO = "N";// 未办结

	public static final String TASK_STATE_COMPLETE_OK_CNNAME = "已办结";// 已办结

	public static final String TASK_STATE_COMPLETE_NO_CNNAME = "未办结";// 未办结

	/**
	 * 单位附件-绑定字段
	 */
	public static final String TABLE_OFFICE_ELEMENT_FILE_FIELD_COHERE_OFFICE_LIST = "SuperiorInspect.CohereOfficeList";// 对接协调单位

	public static final String TABLE_OFFICE_ELEMENT_FILE_FIELD_DUTY_OFFICE_LIST = "SuperiorInspect.DutyOfficeList";// 承办单位
	/*
	 * 被督查单位
	 */
	public static final String INSPECTION_RANG_NAME_INSTRUCTIONS = "inspectionRangNameInstructions";

	public static final String INSPECTION_RANG_NAME = "inspectionRangName";

	public static final String INSPECTION_RANG_NAME_ASSIGN = "inspectionRangNameAssign";

	public static final String INSPECTION_RANG_NAME_TRACK = "inspectionRangNameTrack";

	public static final String INSPECTION_RANG_NAME_SpecialReport= "inspectionRangNameSpecialReport";

	/**
	 * 领导适用类型
	 */
	public static final String LEADER_TYPE_FGQLD = "01";// 适用于分管区领导

	/**
	 * 批示件--子元素类型
	 */
	public static final String INSTRUCTIONS_ELEMENT_TYPE_OFFICE = "2";// 适用于单位

	public static final String INSTRUCTIONS_ELEMENT_TYPE_LEADER = "1";// 适用于领导

	/**
	 * 导出Excel
	 */
	public static final String EXPORT_EXCEL_NAME_PSJ = "批示件台账";// 批示件
	public static final String EXPORT_EXCEL_NAME_SJLWQDC = "上级来我区督查台账";// 上级来我区督查
	public static final String EXPORT_EXCEL_NAME_ZXDC = "专项督查台账";// 专项督查台账
	public static final String EXPORT_EXCEL_NAME_FAMILYMATTERS = "家庭重大事项登记台账";//家庭重大事项登记台账
	public static final String EXPORT_EXCEL_NAME_HYYDSX = "会议议定事项跟踪督查台账";// 会议议定事项跟踪督查台账
	public static final String EXPORT_EXCEL_NAME_PSJCB = "批示件催办查台账";// 批示件催办查台账

	public static final String EXPORT_EXCEL_NAME_TRACK = "跟踪督查";// 跟踪督查
	public static final String EXPORT_EXCEL_NAME_SPECIAL_REPORT = "专报";
    public static final String EXPORT_EXCEL_NAME_JBDC = "交办督查";
	public static final String EXPORT_EXCEL_NAME_HCDC = "核查督办";
}
