/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.framework.system.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tfkj.framework.core.service.CrudService;
import com.tfkj.framework.system.dao.HolidayDao;
import com.tfkj.framework.system.entity.Holiday;

/**
 * 字段提示Service
 * 
 * @author sunxuelong
 */
@Service
@Transactional(readOnly = true)
public class HolidayService extends CrudService<HolidayDao, Holiday> {

}
