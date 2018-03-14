package com.tfkj.business.web.constants;

import java.io.File;

/**
 * @Description: 系统业务中常用转义参数
 * @author gaowei
 * @date 2018年1月15日
 */
public class Constants {

	/**
	 * 单位导入,导出所用参数
	 */
	public static final String EXCEL_TITLE_OFFICE_NAME_LIST = "单位管理列表数据";

	public static final String EXPORT_LIST_TYPE_INPUT_ZIP_FOR_OFFICE = "16"; // 导入单位列表

	/**
	 * 项目初始版本号
	 */
	public static final String INIT_WEB_VERSION = "V1.0.0";

	/**
	 * 系统默认登陆密码
	 */
	public static final String SYSTEM_DEFAULT_LOGIN_PASSWORD = "123456";

	/**
	 * 判断当前系统是网络版还是单机版
	 */
	public static final String SYSTEM_VERSION_TYPE = "zzbjsdj.type"; // 版本key

	public static final String SYSTEM_VERSION_STATE_ALONE = "1"; // 单机版

	public static final String SYSTEM_VERSION_STATE_WEB = "0"; // 网络版

	/**
	 * 单位是否可用
	 */
	public static final String OFFICE_AVAILABLE = "1"; // 可用

	public static final String OFFICE_UN_AVAILABLE = "0"; // 停用

	/**
	 * 单位停用-名称后缀
	 */
	public static final String OFFICE_UN_AVAILABLE_NAME = "(停用)"; // 停用

	/**
	 * 规则引擎-规则类型
	 */
	public static final String DROOLS_RULE_TYPE_FIRST_COMMIT = "02"; // 初次提交

	public static final String DROOLS_RULE_TYPE_SECOND_COMMIT = "03"; // 二次提交（提交)

	/**
	 * 全局-不涉及
	 */
	public static final String YW_ZJ_DICT_BSJ = "w";// 不涉及

	public static final String YW_ZJ_DICT_BSJ_CHNAME = "不涉及";// 不涉及

	public static final String YW_DICT_KONG = "0000";// 空

	/**
	 * 全局-否/是
	 */
	public static final String YW_BFS_DICT_NO = "N";// 否

	public static final String RYW_BFS_DICT_YES = "Y";// 是

	/**
	 * 浏览器返回
	 */
	public static final String WEB_PAGE_GO_BACK = "100";// 退回一次

	public static final String WEB_PAGE_GO_BACK_TWO = "200";// 退回二次

	/**
	 * 管理员的parentId
	 */
	public static final String SUPER_ADMIN_PARENT_ID = "0";

	/**
	 * 登录用户角色
	 */
	public static final String LOGIN_ROLE_SUPER_ADMIN = "01";// 管理员登录列表

	public static final String LOGIN_ROLE_NORMAL_ADMIN = "02";// 填报单位登录列表

	/**
	 * 已读未读标记
	 */
	public static final String READFLAG_WD = "0"; // 未读

	public static final String READFLAG_YD = "1"; // 已读

	/**
	 * 操作类型
	 */
	public static final String OPER_TYPE_READ = "00"; // 阅读

	public static final String OPER_TYPE_ADD = "01"; // 新增

	public static final String OPER_TYPE_UPDATE = "02"; // 修改

	public static final String OPER_TYPE_DELETE = "03"; // 删除

	public static final String OPER_TYPE_FIND = "04"; // 查看

	/**
	 * 用户类型
	 */
	public static final String YWGL = "01"; // 业务管理员

	public static final String XTGL = "02";// 系统管理

	public static final String AQBM = "03";// 安全保密员

	public static final String AQSJ = "04";// 安全审计员

	/**
	 * 暂无照片图片base64码
	 */
	public static final String PHOTO_EMPTY = "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";

	/**
	 * 导出word模版中附件状态
	 */
	public static final String ATTACHMENT_STATUS_EMPTY = "无附件";

	public static final String ATTACHMENT_STATUS_EXIST = "有附件";

	/**
	 * freemarker模版位置
	 */
	public static final String FREEMARKER_PATH = "static" + File.separator + "wordTemplate";

	public static final String FREEMARKER_PATH_Excel = "static" + File.separator + "excelTemplate";
}
