package com.tfkj.business.instructions.service;

import com.tfkj.business.instructions.entity.InstructionsRelationPo;
import com.tfkj.business.instructions.entity.InstructionsSupervision;
import com.github.pagehelper.StringUtil;
import com.tfkj.business.instructions.dao.InstructionsSupervisionDao;
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
public class InstructionsSupervisionService extends CrudService<InstructionsSupervisionDao, InstructionsSupervision> {

    @Autowired
    private InstructionsSupervisionDao specialSupervisionDao;
    @Autowired
    private TableOfficeElementDao tableOfficeElementDao;

    @Autowired
    private TableOfficeElementService tableOfficeElementService;

    public List<InstructionsRelationPo> findRelationList(InstructionsRelationPo entity){
        return specialSupervisionDao.findRelationList(entity);
    }

    public List<InstructionsRelationPo> findMoreRelationList(InstructionsRelationPo entity){
        return specialSupervisionDao.findMoreRelationList(entity);
    }
    @Transactional(readOnly = false)
    public void saveElement(InstructionsSupervision table){
        List<TableOfficeElement> inspectionRangeList = table.getInspectionRangeList();
        String officeNames = "";
        if (inspectionRangeList != null && !inspectionRangeList.isEmpty()) {
            tableOfficeElementDao.deleteByFieldType(YwglConstants.INSPECTION_RANG_NAME_INSTRUCTIONS);
            officeNames = YwglConstantsUtil.getOfficeNames(inspectionRangeList);
        }else{
            tableOfficeElementDao.deleteByFieldType(YwglConstants.INSPECTION_RANG_NAME_INSTRUCTIONS);
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
                    tableOfficeElement.setA0001(YwglConstants.INSPECTION_RANG_NAME_INSTRUCTIONS);
                    tableOfficeElementService.save(tableOfficeElement);
            	}
            }
        }


    }
    @Transactional(readOnly = false)
    public void updateInspection(InstructionsSupervision table){
        specialSupervisionDao.updateInspection(table);
    }
}
