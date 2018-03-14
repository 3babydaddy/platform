/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.business.instructions.dao;

import com.tfkj.business.instructions.entity.InstructionsRelationPo;
import com.tfkj.business.instructions.entity.InstructionsSupervision;
import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;

import java.util.List;

/**
 * @Description: 专项督查
 * @author lixin
 * @date 2018年1月16日
 */
@MyBatisDao
public interface InstructionsSupervisionDao extends CrudDao<InstructionsSupervision> {

    public int updateInspection(InstructionsSupervision entity);

    public List<InstructionsRelationPo> findRelationList(InstructionsRelationPo entity);

    public List<InstructionsRelationPo> findMoreRelationList(InstructionsRelationPo entity);
}
