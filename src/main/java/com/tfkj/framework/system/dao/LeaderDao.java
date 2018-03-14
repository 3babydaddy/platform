/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.dao;

import com.tfkj.framework.core.persistence.TreeDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;
import com.tfkj.framework.system.entity.Leader;

/**
 * 单位DAO接口
 *
 * @author ThinkGem
 * @version 2014-05-16
 */
@MyBatisDao
public interface LeaderDao extends TreeDao<Leader> {

	/**
	 * @Title: updateSort
	 * @Description: 更新排序
	 * @param @param leader
	 * @param @return 参数
	 * @return int 返回类型
	 * @throws
	 */
	int updateSort(Leader leader);
}
