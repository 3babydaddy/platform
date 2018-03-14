/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.business.ywgl.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.tfkj.business.ywgl.entity.MeetingTableData;
import com.tfkj.business.ywgl.entity.MeetingTableElement;
import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;

/**
 * @Description: 会议议定事项跟踪督查
 * @author rjwangwei
 * @date 2018年1月16日
 */
@MyBatisDao
public interface MeetingTableDataDao extends CrudDao<MeetingTableData> {
	/**
	 * 用于前台展示
	 * @param ids
	 * @return
	 */
	public List<MeetingTableElement> findListElement(MeetingTableElement ele);
	/**
	 * 查询列表
	 * @param ele
	 * @return
	 */
	public List<MeetingTableData> findList(MeetingTableElement ele);
}
