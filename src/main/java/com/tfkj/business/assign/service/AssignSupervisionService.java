package com.tfkj.business.assign.service;

import com.github.pagehelper.StringUtil;
import com.tfkj.business.Inspection.entity.RelationPo;
import com.tfkj.business.assign.dao.AssignSupervisionDao;
import com.tfkj.business.assign.entity.AssignSupervision;
import com.tfkj.business.web.constants.YwglConstants;
import com.tfkj.business.web.constants.YwglConstantsUtil;
import com.tfkj.business.ywgl.dao.TableOfficeElementDao;
import com.tfkj.business.ywgl.entity.TableOfficeElement;
import com.tfkj.business.ywgl.service.TableOfficeElementService;
import com.tfkj.framework.core.service.CrudService;
import com.tfkj.framework.core.utils.IdGen;
import com.tfkj.framework.core.utils.StringUtils;
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
public class AssignSupervisionService extends CrudService<AssignSupervisionDao, AssignSupervision> {

    @Autowired
    private AssignSupervisionDao specialSupervisionDao;
    @Autowired
    private TableOfficeElementDao tableOfficeElementDao;

    @Autowired
    private TableOfficeElementService tableOfficeElementService;

    public List<RelationPo> findRelationList(RelationPo entity){
        return specialSupervisionDao.findRelationList(entity);
    }
    @Transactional(readOnly = false)
    public void saveElement(AssignSupervision table){
        List<TableOfficeElement> inspectionRangeList = table.getInspectionRangeList();
        String officeNames = "";
        if (inspectionRangeList != null && !inspectionRangeList.isEmpty()) {
            tableOfficeElementDao.deleteByFieldType(YwglConstants.INSPECTION_RANG_NAME_ASSIGN);
            officeNames = YwglConstantsUtil.getOfficeNames(inspectionRangeList);
        }else{
            tableOfficeElementDao.deleteByFieldType(YwglConstants.INSPECTION_RANG_NAME_ASSIGN);
        }
        if (StringUtils.isNotBlank(officeNames)) {
            table.setInspectionRange(officeNames);
        }
        if (table.getIsNewRecord()) {
            table.preInsert();
            specialSupervisionDao.insert(table);
        } else {
            table.preUpdate();
            specialSupervisionDao.update(table);
        }
        if (inspectionRangeList != null && !inspectionRangeList.isEmpty()) {
            for (TableOfficeElement tableOfficeElement : inspectionRangeList) {
            	if(tableOfficeElement.getOffice()!=null||StringUtil.isNotEmpty(tableOfficeElement.getFilePath())){
            		 String dutyOfficeListId = IdGen.uuid();
                     tableOfficeElement.setId(dutyOfficeListId);
                     tableOfficeElement.setIsNewRecord(true);
                     tableOfficeElement.setDataId(table.getId());
                     tableOfficeElement.setA0001(YwglConstants.INSPECTION_RANG_NAME_ASSIGN);
                     tableOfficeElementService.save(tableOfficeElement);
            	}
            }
        }


    }
    @Transactional(readOnly = false)
    public void updateInspection(AssignSupervision table){
        specialSupervisionDao.updateInspection(table);
    }
}
