/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tfkj.framework.core.service.CrudService;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.system.dao.LeaderDao;
import com.tfkj.framework.system.entity.Leader;
import com.tfkj.framework.system.utils.ConstantsUtil;

/**
 * 单位Service
 *
 * @author ThinkGem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = false)
public class LeaderService extends CrudService<LeaderDao, Leader> {

	@Transactional(readOnly = false)
	public void batchUpdate(String[] ids, Integer[] sorts) {

		Map<String, Integer> map = new HashMap<String, Integer>();
		for (int i = 0; i < ids.length; i++) {
			map.put(ids[i], sorts[i]);
		}
		for (int i = 0; i < ids.length; i++) {
			if (StringUtils.isBlank(ids[i])) {
				continue;
			}
			Leader office = new Leader(ids[i]);
			// 清除TreeEntity的默认parent_id
			office.setParent(null);
			int sort = ConstantsUtil.getArraySortByValue(sorts, map.get(ids[i])) * 10;
			/*
			 * office.setJgxz(jgxz[i]);
			 * office.setVersion(version[i]);
			 * office.setStateFlag(stateFlag[i]);
			 */
			office.setSort(sort);
			office.preUpdate();
			dao.update(office);
		}
	}
}
