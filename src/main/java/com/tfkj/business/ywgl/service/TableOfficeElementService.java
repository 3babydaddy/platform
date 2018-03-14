package com.tfkj.business.ywgl.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tfkj.business.ywgl.dao.TableOfficeElementDao;
import com.tfkj.business.ywgl.entity.TableOfficeElement;
import com.tfkj.framework.core.service.CrudService;

/**
 * @Description: 表格单位
 * @author gaowei
 * @date 2018年1月16日
 */
@Service
@Transactional(readOnly = false)
public class TableOfficeElementService extends CrudService<TableOfficeElementDao, TableOfficeElement> {
}
