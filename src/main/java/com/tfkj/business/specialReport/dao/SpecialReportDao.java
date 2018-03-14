/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.business.specialReport.dao;

import com.tfkj.business.specialReport.entity.SpecialReport;
import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;

import java.util.List;

/**
 * @Description: 专项督查
 * @author lixin
 * @date 2018年1月16日
 */
@MyBatisDao
public interface SpecialReportDao extends CrudDao<SpecialReport> {

    public int updateInspection(SpecialReport entity);



}
