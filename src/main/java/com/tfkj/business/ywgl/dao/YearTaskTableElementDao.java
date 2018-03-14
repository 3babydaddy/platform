/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.business.ywgl.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.tfkj.business.ywgl.entity.YearTaskTableElement;
import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;

/**
 * @Description: 年度重点任务督查
 * @author gaowei
 * @date 2018年1月16日
 */
@MyBatisDao
public interface YearTaskTableElementDao extends CrudDao<YearTaskTableElement> {

	/**
	 * @Title: findListByDataId
	 * @Description: 根据数据ID查询
	 * @param @param dataId
	 * @param @return 参数
	 * @return List<YearTaskTableElement> 返回类型
	 * @throws
	 */
	List<YearTaskTableElement> findListByDataId(@Param("dataId") String dataId);

	/**
	 * @Title: deleteByDataId
	 * @Description: 根据数据IF删除分解任务
	 * @param @param dataId
	 * @param @return 参数
	 * @return int 返回类型
	 * @throws
	 */
	int deleteByDataId(YearTaskTableElement entity);
}
