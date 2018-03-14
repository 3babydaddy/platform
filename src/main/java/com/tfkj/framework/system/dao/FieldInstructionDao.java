/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.dao;

import java.util.List;

import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;
import com.tfkj.framework.system.entity.FieldInstruction;

/**
 * 字段提示DAO接口
 * 
 * @author sunxuelong
 */
@MyBatisDao
public interface FieldInstructionDao extends CrudDao<FieldInstruction> {
	//查询出所有数据 无条件限制 用于导出使用
	public List<FieldInstruction> selectAll(FieldInstruction fieldInstruction);

}