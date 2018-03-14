/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.core.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.tfkj.framework.core.persistence.BaseDao;

/**
 * Service基类
 *
 * @author ThinkGem
 * @version 2014-05-16
 */
@Transactional(readOnly = true)
public abstract class ReportService<D extends BaseDao> extends BaseService {

	/**
	 * 持久层对象
	 */
	@Autowired
	protected D dao;

}
