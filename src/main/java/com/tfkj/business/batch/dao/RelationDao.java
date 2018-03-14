/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.business.batch.dao;

import com.tfkj.business.Inspection.entity.RelationPo;
import com.tfkj.business.batch.entity.Relation;
import com.tfkj.business.batch.entity.Reminders;
import com.tfkj.business.ywgl.entity.Instructions;
import com.tfkj.business.ywgl.entity.InstructionsElement;
import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;

import java.util.List;

/**
 * @Description: 专项督查
 * @author lixin
 * @date 2018年1月16日
 */
@MyBatisDao
public interface RelationDao extends CrudDao<Relation> {

    public List<Relation> findRelationList(Relation entity);

    public List<Instructions> findPageList(Instructions entity);

    List<InstructionsElement> findAllList(InstructionsElement entity);

    void deleteRelation(InstructionsElement entity);

    void deleteReminders(InstructionsElement entity);

}
