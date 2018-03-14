/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.service;

import java.util.Date;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tf.permission.client.entity.User;
import com.tfkj.framework.core.service.CrudService;
import com.tfkj.framework.system.dao.DataLogDao;
import com.tfkj.framework.system.entity.DataLog;

/**
 * 数据日志Service
 *
 * @author sunxuelong
 */
@Service
@Transactional(readOnly = true)
public class DataLogService extends CrudService<DataLogDao, DataLog> {
	/**
	 * 记录数据日志
	 * 必填项：
	 * 数据类型（字典YW_RZ_SJLX）
	 * 数据ID
	 * 操作类型（字典YW_RZ_CZLX）
	 * 选填项：
	 * 操作内容
	 */
	@Override
	public void save(DataLog dataLog) {
		User user = dataLog.getCurrentUser();
//		user.getLoginIp();
//		dataLog.setOperBy(user);
//		dataLog.setOperIp(user.getLoginIp());
		dataLog.setOperDate(new Date());
		super.save(dataLog);
	}

	/**
	 * @Title: getFirstSubmitDate
	 * @Description: 根据数据ID和数据类型查询该条数据的首次提交时间
	 * @param @param dataId
	 * @param @param dataType
	 * @param @return 参数
	 * @return Date 返回类型
	 * @throws
	 */
	public Date getFirstSubmitDate(String dataId, String dataType) {
		DataLog dataLog = new DataLog();
		dataLog.setDataId(dataId);
		dataLog.setDataType(dataType);
		Date firstSubmitDate = dao.getFirstSubmitDate(dataLog);
		return firstSubmitDate;

	}

	/**
	 * @Title: getSubmitDate
	 * @Description: 查询操作日志获得初次提交时间
	 * @param @param dataLog
	 * @param @return 参数
	 * @return Date 返回类型
	 * @throws
	 */
	public Date getSubmitDate(String dataId, String dataType) {
		DataLog dataLog = new DataLog();
		dataLog.setDataId(dataId);
		dataLog.setDataType(dataType);
		Date submitDate = dao.getSubmitDate(dataLog);

		return submitDate;

	}

	/**
	 * @Title: getSecondSubmitDate
	 * @Description: 查询操作日志获得二次提交时间
	 * @param @param dataLog
	 * @param @return 参数
	 * @return Date 返回类型
	 * @throws
	 */
	public Date getSecondSubmitDate(String dataId, String dataType) {
		DataLog dataLog = new DataLog();
		dataLog.setDataId(dataId);
		dataLog.setDataType(dataType);
		Date secondSubmitDate = dao.getSecondSubmitDate(dataLog);

		return secondSubmitDate;

	}

	/**
	 * @Title: getNoBloodDate
	 * @Description: 查询操作日志获得影响任用
	 * @param @param dataLog
	 * @param @return 参数
	 * @return Date 返回类型
	 * @throws
	 */
	public Date getNoBloodDate(String dataId, String dataType) {
		DataLog dataLog = new DataLog();
		dataLog.setDataId(dataId);
		dataLog.setDataType(dataType);
		Date noBloodDate = dao.getNoBloodDate(dataLog);

		return noBloodDate;

	}

	/**
	 * @Title: getReturnDate
	 * @Description: 查询操作日志获得退回时间
	 * @param @param dataLog
	 * @param @return 参数
	 * @return Date 返回类型
	 * @throws
	 */
	public Date getReturnDate(String dataId, String dataType) {
		DataLog dataLog = new DataLog();
		dataLog.setDataId(dataId);
		dataLog.setDataType(dataType);
		Date returnDate = dao.getReturnDate(dataLog);

		return returnDate;

	}
}