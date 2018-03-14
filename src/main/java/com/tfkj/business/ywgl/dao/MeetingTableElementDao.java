/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.business.ywgl.dao;

import java.util.List;

import com.tfkj.business.ywgl.entity.MeetingTableElement;
import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;

/**
 * 议定事项
 * @author rjwangwei
 *
 */
@MyBatisDao
public interface MeetingTableElementDao extends CrudDao<MeetingTableElement> {
		/**
		 * 根据父级Id返回
		 * @param parentId
		 * @return
		 */
		public List<MeetingTableElement> findListByParentId(String parentId);
}
