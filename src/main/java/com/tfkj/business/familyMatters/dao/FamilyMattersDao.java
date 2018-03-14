package com.tfkj.business.familyMatters.dao;

import com.tfkj.business.familyMatters.entity.FamilyMatters;
import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;

/**
 * 家庭重大事项登记管理
 * @author waixie011
 *
 */
@MyBatisDao
public interface FamilyMattersDao extends CrudDao<FamilyMatters> {

	/**
	 * 更新
	 * @param entity
	 * @return
	 */
	public int updateFamilyMatters(FamilyMatters entity);
	
}
