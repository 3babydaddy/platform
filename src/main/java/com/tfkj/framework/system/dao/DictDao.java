/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;
import com.tfkj.framework.system.entity.Dict;

/**
 * 字典DAO接口
 *
 * @author ThinkGem
 * @version 2014-05-16
 */
@MyBatisDao
public interface DictDao extends CrudDao<Dict> {

	// 查询码表中原有的四种公告类型
	List<Dict> selectType(String typeenName);

	/**
	 * @Title: findDictListByDictType
	 * @Description: 根据字典类型查询码值集合
	 * @param @param dictType
	 * @param @return 参数
	 * @return List<Dict> 返回类型
	 * @throws
	 */
	List<Dict> findDictListByDictType(String dictType);

	/**
	 * @Title: findDictRemarks
	 * @Description: 根据字典类型查询码值备注
	 * @param @param dictType
	 * @param @param dictValue
	 * @param @return 参数
	 * @return Integer 返回类型
	 * @throws
	 */
	String findDictRemarks(@Param("dictType") String dictType, @Param("dictValue") String dictValue);
}
