package com.tfkj.business.batch.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.pagehelper.StringUtil;
import com.tfkj.business.Inspection.entity.RelationPo;
import com.tfkj.business.batch.dao.RelationDao;
import com.tfkj.business.batch.dao.RemindersDao;
import com.tfkj.business.batch.entity.Relation;
import com.tfkj.business.batch.entity.Reminders;
import com.tfkj.business.web.constants.YwglConstants;
import com.tfkj.business.web.constants.YwglConstantsUtil;
import com.tfkj.business.ywgl.dao.InstructionsDao;
import com.tfkj.business.ywgl.dao.TableOfficeElementDao;
import com.tfkj.business.ywgl.entity.Instructions;
import com.tfkj.business.ywgl.entity.InstructionsElement;
import com.tfkj.business.ywgl.entity.TableOfficeElement;
import com.tfkj.business.ywgl.service.TableOfficeElementService;
import com.tfkj.framework.core.service.CrudService;
import com.tfkj.framework.core.utils.IdGen;
import com.tfkj.framework.core.utils.StringUtils;
import com.tfkj.framework.core.web.page.PageParam;
import com.tfkj.framework.core.web.page.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Description: 专项督监
 * @author lixin
 * @date 2018年1月16日
 */
@Service
@Transactional(readOnly = true)
public class RelationService extends CrudService<RelationDao, Relation> {

    @Autowired
    private RelationDao relationDao;
    @Autowired
    private InstructionsDao instructionsDao;

    public List<Relation> findRelationList(Relation entity){
        return relationDao.findRelationList(entity);
    }

    /**
     * 查询分页数据
     * @param entity
     * @param pageParam
     * @return
     */
    public PageResult<InstructionsElement> findListPage(Instructions entity,Boolean isPage, PageParam pageParam) {
    	if(isPage){
    		 // 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
            entity.getSqlMap().put("dsf", dataScopeFilter(entity.getCurrentUser(), "o", "u"));
            PageHelper.offsetPage(pageParam.getOffset(), pageParam.getLimit());
    	}
        if (!StringUtils.isBlank(pageParam.getOrderBy())) {
            PageHelper.orderBy(pageParam.getOrderBy());
        }
        PageInfo<Instructions> pageInfo = new PageInfo<Instructions>(relationDao.findPageList(entity));
        PageResult<InstructionsElement> pageResult = new PageResult<InstructionsElement>();
        pageResult.setTotal(pageInfo.getTotal());
        List<Instructions> list = pageInfo.getList();
        String ids = "";
        for (Instructions data : list) {
            ids += "'" + data.getUnqId() + "'" + ",";
        }
        if (StringUtil.isNotEmpty(ids)) {
            ids = ids.substring(0, ids.length() - 1);
        }
        if (StringUtil.isEmpty(ids)) {
            ids = "''";
        }
        InstructionsElement instructionsElement = new InstructionsElement();
        instructionsElement.setUnqId(ids);
        instructionsElement.setRelationType(entity.getRelationType());
        instructionsElement.setParentIn0001(entity.getIn0001());
        instructionsElement.setIn0002(entity.getIn0002());
        instructionsElement.setLeaderIds(entity.getLeaderIds());
        instructionsElement.setIn0012(entity.getIn0012());
        instructionsElement.setIn0013(entity.getIn0013());
        instructionsElement.setParentIn0017(entity.getIn0017());
        instructionsElement.setIn0003(entity.getIn0003());
        instructionsElement.setParentIn0011Start(entity.getIn0011Start());
        instructionsElement.setParentIn0011End(entity.getIn0011End());

        instructionsElement.setParentIn0004Start(entity.getIn0004Start());
        instructionsElement.setParentIn0004End(entity.getIn0004End());

        instructionsElement.setTaskYear(entity.getTaskYear());
        instructionsElement.setIn0014(entity.getIn0014());
        if (!StringUtils.isBlank(pageParam.getOrderBy())) {
            PageHelper.orderBy(pageParam.getOrderBy());
        }
        List<InstructionsElement> elementList= relationDao.findAllList(instructionsElement);
        pageResult.setRows(elementList);
        return pageResult;
    }
    @Transactional(readOnly = false)
    public void deleteRelation(InstructionsElement table){
        relationDao.deleteRelation(table);
    }

    @Transactional(readOnly = false)
    public void deleteReminders(InstructionsElement table){
        relationDao.deleteReminders(table);
    }
    public List<InstructionsElement> findAllList(InstructionsElement entity){
        return relationDao.findAllList(entity);
    }



}
