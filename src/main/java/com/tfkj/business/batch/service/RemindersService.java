package com.tfkj.business.batch.service;

import com.tfkj.business.Inspection.entity.RelationPo;
import com.tfkj.business.batch.dao.RemindersDao;
import com.tfkj.business.batch.entity.Reminders;
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
public class RemindersService extends CrudService<RemindersDao, Reminders> {

}
