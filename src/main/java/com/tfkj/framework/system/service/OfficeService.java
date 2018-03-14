/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tf.permission.client.entity.DepartmentInfo;
import com.tfkj.framework.core.service.BaseService;
import com.tfkj.framework.core.service.TreeService;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.system.dao.OfficeDao;
import com.tfkj.framework.system.entity.Office;
import com.tfkj.framework.system.entity.User;
import com.tfkj.framework.system.utils.ConstantsUtil;
import com.tfkj.framework.system.utils.UserUtils;

/**
 * 单位Service
 * 
 * @author ThinkGem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = false)
public class OfficeService extends TreeService<OfficeDao, Office> {

	/**
	 * @Title: findList
	 * @Description: 查询单位
	 * @param @param isAll true:包括类型
	 * @param @return 参数
	 * @return List<Office> 返回类型
	 * @throws
	 */
	public List<DepartmentInfo> findList(Boolean isAll) {
		return UserUtils.getOfficeAllList();
	}

	@Override
	@Transactional(readOnly = true)
	public List<Office> findList(Office office) {

		if (office != null) {
			office.setParentIds(office.getParentIds() + "%");
			return dao.findByParentIdsLike(office);
		}
		return new ArrayList<Office>();
	}

	@Override
	@Transactional(readOnly = false)
	public void save(Office office) {

		Office entity = this.get(office);
		if (entity == null) {
			office.setIsNewRecord(true);
		}
		super.save(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_ALL_LIST);
	}

	@Override
	@Transactional(readOnly = false)
	public void delete(Office office) {

		super.delete(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}

	/**
	 * @Title: getParentOffice
	 * @Description: 获取直接上级单位
	 * @param @param parent
	 * @param @return 参数
	 * @return Office 返回类型
	 * @throws
	 */
	@Transactional(readOnly = false)
	public Office getParentOffice(Office office) {

		return dao.get(office).getParent();
	}

	/**
	 * @Title: getChildOffice
	 * @Description: 获取所有下级单位信息
	 * @param @return 参数
	 * @return int 返回类型
	 * @throws
	 */
	@Transactional(readOnly = false)
	public List<Office> getChildOffice(Office office) {

		return dao.findByParentIdsLike(office);
	}

	/**
	 * @Title: batchUpdate
	 * @Description: 批量更新
	 * @param @param ids
	 * @param @param jgxz
	 * @param @param version
	 * @param @param stateFlag
	 * @param @param sorts 参数
	 * @return void 返回类型
	 * @throws
	 */
	@Transactional(readOnly = false)
	public void batchUpdate(String[] ids, String[] jgxz, String[] version,
			String[] stateFlag, Integer[] sorts) {

		Map<String, Integer> map = new HashMap<String, Integer>();
		for (int i = 0; i < ids.length; i++) {
			map.put(ids[i], sorts[i]);
		}
		for (int i = 0; i < ids.length; i++) {
			if (StringUtils.isBlank(ids[i])) {
				continue;
			}
			Office office = new Office(ids[i]);
			// 清除TreeEntity的默认parent_id
			office.setParent(null);
			int sort = ConstantsUtil
					.getArraySortByValue(sorts, map.get(ids[i])) * 10;
			/*
			 * office.setJgxz(jgxz[i]); office.setVersion(version[i]);
			 * office.setStateFlag(stateFlag[i]);
			 */
			office.setSort(sort);
			office.preUpdate();
			dao.update(office);
		}
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_ALL_LIST);
	}

	/**
	 * 查询list
	 * 
	 * @param office
	 * @return
	 */
	public List<DepartmentInfo> findCxList(Office office) {
		return UserUtils.getOfficeAllList();
	}
}
