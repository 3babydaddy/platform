/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.business.ywgl.dao;

import java.util.List;

import com.tfkj.business.ywgl.entity.InstructionsElement;
import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;

/**
 * @Description: 批示件-子元素
 * @author gaowei
 * @date 2018年1月30日
 */
@MyBatisDao
public interface InstructionsElementDao extends CrudDao<InstructionsElement> {

	/**
	 * @Title: findListByDataId
	 * @Description: 根据父级id查询子元素
	 * @param @param dataId
	 * @param @return 参数
	 * @return List<InstructionsElement> 返回类型
	 * @throws
	 */
	List<InstructionsElement> findListByDataId(String dataId);

	/**
	 * @Title: findPageList
	 * @Description: 获取分页查询数据,用于前台展现
	 * @param @param entity
	 * @param @return 参数
	 * @return List<InstructionsElement> 返回类型
	 * @throws
	 */
	List<InstructionsElement> findPageList(InstructionsElement entity);

	List<InstructionsElement> findOneElement(InstructionsElement entity);
	void updateElement(InstructionsElement entity);

	void updateElementOfficeLeader(InstructionsElement entity);
}
