package com.tfkj.business.Inspection.service;

import com.github.pagehelper.StringUtil;
import com.tfkj.business.Inspection.dao.SpecialSupervisionDao;
import com.tfkj.business.Inspection.entity.RelationPo;
import com.tfkj.business.Inspection.entity.SpecialSupervision;
import com.tfkj.business.web.constants.YwglConstants;
import com.tfkj.business.web.constants.YwglConstantsUtil;
import com.tfkj.business.ywgl.dao.MeetingTableElementDao;
import com.tfkj.business.ywgl.dao.TableOfficeElementDao;
import com.tfkj.business.ywgl.entity.MeetingTableElement;
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
public class SpecialSupervisionService extends CrudService<SpecialSupervisionDao, SpecialSupervision> {

    @Autowired
    private SpecialSupervisionDao specialSupervisionDao;
    @Autowired
    private TableOfficeElementDao tableOfficeElementDao;

    @Autowired
    private TableOfficeElementService tableOfficeElementService;

    public List<RelationPo> findRelationList(RelationPo entity){
        return specialSupervisionDao.findRelationList(entity);
    }
    @Transactional(readOnly = false)
    public void saveElement(SpecialSupervision table){
        List<TableOfficeElement> inspectionRangeList = table.getInspectionRangeList();
        String officeNames = "";
        if (inspectionRangeList != null && !inspectionRangeList.isEmpty()) {
            tableOfficeElementDao.deleteByFieldType(YwglConstants.INSPECTION_RANG_NAME);
            officeNames = YwglConstantsUtil.getOfficeNames(inspectionRangeList);
        }else{
            tableOfficeElementDao.deleteByFieldType(YwglConstants.INSPECTION_RANG_NAME);
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
                    tableOfficeElement.setA0001(YwglConstants.INSPECTION_RANG_NAME);
                    tableOfficeElementService.save(tableOfficeElement);
            	}
            }
        }


    }
    @Transactional(readOnly = false)
    public void updateInspection(SpecialSupervision table){
        specialSupervisionDao.updateInspection(table);
    }
}
