package com.tfkj.business.specialReport.service;

import com.tfkj.business.specialReport.dao.SpecialReportDao;
import com.tfkj.business.specialReport.entity.SpecialReport;
import com.tfkj.business.ywgl.dao.TableOfficeElementDao;
import com.tfkj.business.ywgl.service.TableOfficeElementService;
import com.tfkj.framework.core.service.CrudService;
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
public class SpecialReportService extends CrudService<SpecialReportDao, SpecialReport> {

    @Autowired
    private SpecialReportDao specialSupervisionDao;
    @Autowired
    private TableOfficeElementDao tableOfficeElementDao;

    @Autowired
    private TableOfficeElementService tableOfficeElementService;

}
