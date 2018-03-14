/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.business.ywgl.dao;

import java.util.List;

import com.tfkj.business.ywgl.entity.Instructions;
import com.tfkj.business.ywgl.entity.InstructionsElement;
import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;

/**
 * @Description: 批示件
 * @author gaowei
 * @date 2018年1月30日
 */
@MyBatisDao
public interface InstructionsDao extends CrudDao<Instructions> {

	/**
	 * @Title: findIdsList
	 * @Description: 通过条件查询父元素集合
	 * @param @param instructionsElement
	 * @param @return 参数
	 * @return List<Instructions> 返回类型
	 * @throws
	 */
	List<Instructions> findIdsList(Instructions entity);
	/**
	 * 用于关联查询
	 * @param entity
	 * @return
	 */
	List<Instructions> findListInstruction(Instructions entity);


	List<InstructionsElement> elementList(InstructionsElement ele);

}
