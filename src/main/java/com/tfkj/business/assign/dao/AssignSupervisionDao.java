/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.business.assign.dao;

import com.tfkj.business.Inspection.entity.RelationPo;
import com.tfkj.business.assign.entity.AssignSupervision;
import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;

import java.util.List;

/**
 * @Description: 专项督查
 * @author lixin
 * @date 2018年1月16日
 */
@MyBatisDao
public interface AssignSupervisionDao extends CrudDao<AssignSupervision> {

    public int updateInspection(AssignSupervision entity);

    public List<RelationPo> findRelationList(RelationPo entity);

}
