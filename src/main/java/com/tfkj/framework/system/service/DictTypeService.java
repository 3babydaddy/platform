/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tfkj.framework.core.service.TreeService;
import com.tfkj.framework.system.dao.DictTypeDao;
import com.tfkj.framework.system.entity.DictType;

/**
 * 字典Service
 * @author ThinkGem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class DictTypeService extends TreeService<DictTypeDao, DictType> {

    public List<DictType> findAllList() {
        return dao.findAllList(new DictType());
    }

    @Override
	@Transactional(readOnly = true)
    public List<DictType> findList(DictType dictType) {
        if (dictType != null) {
            if (dictType.getParentIds() != null) {
                dictType.setParentIds(dictType.getParentIds() + "%");
                return dao.findByParentIdsLike(dictType);
            }
            return super.findList(dictType);
        }
        return new ArrayList<DictType>();
    }

}
