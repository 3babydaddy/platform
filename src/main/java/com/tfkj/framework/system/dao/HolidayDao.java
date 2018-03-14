/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;
import com.tfkj.framework.system.entity.Holiday;

/**
 * 节假日管理DAO接口
 * 
 * @author sunxuelong
 * @version 2016-12-30
 */
@MyBatisDao
public interface HolidayDao extends CrudDao<Holiday> {

	/**
	 * 工作日list
	 * 
	 * @param day
	 * @return
	 */

	List<Holiday> isExchangeDayList(String day);

	/**
	 * 节假日List
	 * 
	 * @param day
	 * @return
	 */
	List<Holiday> isHolidayList(@Param("day") String day);
}