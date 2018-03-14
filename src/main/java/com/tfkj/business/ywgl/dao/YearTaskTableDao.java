/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.business.ywgl.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.tfkj.business.ywgl.entity.YearTaskTableData;
import com.tfkj.business.ywgl.entity.YearTaskTableElement;
import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;

/**
 * @Description: 年度重点任务督查
 * @author gaowei
 * @date 2018年1月16日
 */
@MyBatisDao
public interface YearTaskTableDao extends CrudDao<YearTaskTableData> {

	/**
	 * @Title: findElementListByDataIds
	 * @Description: 根据数据ID查询
	 * @param @param ids
	 * @param @return 参数
	 * @return List<YearTaskTableElement> 返回类型
	 * @throws
	 */
	List<YearTaskTableElement> findElementListByDataIds(@Param("ids") String ids);
}
