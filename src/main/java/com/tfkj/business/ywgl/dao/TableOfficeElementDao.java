/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.business.ywgl.dao;

import org.apache.ibatis.annotations.Param;

import com.tfkj.business.ywgl.entity.TableOfficeElement;
import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;

/**
 * @Description: 表格单位
 * @author gaowei
 * @date 2018年1月16日
 */
@MyBatisDao
public interface TableOfficeElementDao extends CrudDao<TableOfficeElement> {

	/**
	 * 根据父级id删除相关数据
	 *
	 * @param dataId
	 */
	public void deleteByDataId(@Param("dataId") String dataId);

	/**
	 * @Title: deleteByFieldType
	 * @Description: 根据绑定字段删除
	 * @param @param fieldType 参数
	 * @return void 返回类型
	 * @throws
	 */
	public void deleteByFieldType(@Param("fieldType") String fieldType);

	/**
	 * @Title: getByDataIdAndFieldType
	 * @Description: 根据数据Id和绑定字段查询
	 * @param @param dataId
	 * @param @param fieldType 参数
	 * @return void 返回类型
	 * @throws
	 */
	public void getByDataIdAndFieldType(@Param("dataId") String dataId, @Param("fieldType") String fieldType);
}
