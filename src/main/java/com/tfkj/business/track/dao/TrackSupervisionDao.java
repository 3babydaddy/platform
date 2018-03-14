/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.tfkj.business.track.dao;

import com.tfkj.business.Inspection.entity.RelationPo;
import com.tfkj.business.track.entity.TrackSupervision;
import com.tfkj.framework.core.persistence.CrudDao;
import com.tfkj.framework.core.persistence.annotation.MyBatisDao;

import java.util.List;

/**
 * @Description: 专项督查
 * @author lixin
 * @date 2018年1月16日
 */
@MyBatisDao
public interface TrackSupervisionDao extends CrudDao<TrackSupervision> {

    public int updateInspection(TrackSupervision entity);

    public List<RelationPo> findRelationList(RelationPo entity);

}
