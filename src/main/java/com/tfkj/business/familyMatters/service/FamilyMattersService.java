package com.tfkj.business.familyMatters.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tfkj.business.familyMatters.dao.FamilyMattersDao;
import com.tfkj.business.familyMatters.entity.FamilyMatters;
import com.tfkj.framework.core.service.CrudService;

/**
 * 家庭重大事项登记管理
 * @author waixie011
 *
 */
@Service
@Transactional(readOnly = true)
public class FamilyMattersService extends CrudService<FamilyMattersDao, FamilyMatters> {

	@Autowired
	private FamilyMattersDao familyMattersDao;
	
	/**
	 * 更新
	 * @param table
	 */
	@Transactional(readOnly = false)
    public void updateFamilyMatters(FamilyMatters table){
		familyMattersDao.updateFamilyMatters(table);
    }
	
}
