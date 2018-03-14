/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.dao;

import java.util.Date;

import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;
import com.tfkj.framework.system.entity.DataLog;

/**
 * 数据操作日志DAO接口
 *
 * @author sunxuelong
 * @version 2016-12-21
 */
@MyBatisDao
public interface DataLogDao extends CrudDao<DataLog> {
	/**
	 * @Title: getFirstSubmitDate
	 * @Description: 查询操作日志获得首次提交时间
	 * @param @param dataLog
	 * @param @return 参数
	 * @return Date 返回类型
	 * @throws
	 */
	Date getFirstSubmitDate(DataLog dataLog);

	/**
	 * @Title: getFirstSubmitDate
	 * @Description: 查询操作日志获得初次提交时间
	 * @param @param dataLog
	 * @param @return 参数
	 * @return Date 返回类型
	 * @throws
	 */
	Date getSubmitDate(DataLog dataLog);

	/**
	 * @Title: getFirstSubmitDate
	 * @Description: 查询操作日志获得二次提交时间
	 * @param @param dataLog
	 * @param @return 参数
	 * @return Date 返回类型
	 * @throws
	 */
	Date getSecondSubmitDate(DataLog dataLog);

	/**
	 * @Title: getFirstSubmitDate
	 * @Description: 查询操作日志获得影响任用
	 * @param @param dataLog
	 * @param @return 参数
	 * @return Date 返回类型
	 * @throws
	 */
	Date getNoBloodDate(DataLog dataLog);

	/**
	 * @Title: getFirstSubmitDate
	 * @Description: 查询操作日志获得退回时间
	 * @param @param dataLog
	 * @param @return 参数
	 * @return Date 返回类型
	 * @throws
	 */
	Date getReturnDate(DataLog dataLog);
}